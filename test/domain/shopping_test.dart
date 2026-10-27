import 'package:flutter_test/flutter_test.dart';
import 'package:popote/domain/enums.dart';
import 'package:popote/domain/models.dart';
import 'package:popote/domain/quantities.dart';
import 'package:popote/domain/shopping.dart';

import 'fixtures.dart';

Recipe withLines(int id, List<RecipeIngredient> lines, {String? title}) =>
    Recipe(
      id: id,
      title: title ?? 'R$id',
      type: RecipeType.main,
      prepMin: 10,
      cookMin: 10,
      mainBase: MainBase.vegetables,
      ingredients: lines,
    );

RecipeIngredient line(
  Ingredient i,
  double q,
  Unit u, {
  bool optional = false,
}) => RecipeIngredient(ingredient: i, qty: q, unit: u, optional: optional);

void main() {
  group('conversions', () {
    test('vers les unités de base', () {
      expect(toBase(1.2, Unit.kg), const Amount(Dimension.mass, 1200));
      expect(toBase(25, Unit.cl), const Amount(Dimension.volume, 250));
      expect(toBase(1, Unit.l), const Amount(Dimension.volume, 1000));
      expect(toBase(2, Unit.tbsp), const Amount(Dimension.volume, 30));
      expect(toBase(3, Unit.tsp), const Amount(Dimension.volume, 15));
      expect(toBase(2, Unit.piece), const Amount(Dimension.count, 2));
    });

    test('pièces et grammes fusionnés si le poids moyen est connu', () {
      final merged = mergeAmounts(oignon, [
        const Amount(Dimension.count, 2),
        const Amount(Dimension.mass, 150),
      ]);
      expect(merged, [const Amount(Dimension.count, 3.5)]);
    });

    test('sans poids moyen, pièces et grammes restent séparés', () {
      final merged = mergeAmounts(tofu, [
        const Amount(Dimension.count, 1),
        const Amount(Dimension.mass, 200),
      ]);
      expect(merged, hasLength(2));
    });

    test('volume et masse ne sont jamais convertis', () {
      final merged = mergeAmounts(creme, [
        const Amount(Dimension.volume, 200),
        const Amount(Dimension.mass, 100),
      ]);
      expect(merged, hasLength(2));
    });
  });

  group('arrondis et affichage', () {
    test('pièces : unité supérieure, au demi pour fruits et légumes', () {
      expect(
        roundForShopping(const Amount(Dimension.count, 1.2), oeuf).value,
        2,
      );
      expect(
        roundForShopping(const Amount(Dimension.count, 1.2), oignon).value,
        1.5,
      );
    });

    test('grammes à 5 près sous 100 g, à 10 près au-delà', () {
      expect(
        roundForShopping(const Amount(Dimension.mass, 42), tofu).value,
        45,
      );
      expect(
        roundForShopping(const Amount(Dimension.mass, 333), tofu).value,
        330,
      );
      expect(
        roundForShopping(const Amount(Dimension.mass, 1234), tofu).value,
        1200,
      );
    });

    test('formats lisibles', () {
      expect(formatAmount(const Amount(Dimension.mass, 1200)), '1,2 kg');
      expect(formatAmount(const Amount(Dimension.mass, 330)), '330 g');
      expect(formatAmount(const Amount(Dimension.volume, 1500)), '1,5 l');
      expect(formatAmount(const Amount(Dimension.volume, 250)), '25 cl');
      expect(formatAmount(const Amount(Dimension.volume, 30)), '2 c. à soupe');
      expect(formatAmount(const Amount(Dimension.volume, 10)), '2 c. à café');
      expect(formatAmount(const Amount(Dimension.count, 1.5)), '1,5');
      expect(formatAmount(const Amount(Dimension.pinch, 2)), '2 pincées');
    });
  });

  group('agrégation', () {
    final a = withLines(1, [
      line(oignon, 1, Unit.piece),
      line(creme, 20, Unit.cl),
      line(sel, 1, Unit.pinch),
    ], title: 'Recette A');
    final b = withLines(2, [
      line(oignon, 100, Unit.g),
      line(creme, 2, Unit.tbsp),
      line(courgette, 2, Unit.piece, optional: true),
    ], title: 'Recette B');

    test('mise à l’échelle et somme par ingrédient', () {
      // A pour 2 (×0,5), B pour 8 (×2).
      final lines = aggregateShopping([
        PlannedRecipe(a, 2),
        PlannedRecipe(b, 8),
      ]);
      final byId = {for (final l in lines) l.ingredient.id: l};
      // oignon : 0,5 pièce + 200 g = 2,5 pièces
      expect(byId['oignon']!.amount, const Amount(Dimension.count, 2.5));
      // crème : 100 ml + 60 ml
      expect(byId['creme']!.amount, const Amount(Dimension.volume, 160));
      expect(byId['oignon']!.recipeTitles, ['Recette A', 'Recette B']);
      expect(byId['courgette']!.optional, isTrue);
      expect(byId['sel']!.pantry, isTrue);
    });

    test('cuisiner en double : les portions des restes s’additionnent', () {
      const src = SlotKey(0, Meal.dinner);
      final slots = [
        const MenuSlot(
          key: src,
          kind: SlotKind.recipe,
          recipeId: 1,
          servings: 2,
        ),
        const MenuSlot(
          key: SlotKey(1, Meal.lunch),
          kind: SlotKind.leftovers,
          servings: 2,
          leftoversFrom: src,
        ),
        const MenuSlot(key: SlotKey(1, Meal.dinner), kind: SlotKind.eatingOut),
      ];
      final planned = plannedRecipes(
        slots: slots,
        extras: const [],
        recipes: {1: a},
      );
      expect(planned.single.servings, 4);
    });

    test('les extras comptent dans la liste', () {
      final planned = plannedRecipes(
        slots: const [],
        extras: const [WeekExtra(recipeId: 2, servings: 4)],
        recipes: {2: b},
      );
      final lines = aggregateShopping(planned);
      expect(lines.map((l) => l.ingredient.id), contains('courgette'));
    });

    test('créneaux « dehors » et vides ne comptent pas', () {
      final planned = plannedRecipes(
        slots: const [
          MenuSlot(key: SlotKey(0, Meal.dinner), kind: SlotKind.eatingOut),
          MenuSlot(key: SlotKey(1, Meal.dinner)),
        ],
        extras: const [],
        recipes: {1: a},
      );
      expect(planned, isEmpty);
    });
  });

  group('recalcul de la liste', () {
    test('conserve les cases des lignes inchangées et les articles libres', () {
      final a = withLines(1, [
        line(oignon, 2, Unit.piece),
        line(tofu, 200, Unit.g),
      ]);
      final before = reconcileShopping(
        const [],
        aggregateShopping([PlannedRecipe(a, 4)]),
      );
      final checked = [
        for (final i in before) i.copyWith(bought: true),
        const ShoppingItem(
          id: 99,
          label: 'Éponges',
          manual: true,
          bought: true,
        ),
      ];
      // Le tofu double, l'oignon ne change pas.
      final a2 = withLines(1, [
        line(oignon, 2, Unit.piece),
        line(tofu, 400, Unit.g),
      ]);
      final after = reconcileShopping(
        checked,
        aggregateShopping([PlannedRecipe(a2, 4)]),
      );
      final byIng = {for (final i in after) i.ingredientId ?? i.label: i};
      expect(byIng['oignon']!.bought, isTrue);
      expect(byIng['tofu']!.bought, isFalse);
      expect(byIng['Éponges']!.bought, isTrue);
    });

    test(
      'texte copié : rayons dans l’ordre, placards à part, cochés exclus',
      () {
        final a = withLines(1, [
          line(oignon, 2, Unit.piece),
          line(tofu, 200, Unit.g),
          line(sel, 1, Unit.pinch),
        ]);
        final lines = aggregateShopping([PlannedRecipe(a, 4)]);
        final items = reconcileShopping(const [], lines);
        final state = {
          for (final i in items)
            i.key!: i.ingredientId == 'tofu' ? i.copyWith(bought: true) : i,
        };
        final text = shoppingText(
          lines: lines,
          manualItems: const [ShoppingItem(label: 'Piles', manual: true)],
          stateByKey: state,
          aisleOrder: Aisle.values,
          aisleLabel: (a) => a.code,
          title: 'Courses',
          pantryTitle: 'Placards',
          manualTitle: 'Divers',
        );
        expect(text, contains('2 × Oignon'));
        expect(text, isNot(contains('Tofu')));
        expect(text.indexOf('Placards'), greaterThan(text.indexOf('Oignon')));
        expect(text, contains('- Piles'));
      },
    );
  });
}
