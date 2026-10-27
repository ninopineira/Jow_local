import 'package:flutter_test/flutter_test.dart';
import 'package:popote/domain/diet.dart';
import 'package:popote/domain/enums.dart';
import 'package:popote/domain/models.dart';

import 'fixtures.dart';

void main() {
  group('calcul du régime', () {
    test('légumes seuls : végan', () {
      final t = computeTraits([tofu, oignon]);
      expect(t.diets, containsAll(Diet.values));
      expect(t.hasMeat, isFalse);
    });

    test('œuf, lait ou miel : végétarien mais pas végan', () {
      for (final i in [oeuf, creme, miel]) {
        final t = computeTraits([oignon, i]);
        expect(t.isVegetarian, isTrue, reason: i.id);
        expect(t.isVegan, isFalse, reason: i.id);
      }
    });

    test('poisson : pescétarien, ni végétarien ni végan', () {
      final t = computeTraits([saumon]);
      expect(t.diets, contains(Diet.pescetarian));
      expect(t.isVegetarian, isFalse);
      expect(t.allergens, contains(Allergen.fish));
    });

    test('viande : omnivore et flexitarien seulement', () {
      final t = computeTraits([poulet]);
      expect(t.diets, {Diet.omnivore, Diet.flexitarian});
      expect(t.hasMeat, isTrue);
      expect(t.hasPork, isFalse);
    });

    test('porc et gélatine comptent pour « sans porc »', () {
      expect(computeTraits([lardons]).hasPork, isTrue);
      final g = computeTraits([gelatine]);
      expect(g.hasPork, isTrue);
      expect(g.isVegetarian, isFalse);
    });

    test('allergènes : union des ingrédients, y compris cachés', () {
      final t = computeTraits([pates, tofu, oeuf]);
      expect(t.allergens, {Allergen.gluten, Allergen.soy, Allergen.eggs});
    });

    test('marqueurs sans allergène saisi : allergène déduit', () {
      const lait = Ingredient(
        id: 'lait',
        name: 'Lait',
        aisle: Aisle.dairy,
        defaultUnit: Unit.ml,
        markers: {Marker.dairy},
      );
      expect(computeTraits([lait]).allergens, contains(Allergen.milk));
    });
  });

  group('compatibilité avec le profil', () {
    test('raisons d’incompatibilité', () {
      final r = recipe(
        1,
        [lardons, pates, oignon],
        equipment: {Equipment.oven},
      );
      final p = HouseholdProfile(
        diet: Diet.vegetarian,
        noPork: true,
        exclusions: {Allergen.gluten},
        aversions: {'oignon'},
        equipment: {Equipment.hob},
      );
      final reasons = incompatibilities(r, traitsOf(r), p);
      expect(reasons.whereType<DietIncompatibility>(), hasLength(1));
      expect(reasons.whereType<PorkIncompatibility>(), hasLength(1));
      expect(
        reasons.whereType<AllergenIncompatibility>().single.allergen,
        Allergen.gluten,
      );
      expect(
        reasons.whereType<AversionIncompatibility>().single.ingredient.id,
        'oignon',
      );
      expect(
        reasons.whereType<EquipmentIncompatibility>().single.equipment,
        Equipment.oven,
      );
    });

    test('recette compatible', () {
      final r = recipe(1, [tofu, oignon]);
      expect(
        isCompatible(r, traitsOf(r), HouseholdProfile(diet: Diet.vegan)),
        isTrue,
      );
    });
  });

  group('saison', () {
    test('ratio et filtre « de saison »', () {
      final r = recipe(1, [courgette, oignon]);
      expect(seasonRatio(r, 7), 1);
      expect(seasonRatio(r, 1), 0);
      expect(isInSeason(r, 7), isTrue);
      expect(isInSeason(r, 1), isFalse);
      // Sans produit saisonnier : neutre pour le score, pas « de saison ».
      final neutral = recipe(2, [oignon]);
      expect(seasonRatio(neutral, 1), 1);
      expect(isInSeason(neutral, 1), isFalse);
    });
  });
}
