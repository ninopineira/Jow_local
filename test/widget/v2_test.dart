// Tests de widgets V2 (SPEC-V2 §12) : ranger ses courses par scan, lier un
// produit à un ingrédient, repas fait puis annulé, « j'ai mangé », liste
// avec stock, bilan du jour.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/kitchen_repository.dart';
import 'package:popote/data/product_catalog.dart';
import 'package:popote/data/repository.dart';
import 'package:popote/domain/balance.dart';
import 'package:popote/domain/energy.dart';
import 'package:popote/domain/enums.dart';
import 'package:popote/domain/food_log.dart';
import 'package:popote/domain/models.dart';
import 'package:popote/domain/nutrition.dart';
import 'package:popote/domain/stock.dart';
import 'package:popote/ui/strings.dart';

import 'harness.dart';

KitchenRepository kitchenOf(Repository repo) =>
    KitchenRepository(repo.db, repo, () => const EmptyProductCatalog());

/// Menu de la semaine du 2 mars avec une recette au dîner du mardi (jour 1).
Future<Recipe> planTuesday(Repository repo, {bool validated = false}) async {
  final r = (await repo.recipes()).firstWhere(
    (r) => r.ingredients.where((i) => !i.ingredient.pantry).length >= 2,
  );
  await repo.saveMenu(
    WeekMenu(
      startDate: DateTime(2026, 3, 2),
      status: validated ? MenuStatus.validated : MenuStatus.draft,
      slots: [
        MenuSlot(
          key: const SlotKey(1, Meal.dinner),
          kind: SlotKind.recipe,
          recipeId: r.id,
          servings: 2,
        ),
      ],
    ),
  );
  return r;
}

void main() {
  testWidgets('ranger ses courses par scan et lier le produit', (tester) async {
    final h = await pumpApp(
      tester,
      profile: HouseholdProfile(),
      setup: (repo) => kitchenOf(repo).saveCustomProduct(
        const Product(
          barcode: '3250390000001',
          name: 'Spaghetti n°5',
          brand: 'Marque X',
          packageQty: 500,
          packageUnit: StockUnit.g,
          categories: ['pastas', 'spaghetti'],
        ),
      ),
    );
    h.scanner.codes.add('3250390000001');
    await tapAndSettle(tester, find.text(S.tabStock));
    expect(find.text(S.stockEmpty), findsOneWidget);
    await tapAndSettle(tester, find.text(S.stockStore));
    await tapAndSettle(tester, find.byKey(const Key('scan-3250390000001')));
    // Premier scan : ingrédient le plus probable proposé, confirmé en un geste.
    expect(find.text(S.productLinkTitle), findsOneWidget);
    await tapAndSettle(tester, find.text('${S.productConfirm} : Spaghetti'));
    expect(find.text(S.stockScanned(1)), findsOneWidget);
    // Annuler le dernier, puis rescanner : le lien est mémorisé.
    await tapAndSettle(tester, find.text(S.stockUndoLast));
    expect(find.text(S.stockScanned(0)), findsOneWidget);
    await tapAndSettle(tester, find.byKey(const Key('scan-3250390000001')));
    expect(find.text(S.productLinkTitle), findsNothing);
    await tapAndSettle(tester, find.text(S.stockTimes2));
    await tapAndSettle(tester, find.text(S.stockDone));
    expect(find.text('Spaghetti n°5 · Marque X'), findsOneWidget);
    final lots = await tester.runAsync(() => kitchenOf(h.repo).stock());
    expect(lots!.single.quantity, 1000);
    expect(lots.single.ingredientId, 'spaghetti');
    expect(lots.single.location, StockLocation.pantry);
  });

  testWidgets('produit inconnu : fiche saisie à la main', (tester) async {
    final h = await pumpApp(tester, profile: HouseholdProfile());
    h.scanner.codes.add('999');
    await tapAndSettle(tester, find.text(S.tabStock));
    await tapAndSettle(tester, find.text(S.stockStore));
    await tapAndSettle(tester, find.byKey(const Key('scan-999')));
    expect(find.text(S.productUnknownBody), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextField, S.productName),
      'Biscuits',
    );
    await tester.enterText(find.widgetWithText(TextField, S.kcal), '480');
    await tapAndSettle(tester, find.text(S.save));
    await tapAndSettle(tester, find.text(S.productNoLink));
    expect(find.text(S.stockScanned(1)), findsOneWidget);
    final p = await tester.runAsync(() => kitchenOf(h.repo).product('999'));
    expect(p!.custom, isTrue);
    expect(p.nutrients!.kcal, 480);
  });

  testWidgets('marquer un repas fait puis annuler', (tester) async {
    late Recipe r;
    final h = await pumpApp(
      tester,
      profile: HouseholdProfile(),
      setup: (repo) async {
        r = await planTuesday(repo);
        final k = kitchenOf(repo);
        for (final ri in r.ingredients) {
          await k.addLot(
            StockLot(
              ingredientId: ri.ingredient.id,
              label: ri.ingredient.name,
              quantity: 5000,
              unit: StockUnit.g,
              location: StockLocation.pantry,
              addedAt: DateTime(2026, 3, 1),
            ),
          );
        }
      },
    );
    final total = r.ingredients.where((i) => !i.ingredient.pantry).length;
    expect(find.textContaining(S.inStockCount(total, total)), findsOneWidget);
    await tapAndSettle(tester, find.widgetWithText(FilledButton, S.done));
    expect(find.text(S.undoDone), findsOneWidget);
    final k = kitchenOf(h.repo);
    final day = DateTime(2026, 3, 3);
    var log = await tester.runAsync(() => k.logEntries(day, day));
    expect(log!.single.label, r.title);
    expect(log.single.macros.kcal, closeTo(mealPortionMacros(r).kcal, 1e-6));
    final moved = await tester.runAsync(() => k.stock(includeEmpty: true));
    expect(moved!.any((l) => l.quantity < 5000), isTrue);
    await tapAndSettle(tester, find.text(S.undoDone));
    expect(find.widgetWithText(FilledButton, S.done), findsOneWidget);
    log = await tester.runAsync(() => k.logEntries(day, day));
    expect(log, isEmpty);
    final restored = await tester.runAsync(() => k.stock(includeEmpty: true));
    expect(restored!.every((l) => l.quantity == 5000), isTrue);
  });

  testWidgets('liste avec stock : à acheter et déjà en stock', (tester) async {
    await pumpApp(
      tester,
      profile: HouseholdProfile(),
      setup: (repo) async {
        final r = await planTuesday(repo, validated: true);
        final ing = r.ingredients.firstWhere((i) => !i.ingredient.pantry);
        await kitchenOf(repo).addLot(
          StockLot(
            ingredientId: ing.ingredient.id,
            label: ing.ingredient.name,
            quantity: 5000,
            unit: StockUnit.g,
            location: StockLocation.pantry,
            addedAt: DateTime(2026, 3, 1),
          ),
        );
      },
    );
    await tapAndSettle(tester, find.text(S.tabList));
    expect(find.text(S.toBuy), findsOneWidget);
    await scrollTo(tester, find.byKey(const Key('in-stock')));
    expect(find.textContaining(S.alreadyInStock), findsOneWidget);
  });

  testWidgets('j\'ai mangé (saisie libre) et bilan du jour', (tester) async {
    await pumpApp(
      tester,
      profile: HouseholdProfile(),
      setup: (repo) async {
        final k = kitchenOf(repo);
        await k.saveNutritionProfile(
          NutritionProfile(
            sex: Sex.male,
            birthDate: DateTime(1996, 11, 15),
            heightCm: 180,
          ),
        );
        await k.addWeight(
          WeightPoint(date: DateTime(2026, 3, 1), weightKg: 75),
        );
        await k.addGoal(
          Goal(
            startDate: DateTime(2026, 1, 1),
            kind: GoalKind.cut,
            dailyKcalDelta: -400,
          ),
        );
        await k.addLogEntry(
          FoodLogEntry(
            date: DateTime(2026, 3, 3),
            moment: Moment.breakfast,
            label: 'Tartines',
            source: LogSource.free,
            macros: const Macros(kcal: 400, protein: 10, carbs: 60, fat: 12),
          ),
        );
      },
    );
    await tapAndSettle(tester, find.text(S.tabNutrition));
    expect(find.text(S.today), findsOneWidget);
    expect(find.text('Tartines'), findsOneWidget);
    // Bilan : 29 ans, BMR 1735, TDEE 2689 → déficit.
    expect(find.text(S.balanceStatus('deficit')), findsOneWidget);
    expect(find.text('2689 ${S.kcal}'), findsWidgets);
    await tapAndSettle(tester, find.text(S.iAte));
    await tapAndSettle(tester, find.text(S.freeEntry));
    await tester.enterText(find.widgetWithText(TextField, S.label), 'Pomme');
    await tester.enterText(find.widgetWithText(TextField, S.kcal), '80');
    await tapAndSettle(tester, find.text(S.save));
    expect(find.text('Pomme'), findsOneWidget);
    expect(find.text('480 ${S.kcal}'), findsOneWidget);
  });
}
