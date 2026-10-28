// Stock du frigo, du congélateur et des placards (SPEC-V2 §5 à §8).
// Fonctions pures : sorties min(besoin, stock), ordre DLC puis ancienneté,
// réservation chronologique pour la liste, bonus anti-gaspillage.

import 'dart:math';

import 'enums.dart';
import 'models.dart';
import 'nutrition.dart';
import 'quantities.dart';
import 'shopping.dart';

enum StockLocation {
  fridge('fridge'),
  freezer('freezer'),
  pantry('pantry');

  const StockLocation(this.code);
  final String code;
  static StockLocation fromCode(String c) =>
      values.firstWhere((v) => v.code == c);
}

/// Emplacement déduit du rayon (modifiable ensuite).
StockLocation defaultLocation(Ingredient? ing) {
  if (ing == null) return StockLocation.pantry;
  return switch (ing.aisle) {
    Aisle.frozen => StockLocation.freezer,
    Aisle.dairy || Aisle.meatFish => StockLocation.fridge,
    Aisle.produce =>
      ing.perishable ? StockLocation.fridge : StockLocation.pantry,
    _ => StockLocation.pantry,
  };
}

/// Unité d'un lot : g, ml ou pièces.
enum StockUnit {
  g('g', Dimension.mass),
  ml('ml', Dimension.volume),
  piece('piece', Dimension.count);

  const StockUnit(this.code, this.dimension);
  final String code;
  final Dimension dimension;
  static StockUnit fromCode(String c) => values.firstWhere((v) => v.code == c);
  static StockUnit forDimension(Dimension d) => switch (d) {
    Dimension.volume => StockUnit.ml,
    Dimension.count => StockUnit.piece,
    _ => StockUnit.g,
  };
}

class StockLot {
  const StockLot({
    this.id,
    this.barcode,
    this.ingredientId,
    required this.label,
    required this.quantity,
    required this.unit,
    required this.location,
    required this.addedAt,
    this.bestBefore,
  });

  final int? id;
  final String? barcode;
  final String? ingredientId;
  final String label;

  /// Quantité restante, jamais négative.
  final double quantity;
  final StockUnit unit;
  final StockLocation location;
  final DateTime addedAt;
  final DateTime? bestBefore;

  StockLot copyWith({
    int? id,
    double? quantity,
    StockLocation? location,
    DateTime? bestBefore,
    bool clearBestBefore = false,
    String? ingredientId,
  }) => StockLot(
    id: id ?? this.id,
    barcode: barcode,
    ingredientId: ingredientId ?? this.ingredientId,
    label: label,
    quantity: max(0, quantity ?? this.quantity),
    unit: unit,
    location: location ?? this.location,
    addedAt: addedAt,
    bestBefore: clearBestBefore ? null : (bestBefore ?? this.bestBefore),
  );

  /// DLC dans [days] jours ou dépassée.
  bool expiresWithin(DateTime today, int days) {
    if (bestBefore == null) return false;
    final t = DateTime(today.year, today.month, today.day);
    return !bestBefore!.isAfter(t.add(Duration(days: days)));
  }
}

enum MovementKind {
  scanIn('scan_in'),
  manualIn('manual_in'),
  mealOut('meal_out'),
  eatenOut('eaten_out'),
  adjust('adjust'),
  undo('undo');

  const MovementKind(this.code);
  final String code;
  static MovementKind fromCode(String c) =>
      values.firstWhere((v) => v.code == c);
}

/// Mouvement du journal de stock. [delta] est signé, dans l'unité du lot.
class StockMovement {
  const StockMovement({
    this.id,
    required this.lotId,
    required this.delta,
    required this.kind,
    required this.at,
    this.completionId,
    this.logEntryId,
    this.label,
  });

  final int? id;
  final int lotId;
  final double delta;
  final MovementKind kind;
  final DateTime at;

  /// Repas fait à l'origine de la sortie (pour l'annulation).
  final int? completionId;

  /// Entrée « j'ai mangé » à l'origine de la sortie.
  final int? logEntryId;
  final String? label;
}

/// Quantité [a] exprimée dans l'unité [target] pour [ing] : pièces ↔ grammes
/// via le poids moyen, millilitres ↔ grammes via la densité, pincées en
/// grammes. Null si la conversion est impossible.
double? convertAmount(Ingredient? ing, Amount a, StockUnit target) {
  final from = a.dimension;
  if (from == target.dimension) return a.value;
  double? grams;
  if (from == Dimension.mass) {
    grams = a.value;
  } else if (ing != null) {
    grams = gramsOfAmount(ing, a);
  }
  if (grams == null) return null;
  switch (target) {
    case StockUnit.g:
      return grams;
    case StockUnit.ml:
      return grams / (ing?.density ?? 1);
    case StockUnit.piece:
      final w = ing?.avgPieceWeightG;
      return (w == null || w <= 0) ? null : grams / w;
  }
}

/// Ordre de sortie : DLC la plus proche d'abord (sans DLC en dernier), puis
/// le lot le plus ancien.
int compareForWithdrawal(StockLot a, StockLot b) {
  if (a.bestBefore != null && b.bestBefore != null) {
    final c = a.bestBefore!.compareTo(b.bestBefore!);
    if (c != 0) return c;
  } else if (a.bestBefore != null) {
    return -1;
  } else if (b.bestBefore != null) {
    return 1;
  }
  final c = a.addedAt.compareTo(b.addedAt);
  return c != 0 ? c : (a.id ?? 0).compareTo(b.id ?? 0);
}

class Withdrawal {
  const Withdrawal(this.lotId, this.quantity);
  final int lotId;

  /// Quantité retirée, dans l'unité du lot (positive).
  final double quantity;

  @override
  String toString() => 'Withdrawal($lotId, $quantity)';
}

/// Sortie de [need] pour [ing] depuis [lots] (tous lots confondus, filtrés
/// sur l'ingrédient ici) : on retire min(besoin, stock disponible), jamais
/// plus, dans l'ordre DLC puis ancienneté. Le manque n'est pas une erreur.
List<Withdrawal> planWithdrawal(
  Ingredient ing,
  Amount need,
  Iterable<StockLot> lots,
) {
  final candidates =
      lots
          .where(
            (l) => l.ingredientId == ing.id && l.quantity > 0 && l.id != null,
          )
          .toList()
        ..sort(compareForWithdrawal);
  var remaining = need.value;
  final out = <Withdrawal>[];
  for (final lot in candidates) {
    if (remaining <= 1e-9) break;
    // Besoin restant converti dans l'unité du lot.
    final needInLot = convertAmount(
      ing,
      Amount(need.dimension, remaining),
      lot.unit,
    );
    if (needInLot == null || needInLot <= 0) continue;
    final take = min(needInLot, lot.quantity);
    out.add(Withdrawal(lot.id!, take));
    // La conversion est linéaire : on retire la même proportion du besoin.
    remaining -= remaining * (take / needInLot);
  }
  return out;
}

/// Besoins par ingrédient d'une recette pour [servings] portions, en unités
/// de base. Facultatifs compris ; ajustements appliqués.
Map<String, List<Amount>> recipeNeeds(
  Recipe r,
  int servings, {
  Set<String> excluded = const {},
  Map<String, Ingredient> replacements = const {},
}) {
  final factor = servings / r.servings;
  final out = <String, List<Amount>>{};
  for (final ri in r.ingredients) {
    if (excluded.contains(ri.ingredient.id)) continue;
    final ing = replacements[ri.ingredient.id] ?? ri.ingredient;
    (out[ing.id] ??= []).add(toBase(ri.qty, ri.unit).scaled(factor));
  }
  return out;
}

/// Sorties de stock pour un repas cuisiné (SPEC-V2 §6).
List<Withdrawal> planMealWithdrawals(
  Recipe r,
  int cookedServings,
  List<StockLot> lots,
  Map<String, Ingredient> catalogue, {
  Set<String> excluded = const {},
  Map<String, Ingredient> replacements = const {},
}) {
  final working = [...lots];
  final out = <Withdrawal>[];
  final needs = recipeNeeds(
    r,
    cookedServings,
    excluded: excluded,
    replacements: replacements,
  );
  for (final e in needs.entries) {
    final ing = catalogue[e.key] ?? _ingredientOf(r, e.key, replacements);
    if (ing == null) continue;
    for (final a in mergeAmounts(ing, e.value)) {
      final ws = planWithdrawal(ing, a, working);
      for (final w in ws) {
        out.add(w);
        final i = working.indexWhere((l) => l.id == w.lotId);
        working[i] = working[i].copyWith(
          quantity: working[i].quantity - w.quantity,
        );
      }
    }
  }
  return out;
}

Ingredient? _ingredientOf(
  Recipe r,
  String id,
  Map<String, Ingredient> replacements,
) {
  for (final i in replacements.values) {
    if (i.id == id) return i;
  }
  for (final ri in r.ingredients) {
    if (ri.ingredient.id == id) return ri.ingredient;
  }
  return null;
}

/// Calories de ma part d'un repas fait : recette complète telle que prévue
/// (même si le stock manquait), ajustements compris, × parts mangées.
Macros mealPortionMacros(
  Recipe r, {
  double portions = 1,
  Set<String> excluded = const {},
  Map<String, Ingredient> replacements = const {},
}) => recipeMacros(
  r,
  excluded: excluded,
  replacements: replacements,
).scaled(portions / r.servings);

/// Stock disponible d'un ingrédient, dans la dimension [d].
double availableIn(Ingredient ing, Dimension d, Iterable<StockLot> lots) {
  var total = 0.0;
  for (final l in lots) {
    if (l.ingredientId != ing.id || l.quantity <= 0) continue;
    final v = convertAmount(
      ing,
      Amount(l.unit.dimension, l.quantity),
      StockUnit.forDimension(d),
    );
    if (v != null) total += v;
  }
  return total;
}

/// Un usage chronologique d'une recette (créneau pas encore fait ou extra).
class PlannedUse {
  const PlannedUse({required this.recipe, required this.servings, this.slot});
  final Recipe recipe;
  final int servings;

  /// Créneau d'origine ; null pour un extra.
  final SlotKey? slot;
}

/// Résultat de la réservation du stock pour la semaine.
class StockPlan {
  const StockPlan({
    required this.toBuy,
    required this.inStock,
    required this.coverage,
  });

  /// Manque, arrondi pour l'affichage.
  final List<ShoppingLine> toBuy;

  /// Ce que le stock couvre.
  final List<ShoppingLine> inStock;

  /// Par usage (même ordre que l'entrée) : ingrédients couverts / total.
  final List<(int, int)> coverage;
}

/// Liste = besoin (V1) − stock disponible, le stock étant réservé dans
/// l'ordre chronologique des usages (SPEC-V2 §7).
StockPlan planShoppingWithStock(List<PlannedUse> uses, List<StockLot> lots) {
  // Stock restant par ingrédient et dimension, consommé au fil des usages.
  final remaining = <String, double>{};
  double left(Ingredient ing, Dimension d) => remaining.putIfAbsent(
    lineKey(ing.id, d),
    () => availableIn(ing, d, lots),
  );

  final missing = <String, List<Amount>>{};
  final covered = <String, List<Amount>>{};
  final ingredients = <String, Ingredient>{};
  final titles = <String, List<String>>{};
  final optional = <String, bool>{};
  final coverage = <(int, int)>[];

  for (final use in uses) {
    var ok = 0, total = 0;
    final factor = use.servings / use.recipe.servings;
    final perIng = <String, List<Amount>>{};
    for (final ri in use.recipe.ingredients) {
      final id = ri.ingredient.id;
      ingredients[id] = ri.ingredient;
      (perIng[id] ??= []).add(toBase(ri.qty, ri.unit).scaled(factor));
      final t = titles[id] ??= [];
      if (!t.contains(use.recipe.title)) t.add(use.recipe.title);
      optional[id] = (optional[id] ?? true) && ri.optional;
    }
    for (final e in perIng.entries) {
      final ing = ingredients[e.key]!;
      var fully = true;
      for (final a in mergeAmounts(ing, e.value)) {
        final key = lineKey(ing.id, a.dimension);
        final have = left(ing, a.dimension);
        final take = min(have, a.value);
        remaining[key] = have - take;
        if (take > 0) {
          (covered[e.key] ??= []).add(Amount(a.dimension, take));
        }
        if (a.value - take > 1e-9) {
          fully = false;
          (missing[e.key] ??= []).add(Amount(a.dimension, a.value - take));
        }
      }
      if (!ing.pantry) {
        total++;
        if (fully) ok++;
      }
    }
    coverage.add((ok, total));
  }

  List<ShoppingLine> lines(Map<String, List<Amount>> src) {
    final out = <ShoppingLine>[];
    for (final e in src.entries) {
      final ing = ingredients[e.key]!;
      for (final a in mergeAmounts(ing, e.value)) {
        out.add(
          ShoppingLine(
            ingredient: ing,
            amount: roundForShopping(a, ing),
            recipeTitles: titles[e.key]!,
            optional: optional[e.key]!,
          ),
        );
      }
    }
    out.sort((a, b) {
      final c = a.ingredient.aisle.index.compareTo(b.ingredient.aisle.index);
      return c != 0 ? c : a.ingredient.name.compareTo(b.ingredient.name);
    });
    return out;
  }

  return StockPlan(
    toBuy: lines(missing),
    inStock: lines(covered),
    coverage: coverage,
  );
}

/// Nombre de paquets à acheter pour couvrir [amount] avec un paquet de
/// [packageQty] [packageUnit] (« 1 paquet de 500 g »). Null si les unités ne
/// se convertissent pas.
int? packagesFor(
  Ingredient ing,
  Amount amount,
  double packageQty,
  StockUnit packageUnit,
) {
  if (packageQty <= 0) return null;
  final inPack = convertAmount(ing, amount, packageUnit);
  if (inPack == null) return null;
  return max(1, (inPack / packageQty - 1e-9).ceil());
}

/// Bonus anti-gaspillage (0 à 1) d'une recette : part de ses ingrédients
/// (hors placard) présents en stock, ceux qui sont périssables ou proches de
/// leur DLC comptant double (SPEC-V2 §8).
double stockAffinity(Recipe r, List<StockLot> lots, DateTime today) {
  var score = 0.0, total = 0;
  for (final ri in r.ingredients) {
    final ing = ri.ingredient;
    if (ing.pantry) continue;
    total += 2;
    final mine = lots.where((l) => l.ingredientId == ing.id && l.quantity > 0);
    if (mine.isEmpty) continue;
    final urgent = ing.perishable || mine.any((l) => l.expiresWithin(today, 3));
    score += urgent ? 2 : 1;
  }
  return total == 0 ? 0 : score / total;
}
