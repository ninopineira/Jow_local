import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/backup.dart';
import 'package:popote/data/database.dart';
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
import 'package:popote/domain/strength.dart';
import 'package:sqlite3/sqlite3.dart';

import '../helpers/seed_files.dart';
import 'repository_test.dart' show MemoryPhotos;

Future<(Repository, KitchenRepository)> setup() async {
  final repo = Repository(AppDatabase(NativeDatabase.memory()));
  await repo.importSeedIfNeeded(FileSeedSource());
  final kitchen = KitchenRepository(
    repo.db,
    repo,
    () => const EmptyProductCatalog(),
  );
  return (repo, kitchen);
}

/// Menu d'une semaine avec la première recette au dîner du lundi, cuisinée
/// en double pour des restes le mardi midi.
Future<(WeekMenu, Recipe)> menuWithLeftovers(Repository repo) async {
  final recipes = await repo.recipes();
  final r = recipes.firstWhere(
    (r) => r.ingredients.any((i) => !i.ingredient.pantry),
  );
  final monday = DateTime(2026, 10, 26);
  final menu = await repo.saveMenu(
    WeekMenu(
      startDate: monday,
      slots: [
        MenuSlot(
          key: const SlotKey(0, Meal.dinner),
          kind: SlotKind.recipe,
          recipeId: r.id,
          servings: 2,
        ),
        const MenuSlot(
          key: SlotKey(1, Meal.lunch),
          kind: SlotKind.leftovers,
          servings: 2,
          leftoversFrom: SlotKey(0, Meal.dinner),
        ),
      ],
    ),
  );
  return (menu, r);
}

/// Stock généreux de tous les ingrédients de la recette.
Future<void> stockFor(KitchenRepository k, Recipe r) async {
  for (final ri in r.ingredients) {
    final ing = ri.ingredient;
    await k.addLot(
      StockLot(
        ingredientId: ing.id,
        label: ing.name,
        quantity: 5000,
        unit: StockUnit.g,
        location: defaultLocation(ing),
        addedAt: DateTime(2026, 10, 20),
      ),
    );
  }
}

Map<int, double> quantities(List<StockLot> lots) => {
  for (final l in lots) l.id!: l.quantity,
};

void main() {
  test('les ingrédients fournis ont des valeurs Ciqual', () async {
    final (repo, _) = await setup();
    final ings = await repo.ingredients();
    expect(ings, isNotEmpty);
    expect(ings.where((i) => i.nutrition == null), isEmpty);
    final olive = ings.firstWhere((i) => i.id.contains('huile-d-olive'));
    expect(olive.nutrition!.fat, greaterThan(90));
    expect(olive.density, closeTo(0.92, 0.01));
  });

  group('repas fait', () {
    test('« Fait » puis « Annuler » restaure exactement le stock', () async {
      final (repo, k) = await setup();
      final (menu, r) = await menuWithLeftovers(repo);
      await stockFor(k, r);
      final before = quantities(await k.stock(includeEmpty: true));
      final id = await k.markDone(
        menu: menu,
        recipe: r,
        date: DateTime(2026, 10, 26),
        slot: const SlotKey(0, Meal.dinner),
        cookedServings: 4,
      );
      final after = quantities(await k.stock(includeEmpty: true));
      expect(after, isNot(equals(before)));
      expect(after.values.every((q) => q >= 0), isTrue);
      final log = await k.logEntries(
        DateTime(2026, 10, 26),
        DateTime(2026, 10, 26),
      );
      expect(log.single.moment, Moment.dinner);
      expect(log.single.macros.kcal, closeTo(mealPortionMacros(r).kcal, 1e-6));
      await k.undoDone(id);
      expect(quantities(await k.stock(includeEmpty: true)), before);
      expect(
        await k.logEntries(DateTime(2026, 10, 26), DateTime(2026, 10, 26)),
        isEmpty,
      );
    });

    test(
      'stock vide : aucune erreur, calories de la recette complète',
      () async {
        final (repo, k) = await setup();
        final (menu, r) = await menuWithLeftovers(repo);
        await k.markDone(
          menu: menu,
          recipe: r,
          date: DateTime(2026, 10, 26),
          slot: const SlotKey(0, Meal.dinner),
          cookedServings: 4,
          portionsEaten: 1.5,
        );
        expect(await k.stock(), isEmpty);
        final log = await k.logEntries(
          DateTime(2026, 10, 26),
          DateTime(2026, 10, 26),
        );
        expect(
          log.single.macros.kcal,
          closeTo(mealPortionMacros(r, portions: 1.5).kcal, 1e-6),
        );
        expect(log.single.macros.kcal, greaterThan(0));
      },
    );

    test('restes : pas de sortie de stock, calories comptées', () async {
      final (repo, k) = await setup();
      final (menu, r) = await menuWithLeftovers(repo);
      await stockFor(k, r);
      final before = quantities(await k.stock(includeEmpty: true));
      await k.markDone(
        menu: menu,
        recipe: r,
        date: DateTime(2026, 10, 27),
        slot: const SlotKey(1, Meal.lunch),
        cookedServings: 0,
      );
      expect(quantities(await k.stock(includeEmpty: true)), before);
      final log = await k.logEntries(
        DateTime(2026, 10, 27),
        DateTime(2026, 10, 27),
      );
      expect(log.single.moment, Moment.lunch);
    });

    test('lot supprimé entre-temps : recréé à l\'annulation', () async {
      final (repo, k) = await setup();
      final (menu, r) = await menuWithLeftovers(repo);
      await stockFor(k, r);
      final id = await k.markDone(
        menu: menu,
        recipe: r,
        date: DateTime(2026, 10, 26),
        slot: const SlotKey(0, Meal.dinner),
        cookedServings: 4,
      );
      final lots = await k.stock(includeEmpty: true);
      await k.deleteLot(lots.first.id!);
      await k.undoDone(id);
      final restored = await k.stock(includeEmpty: true);
      expect(restored.length, lots.length);
    });
  });

  group('liste avec stock', () {
    test(
      'un créneau fait sort de la liste ; le stock réduit le manque',
      () async {
        final (repo, k) = await setup();
        final (menu, r) = await menuWithLeftovers(repo);
        final full = await repo.computeLines(menu);
        expect(full, isNotEmpty);
        await stockFor(k, r);
        expect(await repo.computeLines(menu), isEmpty);
        final plan = await k.stockPlan(menu);
        expect(plan.inStock, isNotEmpty);
        final (ok, total) = plan.coverage.single;
        expect(ok, total);
      },
    );
  });

  group('j\'ai mangé et saisies libres', () {
    test(
      'sortie min(besoin, stock) puis suppression qui remet le stock',
      () async {
        final (repo, k) = await setup();
        final ing = (await repo.ingredients()).firstWhere(
          (i) => i.defaultUnit == Unit.g && !i.pantry,
        );
        await k.addLot(
          StockLot(
            ingredientId: ing.id,
            label: ing.name,
            quantity: 100,
            unit: StockUnit.g,
            location: StockLocation.pantry,
            addedAt: DateTime(2026, 10, 1),
          ),
        );
        final id = await k.eat(
          FoodLogEntry(
            date: DateTime(2026, 10, 28),
            moment: Moment.snack,
            label: ing.name,
            source: LogSource.ingredient,
            macros: ing.nutrition!.forGrams(150),
          ),
          ingredient: ing,
          grams: 150,
        );
        expect((await k.stock(includeEmpty: true)).single.quantity, 0);
        await k.deleteLogEntry(id);
        expect((await k.stock(includeEmpty: true)).single.quantity, 100);
      },
    );
  });

  group('produits', () {
    test('produit perso prioritaire et lien mémorisé', () async {
      final (_, k) = await setup();
      expect(await k.product('123'), isNull);
      expect(await k.link('123'), isNull);
      await k.saveCustomProduct(
        const Product(
          barcode: '123',
          name: 'Spaghetti',
          packageQty: 500,
          packageUnit: StockUnit.g,
          nutrients: Nutrients(kcal: 350, protein: 12, carbs: 70, fat: 2),
        ),
      );
      await k.setLink('123', 'spaghetti');
      expect((await k.product('123'))!.custom, isTrue);
      expect((await k.link('123'))!.$1, 'spaghetti');
      await k.setLink('456', null);
      expect((await k.link('456'))!.$1, isNull);
    });

    test('import de la base produits (fixture compressée)', () async {
      final dir = await Directory.systemTemp.createTemp('popote_pdb_');
      final dbFile = File('${dir.path}/src.db');
      final db = sqlite3.open(dbFile.path);
      db.execute(
        'CREATE TABLE products (barcode TEXT PRIMARY KEY, name TEXT, '
        'brand TEXT, package_qty REAL, package_unit TEXT, serving_g REAL, '
        'kcal REAL, protein REAL, carbs REAL, sugars REAL, fat REAL, '
        'sat_fat REAL, fiber REAL, salt REAL, categories TEXT, '
        'scans INTEGER, completeness REAL); '
        'CREATE TABLE meta (key TEXT PRIMARY KEY, value TEXT);',
      );
      db.execute(
        "INSERT INTO products VALUES ('3250390000001', 'Spaghetti n°5', "
        "'Marque X', 500, 'g', NULL, 357, 12.5, 71, 3.5, 1.5, 0.3, 3, 0.01, "
        "'pastas,spaghetti', 300, 0.8)",
      );
      db.execute(
        "INSERT INTO meta VALUES ('format', '$productDbFormat'), "
        "('date', '20261028'), ('count', '1')",
      );
      db.close();
      final gz = File('${dir.path}/produits.db.gz')
        ..writeAsBytesSync(gzip.encode(dbFile.readAsBytesSync()));
      final target = File('${dir.path}/app/products.db');
      await target.parent.create();
      final info = await importProductDb(gz, target);
      expect(info.count, 1);
      final cat = SqliteProductCatalog.open(target)!;
      final p = cat.byBarcode('3250390000001')!;
      expect(p.packageQty, 500);
      expect(p.packageUnit, StockUnit.g);
      expect(cat.search('spag').single.barcode, '3250390000001');
      cat.close();
      final bad = File('${dir.path}/bad.db.gz')
        ..writeAsBytesSync(gzip.encode(utf8.encode('pas une base')));
      await expectLater(importProductDb(bad, target), throwsFormatException);
      await dir.delete(recursive: true);
    });
  });

  test('export puis import V2 sans perte, réimport sans doublon', () async {
    final (repo, k) = await setup();
    final (menu, r) = await menuWithLeftovers(repo);
    await stockFor(k, r);
    await k.markDone(
      menu: menu,
      recipe: r,
      date: DateTime(2026, 10, 26),
      slot: const SlotKey(0, Meal.dinner),
      cookedServings: 4,
    );
    await k.saveNutritionProfile(
      NutritionProfile(
        sex: Sex.male,
        birthDate: DateTime(1996, 11, 15),
        heightCm: 180,
      ),
    );
    await k.addGoal(
      Goal(
        startDate: DateTime(2026, 10, 1),
        kind: GoalKind.cut,
        dailyKcalDelta: -400,
      ),
    );
    await k.addWeight(WeightPoint(date: DateTime(2026, 10, 20), weightKg: 75));
    await k.setSteps(DateTime(2026, 10, 26), 10000);
    await k.addWorkout(
      Workout(
        date: DateTime(2026, 10, 26),
        exerciseName: 'Course',
        met: 9.8,
        durationMin: 30,
      ),
    );
    await k.addStrengthSession(
      StrengthSession(
        date: DateTime(2026, 10, 27),
        sets: const [StrengthSet(exercise: 'Squat', reps: 8, weightKg: 100)],
      ),
    );
    await k.savePreset(
      MealPreset(
        name: 'Petit-déj',
        items: const [
          PresetItem(
            label: 'Flocons',
            grams: 60,
            nutrients: Nutrients(kcal: 370, protein: 13, carbs: 60, fat: 7),
          ),
        ],
        recipeId: r.id,
      ),
    );
    await k.setLink('123', null);

    final svc = BackupService(repo, MemoryPhotos());
    final zip = await svc.exportZip();
    final sums1 = await k.summaries(DateTime(2026, 10, 27), 2);

    final (repo2, k2) = await setup();
    final svc2 = BackupService(repo2, MemoryPhotos());
    await svc2.apply(svc2.preview(zip), ImportMode.replace);
    Future<String> dump(KitchenRepository kk) async => jsonEncode({
      'stock': [
        for (final l in await kk.stock(includeEmpty: true))
          [l.label, l.quantity],
      ],
      'moves': (await kk.movements()).length,
      'log': [
        for (final e in await kk.logEntries(DateTime(2026), DateTime(2027)))
          e.macros.kcal,
      ],
      'presets': [
        for (final p in await kk.presets())
          [p.name, p.items.length, p.recipeId != null],
      ],
      'link': (await kk.link('123')) != null,
    });
    expect(await dump(k2), await dump(k));
    final menu2 = (await repo2.allMenus()).single;
    expect((await k2.completions(menu2.id!)).length, 1);
    final sums2 = await k2.summaries(DateTime(2026, 10, 27), 2);
    for (var i = 0; i < 2; i++) {
      expect(
        sums2[i].$2.balance!.netKcal,
        closeTo(sums1[i].$2.balance!.netKcal, 1e-6),
      );
    }
    // Réimport en fusion : aucun doublon.
    await svc2.apply(svc2.preview(zip), ImportMode.merge);
    expect(await dump(k2), await dump(k));
  });
}
