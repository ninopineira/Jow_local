import 'package:flutter_test/flutter_test.dart';
import 'package:popote/domain/enums.dart';
import 'package:popote/domain/food_log.dart';
import 'package:popote/domain/models.dart';
import 'package:popote/domain/nutrition.dart';
import 'package:popote/domain/quantities.dart';
import 'package:popote/domain/stock.dart';

const pates = Ingredient(
  id: 'pates',
  name: 'Pâtes sèches',
  aisle: Aisle.savory,
  defaultUnit: Unit.g,
  nutrition: Nutrients(kcal: 350, protein: 12, carbs: 70, fat: 2),
);
const oeuf = Ingredient(
  id: 'oeuf',
  name: 'Œuf',
  aisle: Aisle.dairy,
  defaultUnit: Unit.piece,
  avgPieceWeightG: 50,
  perishable: true,
  nutrition: Nutrients(kcal: 140, protein: 12, carbs: 1, fat: 10),
);
const huile = Ingredient(
  id: 'huile',
  name: 'Huile',
  aisle: Aisle.savory,
  defaultUnit: Unit.tbsp,
  pantry: true,
  density: 0.92,
  nutrition: Nutrients(kcal: 900, protein: 0, carbs: 0, fat: 100),
);

final recette = Recipe(
  id: 1,
  title: 'Pâtes aux œufs',
  type: RecipeType.main,
  servings: 4,
  prepMin: 5,
  cookMin: 10,
  mainBase: MainBase.pasta,
  ingredients: const [
    RecipeIngredient(ingredient: pates, qty: 400, unit: Unit.g),
    RecipeIngredient(ingredient: oeuf, qty: 4, unit: Unit.piece),
    RecipeIngredient(ingredient: huile, qty: 2, unit: Unit.tbsp),
  ],
);

StockLot lot(
  int id,
  Ingredient ing,
  double qty,
  StockUnit unit, {
  DateTime? dlc,
  int addedDay = 1,
}) => StockLot(
  id: id,
  ingredientId: ing.id,
  label: ing.name,
  quantity: qty,
  unit: unit,
  location: StockLocation.pantry,
  addedAt: DateTime(2026, 10, addedDay),
  bestBefore: dlc,
);

final catalogue = {
  for (final i in [pates, oeuf, huile]) i.id: i,
};

void main() {
  group('sortie de stock', () {
    test('min(besoin, stock), jamais négatif', () {
      final ws = planWithdrawal(pates, const Amount(Dimension.mass, 400), [
        lot(1, pates, 250, StockUnit.g),
      ]);
      expect(ws.single.quantity, 250);
      final none = planWithdrawal(pates, const Amount(Dimension.mass, 400), []);
      expect(none, isEmpty);
    });

    test('DLC la plus proche, puis le plus ancien, sans DLC en dernier', () {
      final lots = [
        lot(1, pates, 300, StockUnit.g, addedDay: 1),
        lot(
          2,
          pates,
          300,
          StockUnit.g,
          addedDay: 5,
          dlc: DateTime(2026, 11, 20),
        ),
        lot(
          3,
          pates,
          300,
          StockUnit.g,
          addedDay: 3,
          dlc: DateTime(2026, 11, 2),
        ),
        lot(4, pates, 300, StockUnit.g, addedDay: 2),
      ];
      final ws = planWithdrawal(
        pates,
        const Amount(Dimension.mass, 1000),
        lots,
      );
      expect(ws.map((w) => w.lotId), [3, 2, 1, 4]);
      expect(ws.last.quantity, closeTo(100, 1e-9));
    });

    test('conversion pièces ↔ grammes via le poids moyen', () {
      final ws = planWithdrawal(oeuf, const Amount(Dimension.mass, 120), [
        lot(1, oeuf, 6, StockUnit.piece),
      ]);
      expect(ws.single.quantity, closeTo(2.4, 1e-9));
      expect(
        convertAmount(oeuf, const Amount(Dimension.count, 3), StockUnit.g),
        150,
      );
      expect(
        convertAmount(huile, const Amount(Dimension.volume, 30), StockUnit.g),
        closeTo(27.6, 1e-9),
      );
    });

    test('repas : sorties pour chaque ingrédient, stock partiel', () {
      final lots = [
        lot(1, pates, 500, StockUnit.g),
        lot(2, oeuf, 2, StockUnit.piece),
      ];
      final ws = planMealWithdrawals(recette, 4, lots, catalogue);
      final byLot = {for (final w in ws) w.lotId: w.quantity};
      expect(byLot[1], 400);
      expect(byLot[2], 2); // 4 demandés, 2 disponibles : pas d'erreur.
      expect(byLot.length, 2);
    });

    test('ajustement : ingrédient retiré ou remplacé', () {
      final lots = [
        lot(1, pates, 500, StockUnit.g),
        lot(2, oeuf, 6, StockUnit.piece),
      ];
      final ws = planMealWithdrawals(
        recette,
        4,
        lots,
        catalogue,
        excluded: {'oeuf'},
      );
      expect(ws.map((w) => w.lotId), [1]);
    });
  });

  group('calories d\'un repas fait', () {
    test('recette complète même avec un stock vide, × parts', () {
      // 400 g pâtes = 1400 ; 4 œufs = 200 g = 280 ; 2 c. à s. huile =
      // 30 ml × 0,92 = 27,6 g = 248,4 → 1928,4 kcal pour 4.
      final full = recipeMacros(recette);
      expect(full.kcal, closeTo(1928.4, 1e-9));
      expect(mealPortionMacros(recette).kcal, closeTo(482.1, 1e-9));
      expect(
        mealPortionMacros(recette, portions: 1.5).kcal,
        closeTo(723.15, 1e-9),
      );
      expect(
        mealPortionMacros(recette, excluded: {'oeuf'}).kcal,
        closeTo((1928.4 - 280) / 4, 1e-9),
      );
      expect(recipeMacrosPerServing(recette).protein, closeTo(18, 1e-9));
    });

    test('jour du journal : prévu, sauf repas avancé compté aujourd\'hui', () {
      final today = DateTime(2026, 10, 28, 20, 15);
      // Repas du jeudi mangé mercredi : bilan de mercredi.
      expect(
        mealLogDate(DateTime(2026, 10, 29), today),
        DateTime(2026, 10, 28),
      );
      // Repas du jour ou passé oublié : son jour.
      expect(
        mealLogDate(DateTime(2026, 10, 28), today),
        DateTime(2026, 10, 28),
      );
      expect(
        mealLogDate(DateTime(2026, 10, 26), today),
        DateTime(2026, 10, 26),
      );
    });
  });

  group('liste = besoin − stock, réservation chronologique', () {
    test('le stock couvre lundi, pas jeudi', () {
      final uses = [
        PlannedUse(
          recipe: recette,
          servings: 4,
          slot: const SlotKey(0, Meal.dinner),
        ),
        PlannedUse(
          recipe: recette,
          servings: 4,
          slot: const SlotKey(3, Meal.dinner),
        ),
      ];
      final plan = planShoppingWithStock(uses, [
        lot(1, pates, 500, StockUnit.g),
        lot(2, oeuf, 4, StockUnit.piece),
      ]);
      final buy = {for (final l in plan.toBuy) l.ingredient.id: l.amount.value};
      expect(buy['pates'], 300);
      expect(buy['oeuf'], 4);
      final have = {
        for (final l in plan.inStock) l.ingredient.id: l.amount.value,
      };
      expect(have['pates'], 500);
      expect(plan.coverage[0], (2, 2));
      expect(plan.coverage[1], (0, 2));
    });

    test('paquets', () {
      expect(
        packagesFor(pates, const Amount(Dimension.mass, 300), 500, StockUnit.g),
        1,
      );
      expect(
        packagesFor(
          pates,
          const Amount(Dimension.mass, 1200),
          500,
          StockUnit.g,
        ),
        3,
      );
    });
  });

  test('emplacement par défaut et bonus anti-gaspillage', () {
    expect(defaultLocation(oeuf), StockLocation.fridge);
    expect(defaultLocation(pates), StockLocation.pantry);
    final today = DateTime(2026, 10, 28);
    expect(stockAffinity(recette, [], today), 0);
    expect(
      stockAffinity(recette, [lot(2, oeuf, 6, StockUnit.piece)], today),
      0.5,
    );
    expect(
      stockAffinity(recette, [
        lot(1, pates, 500, StockUnit.g),
        lot(2, oeuf, 6, StockUnit.piece),
      ], today),
      0.75,
    );
  });

  test('suggestion d\'ingrédient pour un produit', () {
    const p = Product(
      barcode: '1',
      name: 'Spaghetti n°5',
      categories: ['pastas', 'pates-seches'],
    );
    expect(suggestIngredient(p, [pates, oeuf, huile])?.id, 'pates');
    const unknown = Product(barcode: '2', name: 'Biscuits chocolat');
    expect(suggestIngredient(unknown, [pates, oeuf, huile]), isNull);
    expect(Moment.forMeal(Meal.lunch), Moment.lunch);
  });
}
