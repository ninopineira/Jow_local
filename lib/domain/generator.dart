import 'dart:math';

import 'diet.dart';
import 'enums.dart';
import 'models.dart';

class GeneratorInput {
  const GeneratorInput({
    required this.recipes,
    required this.states,
    required this.profile,
    required this.weekStart,
    required this.slots,
    this.recentRecipeIds = const {},
    required this.seed,
    this.stockAffinity = const {},
    this.stockWeight = 10,
  });

  final List<Recipe> recipes;
  final Map<int, RecipeUserState> states;
  final HouseholdProfile profile;
  final DateTime weekStart;

  /// Créneaux existants de la semaine (verrouillés, restes, dehors…).
  final List<MenuSlot> slots;

  /// Recettes planifiées pendant l'horizon anti-répétition.
  final Set<int> recentRecipeIds;
  final int seed;

  /// Bonus anti-gaspillage par recette (0 à 1), calculé depuis le stock
  /// (SPEC-V2 §8). Jamais une contrainte dure.
  final Map<int, double> stockAffinity;

  /// Poids du bonus de stock (réglable [H]).
  final double stockWeight;
}

class GeneratorResult {
  const GeneratorResult({
    required this.slots,
    required this.unfilled,
    required this.compatibleCount,
  });

  /// Tous les créneaux actifs de la semaine, triés.
  final List<MenuSlot> slots;

  /// Créneaux restés vides faute de recette compatible.
  final List<SlotKey> unfilled;

  /// Nombre de plats compatibles avec le profil (régime, exclusions,
  /// aversions, équipements, hors « pas aimées »), pour l'explication.
  final int compatibleCount;
}

/// Poids des préférences. L'ordre de grandeur fixe les priorités :
/// anti-répétition > part de favoris > variété > saison ≈ anti-gaspillage >
/// rapidité > hasard.
class _W {
  static const recent = -80.0;
  static const favoriteBelowTarget = 50.0;
  static const favoriteAboveTarget = -50.0;
  static const sameBaseAdjacent = -20.0;
  static const season = 12.0;
  static const sharedPerishable = 4.0;
  static const sharedPerishableMax = 12.0;
  static const weekdaySlowness = -8.0;
  static const noise = 6.0;
}

/// Générateur de menu (SPEC §3.6) : fonction pure, déterministe pour une
/// graine donnée.
///
/// Les créneaux actifs vides ou contenant une recette non verrouillée sont
/// (re)remplis ; les créneaux verrouillés, « restes » et « dehors » sont
/// conservés.
GeneratorResult generateMenu(GeneratorInput input) {
  final rnd = Random(input.seed);
  final p = input.profile;
  final month = dayDate(input.weekStart, 3).month;

  final existing = {for (final s in input.slots) s.key: s};
  final keys = p.activeSlots.toList()..sort();
  // Les créneaux non actifs mais remplis à la main restent dans la semaine.
  for (final s in input.slots) {
    if (!p.activeSlots.contains(s.key) && s.kind != SlotKind.empty) {
      keys.add(s.key);
    }
  }
  keys.sort();

  final byId = {for (final r in input.recipes) r.id: r};
  final traits = {for (final r in input.recipes) r.id: traitsOf(r)};

  // Contraintes dures statiques.
  final compatible = input.recipes.where((r) {
    if (r.type != RecipeType.main) return false;
    if ((input.states[r.id] ?? RecipeUserState.none).disliked) return false;
    return isCompatible(r, traits[r.id]!, p);
  }).toList();

  final perishables = {
    for (final r in compatible)
      r.id: {
        for (final ri in r.ingredients)
          if (ri.ingredient.perishable && !ri.ingredient.pantry)
            ri.ingredient.id,
      },
  };

  final assigned = <SlotKey, MenuSlot>{};
  final toFill = <SlotKey>[];
  for (final k in keys) {
    final s = existing[k];
    final keep =
        s != null &&
        (s.locked ||
            s.kind == SlotKind.leftovers ||
            s.kind == SlotKind.eatingOut ||
            (s.kind == SlotKind.recipe && !p.activeSlots.contains(k)));
    if (keep) {
      assigned[k] = s;
    } else {
      toFill.add(k);
    }
  }

  int servingsFor(SlotKey k) => existing[k]?.servings ?? p.people;

  int? recipeAt(SlotKey k) {
    final s = assigned[k];
    if (s == null) return null;
    if (s.kind == SlotKind.recipe) return s.recipeId;
    if (s.kind == SlotKind.leftovers && s.leftoversFrom != null) {
      return recipeAt(s.leftoversFrom!);
    }
    return null;
  }

  bool countsAsMeal(MenuSlot s) =>
      s.kind == SlotKind.recipe || s.kind == SlotKind.leftovers;

  final used = <int>{
    for (final s in assigned.values)
      if (s.kind == SlotKind.recipe && s.recipeId != null) s.recipeId!,
  };

  int meatMeals() {
    var n = 0;
    for (final s in assigned.values) {
      if (!countsAsMeal(s)) continue;
      final id = recipeAt(s.key);
      if (id != null && (traits[id]?.hasMeat ?? false)) n++;
    }
    return n;
  }

  int maxMinFor(SlotKey k) => isWeekend(dayDate(input.weekStart, k.day))
      ? p.maxMinWeekend
      : p.maxMinWeekday;

  // Créneaux « restes » qui mangeront la recette placée en k.
  int leftoverDependents(SlotKey k) => assigned.values
      .where((s) => s.kind == SlotKind.leftovers && s.leftoversFrom == k)
      .length;

  bool feasible(Recipe r, SlotKey k) {
    if (used.contains(r.id)) return false;
    if (r.totalMin > maxMinFor(k)) return false;
    if (p.diet == Diet.flexitarian &&
        traits[r.id]!.hasMeat &&
        meatMeals() + 1 + leftoverDependents(k) >
            HouseholdProfile.flexitarianMeatMax) {
      return false;
    }
    return true;
  }

  void place(Recipe r, SlotKey k) {
    assigned[k] = MenuSlot(
      key: k,
      kind: SlotKind.recipe,
      recipeId: r.id,
      servings: servingsFor(k),
    );
    used.add(r.id);
  }

  // 1. « À caser » d'abord, les plus contraintes en premier.
  final toPlace =
      compatible
          .where((r) => (input.states[r.id] ?? RecipeUserState.none).toPlace)
          .where((r) => !used.contains(r.id))
          .toList()
        ..shuffle(rnd);
  int optionsOf(Recipe r) =>
      toFill.where((k) => !assigned.containsKey(k) && feasible(r, k)).length;
  toPlace.sort((a, b) => optionsOf(a).compareTo(optionsOf(b)));
  for (final r in toPlace) {
    final options = toFill
        .where((k) => !assigned.containsKey(k) && feasible(r, k))
        .toList();
    if (options.isEmpty) continue;
    place(r, options[rnd.nextInt(options.length)]);
  }

  // 2. Reste des créneaux, dans l'ordre chronologique, au meilleur score.
  final mealSlots = keys.where((k) {
    final s = assigned[k];
    return s == null || countsAsMeal(s);
  }).length;
  final favoriteTarget = (p.favoriteShare * mealSlots).round();
  int favoriteCount() => used
      .where((id) => (input.states[id] ?? RecipeUserState.none).favorite)
      .length;

  MainBase? baseAt(SlotKey k) {
    final id = recipeAt(k);
    return id == null ? null : byId[id]?.mainBase;
  }

  SlotKey? neighbour(SlotKey k, int delta) {
    final i = keys.indexOf(k) + delta;
    return i >= 0 && i < keys.length ? keys[i] : null;
  }

  final unfilled = <SlotKey>[];
  for (final k in toFill) {
    if (assigned.containsKey(k)) continue;
    final weekend = isWeekend(dayDate(input.weekStart, k.day));
    final usedPerishables = <String>{
      for (final id in used) ...?perishables[id],
    };
    final prev = neighbour(k, -1);
    final next = neighbour(k, 1);
    final adjacentBases = {
      if (prev != null) baseAt(prev),
      if (next != null) baseAt(next),
    }..remove(null);
    final favBelow = favoriteCount() < favoriteTarget;

    Recipe? best;
    var bestScore = double.negativeInfinity;
    for (final r in compatible) {
      if (!feasible(r, k)) continue;
      final st = input.states[r.id] ?? RecipeUserState.none;
      var score = rnd.nextDouble() * _W.noise;
      if (input.recentRecipeIds.contains(r.id)) score += _W.recent;
      if (st.favorite) {
        score += favBelow ? _W.favoriteBelowTarget : _W.favoriteAboveTarget;
      }
      if (adjacentBases.contains(r.mainBase)) score += _W.sameBaseAdjacent;
      score += _W.season * seasonRatio(r, month);
      score += input.stockWeight * (input.stockAffinity[r.id] ?? 0);
      final shared = perishables[r.id]!.intersection(usedPerishables).length;
      score += min(shared * _W.sharedPerishable, _W.sharedPerishableMax);
      if (!weekend) {
        score += _W.weekdaySlowness * (r.totalMin / max(1, p.maxMinWeekday));
      }
      if (score > bestScore) {
        bestScore = score;
        best = r;
      }
    }
    if (best == null) {
      unfilled.add(k);
    } else {
      place(best, k);
    }
  }

  final result = [
    for (final k in keys)
      assigned[k] ?? MenuSlot(key: k, servings: servingsFor(k)),
  ];
  return GeneratorResult(
    slots: result,
    unfilled: unfilled,
    compatibleCount: compatible.length,
  );
}

/// Alternatives compatibles pour remplacer un créneau (SPEC §3.5).
List<Recipe> alternativesFor({
  required GeneratorInput input,
  required SlotKey key,
  int count = 3,
}) {
  final p = input.profile;
  final rnd = Random(input.seed);
  final used = {
    for (final s in input.slots)
      if (s.kind == SlotKind.recipe && s.key != key && s.recipeId != null)
        s.recipeId!,
  };
  final current = input.slots
      .where((s) => s.key == key)
      .map((s) => s.recipeId)
      .firstOrNull;
  final maxMin = isWeekend(dayDate(input.weekStart, key.day))
      ? p.maxMinWeekend
      : p.maxMinWeekday;
  final candidates = input.recipes.where((r) {
    if (r.type != RecipeType.main || r.id == current) return false;
    if (used.contains(r.id) || r.totalMin > maxMin) return false;
    if ((input.states[r.id] ?? RecipeUserState.none).disliked) return false;
    return isCompatible(r, traitsOf(r), p);
  }).toList()..shuffle(rnd);
  candidates.sort((a, b) {
    final ra = input.recentRecipeIds.contains(a.id) ? 1 : 0;
    final rb = input.recentRecipeIds.contains(b.id) ? 1 : 0;
    return ra.compareTo(rb);
  });
  return candidates.take(count).toList();
}
