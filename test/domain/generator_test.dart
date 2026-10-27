import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/seed.dart';
import 'package:popote/domain/diet.dart';
import 'package:popote/domain/enums.dart';
import 'package:popote/domain/generator.dart';
import 'package:popote/domain/models.dart';

import '../helpers/seed_files.dart';
import 'fixtures.dart';

/// Vérifie toutes les contraintes dures du SPEC §3.6 sur un résultat.
void expectHardConstraints(
  GeneratorInput input,
  GeneratorResult res, {
  String reason = '',
}) {
  final p = input.profile;
  final byId = {for (final r in input.recipes) r.id: r};
  final seen = <int>{};
  var meat = 0;
  for (final s in res.slots) {
    if (s.kind == SlotKind.leftovers && s.leftoversFrom != null) {
      final src = res.slots.firstWhere((o) => o.key == s.leftoversFrom);
      if (src.recipeId != null && traitsOf(byId[src.recipeId]!).hasMeat) meat++;
    }
    if (s.kind != SlotKind.recipe || s.recipeId == null) continue;
    final r = byId[s.recipeId]!;
    final t = traitsOf(r);
    final locked = input.slots.any((o) => o.key == s.key && o.locked);
    if (t.hasMeat) meat++;
    expect(seen.add(r.id), isTrue, reason: '$reason doublon ${r.slug}');
    if (locked) continue;
    expect(r.type, RecipeType.main, reason: reason);
    expect(isCompatible(r, t, p), isTrue, reason: '$reason ${r.slug}');
    expect(
      (input.states[r.id] ?? RecipeUserState.none).disliked,
      isFalse,
      reason: reason,
    );
    final max = isWeekend(dayDate(input.weekStart, s.key.day))
        ? p.maxMinWeekend
        : p.maxMinWeekday;
    expect(r.totalMin, lessThanOrEqualTo(max), reason: '$reason ${r.slug}');
  }
  if (p.diet == Diet.flexitarian) {
    expect(
      meat,
      lessThanOrEqualTo(HouseholdProfile.flexitarianMeatMax),
      reason: reason,
    );
  }
}

void main() {
  late List<Recipe> seedRecipes;

  setUpAll(() async {
    final seed = await loadSeed(FileSeedSource());
    final cat = {for (final i in seed.ingredients) i.id: i};
    var id = 1;
    seedRecipes = [for (final r in seed.recipes) r.toRecipe(cat, id: id++)];
  });

  GeneratorInput input(
    HouseholdProfile p, {
    int seed = 1,
    Map<int, RecipeUserState> states = const {},
    List<MenuSlot> slots = const [],
    Set<int> recent = const {},
    List<Recipe>? recipes,
  }) => GeneratorInput(
    recipes: recipes ?? seedRecipes,
    states: states,
    profile: p,
    weekStart: monday,
    slots: slots,
    recentRecipeIds: recent,
    seed: seed,
  );

  group('contraintes dures sur 200 graines', () {
    final profiles = <String, HouseholdProfile Function()>{
      'omnivore midi et soir': () => HouseholdProfile(activeSlots: allSlots()),
      'flexitarien': () =>
          HouseholdProfile(diet: Diet.flexitarian, activeSlots: allSlots()),
      'pescétarien sans porc': () =>
          HouseholdProfile(diet: Diet.pescetarian, noPork: true),
      'végétarien sans lait ni œufs': () => HouseholdProfile(
        diet: Diet.vegetarian,
        exclusions: {Allergen.milk, Allergen.eggs},
      ),
      'végan + sans gluten + sans four': () => HouseholdProfile(
        diet: Diet.vegan,
        exclusions: {Allergen.gluten},
        equipment: {Equipment.hob, Equipment.microwave, Equipment.blender},
      ),
      'aversions et 20 min en semaine': () => HouseholdProfile(
        aversions: {'oignon-jaune', 'poivron-rouge', 'champignon-de-paris'},
        maxMinWeekday: 20,
        activeSlots: allSlots(),
      ),
    };
    for (final e in profiles.entries) {
      test(e.key, () {
        final p = e.value();
        for (var seed = 0; seed < 200; seed++) {
          final i = input(p, seed: seed);
          final res = generateMenu(i);
          expectHardConstraints(i, res, reason: '${e.key} graine $seed');
        }
      });
    }

    test('les recettes « pas aimées » ne sont jamais proposées', () {
      final p = HouseholdProfile(diet: Diet.vegan);
      final disliked = {
        for (final r in seedRecipes.take(80))
          r.id: const RecipeUserState(disliked: true),
      };
      for (var seed = 0; seed < 200; seed++) {
        final i = input(p, seed: seed, states: disliked);
        final res = generateMenu(i);
        for (final s in res.slots) {
          expect(disliked.containsKey(s.recipeId), isFalse);
        }
      }
    });
  });

  test('déterministe pour une graine donnée', () {
    final p = HouseholdProfile(activeSlots: allSlots());
    final a = generateMenu(input(p, seed: 42)).slots.map((s) => s.recipeId);
    final b = generateMenu(input(p, seed: 42)).slots.map((s) => s.recipeId);
    final c = generateMenu(input(p, seed: 43)).slots.map((s) => s.recipeId);
    expect(a, b);
    expect(a, isNot(c));
  });

  test('remplit tous les créneaux actifs quand c’est possible', () {
    final res = generateMenu(input(HouseholdProfile(activeSlots: allSlots())));
    expect(res.unfilled, isEmpty);
    expect(res.slots.where((s) => s.kind == SlotKind.recipe), hasLength(14));
    expect(res.slots.every((s) => s.servings == 2), isTrue);
  });

  test('respecte les créneaux verrouillés, restes et dehors', () {
    final p = HouseholdProfile();
    final locked = seedRecipes.firstWhere((r) => r.type == RecipeType.main);
    final slots = [
      MenuSlot(
        key: const SlotKey(0, Meal.dinner),
        kind: SlotKind.recipe,
        recipeId: locked.id,
        locked: true,
        servings: 4,
      ),
      const MenuSlot(
        key: SlotKey(1, Meal.dinner),
        kind: SlotKind.leftovers,
        leftoversFrom: SlotKey(0, Meal.dinner),
      ),
      const MenuSlot(key: SlotKey(2, Meal.dinner), kind: SlotKind.eatingOut),
    ];
    for (var seed = 0; seed < 50; seed++) {
      final res = generateMenu(input(p, seed: seed, slots: slots));
      expect(res.slots[0].recipeId, locked.id);
      expect(res.slots[0].servings, 4);
      expect(res.slots[1].kind, SlotKind.leftovers);
      expect(res.slots[2].kind, SlotKind.eatingOut);
      expect(
        res.slots.where((s) => s.recipeId == locked.id),
        hasLength(1),
        reason: 'pas de doublon de la recette verrouillée',
      );
    }
  });

  test('place les recettes « à caser »', () {
    final p = HouseholdProfile();
    final toPlace = seedRecipes
        .where((r) => r.type == RecipeType.main && r.totalMin <= 30)
        .where((r) => isCompatible(r, traitsOf(r), p))
        .take(4)
        .toList();
    final states = {
      for (final r in toPlace) r.id: const RecipeUserState(toPlace: true),
    };
    for (var seed = 0; seed < 200; seed++) {
      final res = generateMenu(input(p, seed: seed, states: states));
      final placed = res.slots.map((s) => s.recipeId).toSet();
      for (final r in toPlace) {
        expect(placed, contains(r.id), reason: 'graine $seed ${r.slug}');
      }
    }
  });

  test('atteint la part de favoris visée', () {
    final p = HouseholdProfile(activeSlots: allSlots(), favoriteShare: 0.4);
    final favs = seedRecipes
        .where((r) => r.type == RecipeType.main && r.totalMin <= 30)
        .take(12)
        .toList();
    final states = {
      for (final r in favs) r.id: const RecipeUserState(favorite: true),
    };
    final target = (0.4 * 14).round();
    for (var seed = 0; seed < 200; seed++) {
      final res = generateMenu(input(p, seed: seed, states: states));
      final n = res.slots.where((s) => states.containsKey(s.recipeId)).length;
      expect(n, target, reason: 'graine $seed');
    }
  });

  test('anti-répétition : pas de recette des 2 semaines précédentes', () {
    final p = HouseholdProfile();
    final recent = {
      for (final r
          in seedRecipes.where((r) => r.type == RecipeType.main).take(60))
        r.id,
    };
    for (var seed = 0; seed < 200; seed++) {
      final res = generateMenu(input(p, seed: seed, recent: recent));
      for (final s in res.slots) {
        expect(recent.contains(s.recipeId), isFalse, reason: 'graine $seed');
      }
    }
  });

  test('variété : pas la même base sur deux créneaux consécutifs', () {
    final p = HouseholdProfile(activeSlots: allSlots());
    final byId = {for (final r in seedRecipes) r.id: r};
    var repeats = 0;
    for (var seed = 0; seed < 200; seed++) {
      final res = generateMenu(input(p, seed: seed));
      for (var i = 1; i < res.slots.length; i++) {
        if (byId[res.slots[i].recipeId]?.mainBase ==
            byId[res.slots[i - 1].recipeId]?.mainBase) {
          repeats++;
        }
      }
    }
    // Préférence et non contrainte dure : quasi jamais avec 140 plats.
    expect(repeats / (200 * 13), lessThan(0.02));
  });

  test('flexitarien : 3 repas avec viande au plus, restes compris', () {
    final p = HouseholdProfile(diet: Diet.flexitarian, activeSlots: allSlots());
    final meatRecipe = seedRecipes.firstWhere(
      (r) =>
          r.type == RecipeType.main && traitsOf(r).hasMeat && r.totalMin <= 30,
    );
    final slots = [
      MenuSlot(
        key: const SlotKey(0, Meal.dinner),
        kind: SlotKind.recipe,
        recipeId: meatRecipe.id,
        locked: true,
      ),
      const MenuSlot(
        key: SlotKey(1, Meal.lunch),
        kind: SlotKind.leftovers,
        leftoversFrom: SlotKey(0, Meal.dinner),
      ),
    ];
    for (var seed = 0; seed < 200; seed++) {
      final i = input(p, seed: seed, slots: slots);
      expectHardConstraints(i, generateMenu(i), reason: 'graine $seed');
    }
  });

  test('cas infaisable : remplit ce qu’il peut et compte les compatibles', () {
    final p = HouseholdProfile(
      diet: Diet.vegan,
      exclusions: {Allergen.gluten, Allergen.soy},
      equipment: {Equipment.microwave},
      activeSlots: allSlots(),
    );
    final res = generateMenu(input(p));
    expect(res.compatibleCount, lessThan(14));
    expect(res.unfilled, isNotEmpty);
    expect(
      res.slots.where((s) => s.kind == SlotKind.recipe).length +
          res.unfilled.length,
      14,
    );
  });

  test('aucune recette compatible : tout reste vide', () {
    final res = generateMenu(
      input(
        HouseholdProfile(diet: Diet.vegan),
        recipes: [
          recipe(1, [poulet]),
        ],
      ),
    );
    expect(res.compatibleCount, 0);
    expect(res.unfilled, hasLength(7));
  });

  test('plus rapide en semaine', () {
    final p = HouseholdProfile(activeSlots: allSlots(), maxMinWeekday: 60);
    final byId = {for (final r in seedRecipes) r.id: r};
    var weekday = 0.0, weekend = 0.0, nWd = 0, nWe = 0;
    for (var seed = 0; seed < 100; seed++) {
      for (final s in generateMenu(input(p, seed: seed)).slots) {
        final t = byId[s.recipeId]!.totalMin;
        if (s.key.day >= 5) {
          weekend += t;
          nWe++;
        } else {
          weekday += t;
          nWd++;
        }
      }
    }
    expect(weekday / nWd, lessThan(weekend / nWe));
  });

  test('alternatives : 3 recettes compatibles différentes du créneau', () {
    final p = HouseholdProfile();
    final res = generateMenu(input(p));
    final i = input(p, slots: res.slots, seed: 7);
    final alts = alternativesFor(input: i, key: const SlotKey(0, Meal.dinner));
    expect(alts, hasLength(3));
    final used = res.slots.map((s) => s.recipeId).toSet();
    for (final r in alts) {
      expect(used.contains(r.id), isFalse);
      expect(isCompatible(r, traitsOf(r), p), isTrue);
    }
  });

  test('performance : < 1 s pour 14 créneaux et 500 recettes', () {
    final many = [
      for (var k = 0; k < 4; k++)
        for (final r in seedRecipes) r.copyWith(id: r.id + k * 1000),
    ].take(500).toList();
    final sw = Stopwatch()..start();
    generateMenu(
      input(HouseholdProfile(activeSlots: allSlots()), recipes: many),
    );
    expect(sw.elapsedMilliseconds, lessThan(1000));
  });
}
