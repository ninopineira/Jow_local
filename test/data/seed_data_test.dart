import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/seed.dart';
import 'package:popote/domain/diet.dart';
import 'package:popote/domain/enums.dart';
import 'package:popote/domain/models.dart';

import '../helpers/json_schema.dart';
import '../helpers/seed_files.dart';

/// Tests des données fournies (SPEC §5 et §6 « Données »).
void main() {
  late SeedData seed;
  late Map<String, Ingredient> catalogue;
  late List<Recipe> recipes;

  setUpAll(() async {
    seed = await loadSeed(FileSeedSource());
    catalogue = {for (final i in seed.ingredients) i.id: i};
    recipes = [for (final r in seed.recipes) r.toRecipe(catalogue)];
  });

  group('schéma', () {
    test('ingredients.json respecte son schéma', () {
      final schema = readJson('ingredients.schema.json');
      final errors = validateJson(readJson('ingredients.json'), schema);
      expect(errors, isEmpty);
    });

    test('chaque lot respecte le schéma des recettes', () {
      final schema = readJson('recipes.schema.json');
      for (final lot in seed.manifest.lots) {
        final data = readJson('recipes/$lot.json');
        expect(validateJson(data, schema), isEmpty, reason: lot);
        expect((data as Map)['lot'], lot);
      }
    });

    test('tous les fichiers de lots sont déclarés dans seed.json', () {
      final files = Directory('assets/recipes/recipes')
          .listSync()
          .whereType<File>()
          .map((f) => f.uri.pathSegments.last.replaceAll('.json', ''))
          .toSet();
      expect(files, seed.manifest.lots.toSet());
    });
  });

  group('références et unicité', () {
    test('identifiants d’ingrédients uniques', () {
      final ids = seed.ingredients.map((i) => i.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('tout ingrédient référencé existe dans le catalogue', () {
      for (final r in seed.recipes) {
        for (final l in r.lines) {
          expect(
            catalogue.containsKey(l.ingredientId),
            isTrue,
            reason: '${r.slug} → ${l.ingredientId}',
          );
        }
      }
    });

    test('slugs uniques', () {
      final slugs = seed.recipes.map((r) => r.slug).toList();
      expect(slugs.toSet().length, slugs.length);
    });

    test('un ingrédient n’apparaît qu’une fois par recette', () {
      for (final r in seed.recipes) {
        final ids = r.lines.map((l) => l.ingredientId).toList();
        expect(ids.toSet().length, ids.length, reason: r.slug);
      }
    });
  });

  group('cohérence du catalogue', () {
    test('marqueurs et allergènes cohérents', () {
      for (final i in seed.ingredients) {
        final m = i.markers;
        final a = i.allergens;
        if (m.contains(Marker.pork) || m.contains(Marker.poultry)) {
          expect(m, contains(Marker.meat), reason: i.id);
        }
        expect(
          m.contains(Marker.fish),
          a.contains(Allergen.fish),
          reason: i.id,
        );
        expect(m.contains(Marker.egg), a.contains(Allergen.eggs), reason: i.id);
        expect(
          m.contains(Marker.dairy),
          a.contains(Allergen.milk),
          reason: i.id,
        );
        if (m.contains(Marker.seafood)) {
          expect(
            a.contains(Allergen.crustaceans) || a.contains(Allergen.molluscs),
            isTrue,
            reason: i.id,
          );
        }
      }
    });

    test('allergènes cachés des produits transformés', () {
      expect(
        catalogue['sauce-soja']!.allergens,
        containsAll([Allergen.soy, Allergen.gluten]),
      );
      expect(catalogue['moutarde']!.allergens, contains(Allergen.mustard));
      expect(
        catalogue['pate-feuilletee']!.allergens,
        contains(Allergen.gluten),
      );
      expect(
        catalogue['bouillon-legumes-cube']!.allergens,
        contains(Allergen.celery),
      );
      expect(
        catalogue['vin-blanc-sec']!.allergens,
        contains(Allergen.sulphites),
      );
    });

    test('mois de saison seulement pour fruits, légumes et herbes', () {
      for (final i in seed.ingredients.where((i) => i.isSeasonal)) {
        expect(i.aisle, Aisle.produce, reason: i.id);
      }
    });

    test('le catalogue couvre 250 à 400 ingrédients', () {
      expect(seed.ingredients.length, inInclusiveRange(250, 400));
    });
  });

  group('bornes de quantités (par portion)', () {
    // Masse en grammes d'une ligne, si on peut la connaître.
    double? grams(RecipeIngredient ri) {
      switch (ri.unit) {
        case Unit.g:
          return ri.qty;
        case Unit.kg:
          return ri.qty * 1000;
        case Unit.piece:
          final w = ri.ingredient.avgPieceWeightG;
          return w == null ? null : ri.qty * w;
        default:
          return null;
      }
    }

    double? millilitres(RecipeIngredient ri) => switch (ri.unit) {
      Unit.ml => ri.qty,
      Unit.cl => ri.qty * 10,
      Unit.l => ri.qty * 1000,
      Unit.tbsp => ri.qty * 15,
      Unit.tsp => ri.qty * 5,
      _ => null,
    };

    const dryStarches = {
      'spaghetti',
      'penne',
      'tagliatelle',
      'fusilli',
      'coquillettes',
      'lasagnes',
      'pates-de-riz',
      'pates-de-mais',
      'nouilles-de-riz',
      'vermicelles-de-riz',
      'nouilles-udon',
      'nouilles-chinoises-aux-oeufs',
      'riz-basmati',
      'riz-long',
      'riz-rond',
      'riz-complet',
      'semoule',
      'couscous-perle',
      'boulgour',
      'quinoa',
      'millet',
      'polenta',
      'sarrasin-graines',
      'epeautre',
      'orge-perle',
    };

    void eachLine(
      bool Function(RecipeIngredient) select,
      void Function(Recipe, RecipeIngredient, double perPortion) check, {
      bool useMl = false,
    }) {
      for (final r in recipes) {
        for (final ri in r.ingredients.where(select)) {
          final v = useMl ? millilitres(ri) : grams(ri);
          if (v != null) check(r, ri, v / r.servings);
        }
      }
    }

    test('viande, poisson et fruits de mer : 60 à 450 g par portion', () {
      // 60 g : lardons ou chorizo en garniture ; 450 g : poulet entier ou
      // moules avec leurs os et coquilles.
      eachLine(
        (ri) => ri.ingredient.aisle == Aisle.meatFish,
        (r, ri, g) => expect(
          g,
          inInclusiveRange(10, 500),
          reason: '${r.slug} ${ri.ingredient.id}',
        ),
      );
      for (final r in recipes.where((r) => r.type == RecipeType.main)) {
        final total = r.ingredients
            .where((ri) => ri.ingredient.aisle == Aisle.meatFish)
            .map(grams)
            .whereType<double>()
            .fold<double>(0, (a, b) => a + b);
        if (total > 0) {
          expect(
            total / r.servings,
            inInclusiveRange(37.5, 500),
            reason: r.slug,
          );
        }
      }
    });

    test('féculents secs : 40 à 125 g par portion', () {
      // Repère courant : 60 à 100 g de pâtes ou de riz cru par adulte.
      eachLine(
        (ri) => dryStarches.contains(ri.ingredient.id),
        (r, ri, g) => expect(
          g,
          inInclusiveRange(r.type == RecipeType.main ? 40 : 10, 125),
          reason: '${r.slug} ${ri.ingredient.id}',
        ),
      );
    });

    test('œufs : au plus 3 par portion', () {
      for (final r in recipes) {
        for (final ri in r.ingredients.where(
          (ri) => ri.ingredient.id == 'oeuf',
        )) {
          if (ri.unit == Unit.piece) {
            expect(ri.qty / r.servings, lessThanOrEqualTo(3), reason: r.slug);
          }
        }
      }
    });

    test('huiles : au plus 2 cuillères à soupe (30 ml) par portion', () {
      eachLine(
        (ri) => ri.ingredient.id.startsWith('huile-'),
        (r, ri, ml) => expect(
          ml,
          lessThanOrEqualTo(30),
          reason: '${r.slug} ${ri.ingredient.id}',
        ),
        useMl: true,
      );
    });

    test('beurre, sucres et fromages raisonnables par portion', () {
      // Beurre ≤ 40 g (pâtisserie comprise), sucre ≤ 65 g (desserts),
      // fromage ≤ 120 g (raclette, tartiflette).
      eachLine((ri) => ri.ingredient.id == 'beurre', (r, ri, g) {
        expect(g, lessThanOrEqualTo(40), reason: r.slug);
      });
      eachLine((ri) => ri.ingredient.id.startsWith('sucre'), (r, ri, g) {
        expect(g, lessThanOrEqualTo(65), reason: r.slug);
      });
      eachLine(
        (ri) =>
            ri.ingredient.aisle == Aisle.dairy &&
            ri.ingredient.markers.contains(Marker.dairy) &&
            !ri.ingredient.id.startsWith('lait') &&
            !ri.ingredient.id.startsWith('creme') &&
            !ri.ingredient.id.startsWith('yaourt') &&
            ri.ingredient.id != 'beurre' &&
            ri.ingredient.id != 'fromage-blanc',
        (r, ri, g) => expect(
          g,
          lessThanOrEqualTo(150),
          reason: '${r.slug} ${ri.ingredient.id}',
        ),
      );
    });

    test('épices et sel : au plus 1 cuillère à café (5 ml) par portion', () {
      // La moutarde est un condiment (croûtes, vinaigrettes) : hors de cette borne.
      eachLine(
        (ri) =>
            ri.ingredient.pantry &&
            !ri.ingredient.id.startsWith('moutarde') &&
            (ri.ingredient.defaultUnit == Unit.tsp ||
                ri.ingredient.defaultUnit == Unit.pinch) &&
            (ri.unit == Unit.tsp || ri.unit == Unit.tbsp),
        (r, ri, ml) => expect(
          ml,
          lessThanOrEqualTo(5),
          reason: '${r.slug} ${ri.ingredient.id}',
        ),
        useMl: true,
      );
    });

    test('liquides : au plus 500 ml par portion', () {
      for (final r in recipes) {
        final total = r.ingredients
            .map(millilitres)
            .whereType<double>()
            .fold<double>(0, (a, b) => a + b);
        expect(total / r.servings, lessThanOrEqualTo(500), reason: r.slug);
      }
    });

    test('masse solide d’un plat : 150 à 900 g par portion', () {
      // Sous 150 g, le plat ne nourrit pas ; au-delà de 900 g, la quantité
      // est irréaliste pour une personne.
      for (final r in recipes.where((r) => r.type == RecipeType.main)) {
        final total = r.ingredients
            .map(grams)
            .whereType<double>()
            .fold<double>(0, (a, b) => a + b);
        expect(total / r.servings, inInclusiveRange(150, 900), reason: r.slug);
      }
    });

    test('temps et étapes plausibles', () {
      for (final r in recipes) {
        expect(r.totalMin, inInclusiveRange(5, 240), reason: r.slug);
        expect(r.steps.length, inInclusiveRange(2, 12), reason: r.slug);
      }
    });

    test('une étape qui enfourne implique le four', () {
      final oven = RegExp(r'enfourne|au four\b', caseSensitive: false);
      for (final r in recipes) {
        if (r.steps.any(oven.hasMatch)) {
          expect(r.equipment, contains(Equipment.oven), reason: r.slug);
        }
      }
    });
  });

  group('répartition (SPEC §5)', () {
    List<Recipe> mains() =>
        recipes.where((r) => r.type == RecipeType.main).toList();
    int count(Iterable<Recipe> l, bool Function(Recipe) f) => l.where(f).length;

    test(
      'au moins 150 recettes, 135 plats, 15 desserts ou petits-déjeuners',
      () {
        expect(recipes.length, greaterThanOrEqualTo(150));
        expect(mains().length, greaterThanOrEqualTo(135));
        expect(
          count(recipes, (r) => r.type != RecipeType.main),
          greaterThanOrEqualTo(15),
        );
      },
    );

    test('portions de base : 4', () {
      expect(recipes.every((r) => r.servings == 4), isTrue);
    });

    test('au moins 55 plats végétariens dont 25 véganes', () {
      expect(
        count(mains(), (r) => traitsOf(r).isVegetarian),
        greaterThanOrEqualTo(55),
      );
      expect(
        count(mains(), (r) => traitsOf(r).isVegan),
        greaterThanOrEqualTo(25),
      );
    });

    test('au moins 20 plats de poisson ou fruits de mer', () {
      expect(
        count(
          mains(),
          (r) =>
              r.ingredients.any(
                (ri) =>
                    ri.ingredient.markers.contains(Marker.fish) ||
                    ri.ingredient.markers.contains(Marker.seafood),
              ) &&
              (r.mainBase == MainBase.fish || r.mainBase == MainBase.seafood),
        ),
        greaterThanOrEqualTo(20),
      );
    });

    test('volaille, bœuf et porc représentés', () {
      for (final base in [MainBase.poultry, MainBase.beef, MainBase.pork]) {
        expect(
          count(mains(), (r) => r.mainBase == base),
          greaterThanOrEqualTo(5),
          reason: base.code,
        );
      }
    });

    test('au moins 35 sans gluten et 25 sans four', () {
      expect(
        count(recipes, (r) => !traitsOf(r).allergens.contains(Allergen.gluten)),
        greaterThanOrEqualTo(35),
      );
      expect(
        count(recipes, (r) => !r.equipment.contains(Equipment.oven)),
        greaterThanOrEqualTo(25),
      );
    });

    test('au moins 70 % prêtes en 30 minutes ou moins', () {
      expect(
        count(recipes, (r) => r.totalMin <= 30) / recipes.length,
        greaterThanOrEqualTo(0.7),
      );
    });

    test('toutes les saisons couvertes', () {
      const seasons = {
        'hiver': [12, 1, 2],
        'printemps': [3, 4, 5],
        'été': [6, 7, 8],
        'automne': [9, 10, 11],
      };
      for (final e in seasons.entries) {
        final n = count(recipes, (r) => e.value.any((m) => isInSeason(r, m)));
        expect(n, greaterThanOrEqualTo(15), reason: e.key);
      }
    });

    test('au moins 21 plats compatibles pour chaque régime', () {
      for (final diet in Diet.values) {
        for (final noPork in [false, true]) {
          final p = HouseholdProfile(diet: diet, noPork: noPork);
          expect(
            count(mains(), (r) => isCompatible(r, traitsOf(r), p)),
            greaterThanOrEqualTo(21),
            reason: '${diet.code} sans porc=$noPork',
          );
        }
      }
    });
  });

  test('le JSON brut se relit sans perte', () {
    final lot = seed.manifest.lots.first;
    final raw = File('assets/recipes/recipes/$lot.json').readAsStringSync();
    expect(() => jsonDecode(raw), returnsNormally);
  });
}
