import 'dart:convert';

import 'package:drift/drift.dart';

import '../domain/balance.dart';
import '../domain/energy.dart';
import '../domain/enums.dart';
import '../domain/food_log.dart';
import '../domain/models.dart';
import '../domain/nutrition.dart';
import '../domain/quantities.dart';
import '../domain/stock.dart';
import '../domain/strength.dart';
import 'database.dart';
import 'product_catalog.dart';
import 'repository.dart';

// ------------------------------------------------------------- conversions

StockLot stockLotFromRow(StockLotRow r) => StockLot(
  id: r.id,
  barcode: r.barcode,
  ingredientId: r.ingredientId,
  label: r.label,
  quantity: r.quantity,
  unit: StockUnit.fromCode(r.unit),
  location: StockLocation.fromCode(r.location),
  addedAt: r.addedAt,
  bestBefore: r.bestBefore,
);

StockLotsCompanion stockLotCompanion(StockLot l) => StockLotsCompanion(
  barcode: Value(l.barcode),
  ingredientId: Value(l.ingredientId),
  label: Value(l.label),
  quantity: Value(l.quantity < 0 ? 0 : l.quantity),
  unit: Value(l.unit.code),
  location: Value(l.location.code),
  addedAt: Value(l.addedAt),
  bestBefore: Value(l.bestBefore),
);

String? nutrientsToText(Nutrients? n) =>
    n == null ? null : jsonEncode(n.toJson());

Nutrients? nutrientsFromText(String? s) => s == null
    ? null
    : Nutrients.fromJson(jsonDecode(s) as Map<String, dynamic>);

MealCompletion completionFromRow(MealCompletionRow r) => MealCompletion(
  id: r.id,
  menuId: r.menuId,
  slot: r.slot == null ? null : slotKeyFromCode(r.slot!),
  extraId: r.extraId,
  recipeId: r.recipeId,
  cookedServings: r.cookedServings,
  portionsEaten: r.portionsEaten,
  excluded: r.excluded.isEmpty ? {} : r.excluded.split(',').toSet(),
  replacements: (jsonDecode(r.replacements) as Map).cast<String, String>(),
  at: r.at,
);

FoodLogEntry logEntryFromRow(FoodLogEntryRow r) => FoodLogEntry(
  id: r.id,
  date: r.date,
  moment: Moment.fromCode(r.moment),
  label: r.label,
  source: LogSource.fromCode(r.source),
  ref: r.ref,
  grams: r.grams,
  macros: Macros(kcal: r.kcal, protein: r.protein, carbs: r.carbs, fat: r.fat),
  completionId: r.completionId,
);

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

/// Données V2 : produits, stock, repas faits, journal, nutrition et sport
/// (SPEC-V2 §3 à §9).
class KitchenRepository {
  KitchenRepository(this.db, this.base, this.catalog) {
    base.stockAwareLines = (m) async => (await stockPlan(m)).toBuy;
  }

  final AppDatabase db;
  final Repository base;

  /// Base produits importée (peut changer après un import).
  ProductCatalog Function() catalog;

  static const metaStockWeight = 'stock_weight';

  // --------------------------------------------------------------- produits

  Product _custom(CustomProductRow r) => Product(
    barcode: r.barcode,
    name: r.name,
    brand: r.brand,
    packageQty: r.packageQty,
    packageUnit: r.packageUnit == null
        ? null
        : StockUnit.fromCode(r.packageUnit!),
    servingG: r.servingG,
    nutrients: nutrientsFromText(r.nutrition),
    categories: r.categories.isEmpty ? const [] : r.categories.split(','),
    custom: true,
  );

  /// Produit perso d'abord, puis la base produits.
  Future<Product?> product(String barcode) async {
    final row = await (db.select(
      db.customProducts,
    )..where((t) => t.barcode.equals(barcode))).getSingleOrNull();
    if (row != null) return _custom(row);
    return catalog().byBarcode(barcode);
  }

  Future<List<Product>> searchProducts(String query) async {
    final q = query.trim();
    if (q.length < 2) return const [];
    final custom = await (db.select(
      db.customProducts,
    )..where((t) => t.name.like('%$q%'))).get();
    final mine = custom.map(_custom).toList();
    final codes = mine.map((p) => p.barcode).toSet();
    return [
      ...mine,
      for (final p in catalog().search(q))
        if (!codes.contains(p.barcode)) p,
    ];
  }

  /// Enregistre un produit saisi ou corrigé (devient un produit perso).
  Future<void> saveCustomProduct(Product p) => db
      .into(db.customProducts)
      .insertOnConflictUpdate(
        CustomProductsCompanion.insert(
          barcode: p.barcode,
          name: p.name,
          brand: Value(p.brand),
          packageQty: Value(p.packageQty),
          packageUnit: Value(p.packageUnit?.code),
          servingG: Value(p.servingG),
          nutrition: Value(nutrientsToText(p.nutrients)),
          categories: Value(p.categories.join(',')),
          updatedAt: DateTime.now(),
        ),
      );

  /// Lien mémorisé : null si jamais décidé ; `(ingredientId)` sinon (null =
  /// produit volontairement sans lien).
  Future<(String?,)?> link(String barcode) async {
    final row = await (db.select(
      db.productLinks,
    )..where((t) => t.barcode.equals(barcode))).getSingleOrNull();
    return row == null ? null : (row.ingredientId,);
  }

  Future<void> setLink(String barcode, String? ingredientId) => db
      .into(db.productLinks)
      .insertOnConflictUpdate(
        ProductLinksCompanion.insert(
          barcode: barcode,
          ingredientId: Value(ingredientId),
          linkedAt: DateTime.now(),
        ),
      );

  /// Conditionnement connu par ingrédient (produits liés), pour arrondir
  /// la liste au paquet.
  Future<Map<String, Product>> packagesByIngredient() async {
    final links = await (db.select(
      db.productLinks,
    )..where((t) => t.ingredientId.isNotNull())).get();
    final out = <String, Product>{};
    for (final l in links) {
      if (out.containsKey(l.ingredientId)) continue;
      final p = await product(l.barcode);
      if (p?.packageQty != null && p?.packageUnit != null) {
        out[l.ingredientId!] = p!;
      }
    }
    return out;
  }

  // ------------------------------------------------------------------ stock

  Future<List<StockLot>> stock({bool includeEmpty = false}) async {
    final q = db.select(db.stockLots);
    if (!includeEmpty) q.where((t) => t.quantity.isBiggerThanValue(0));
    return (await q.get()).map(stockLotFromRow).toList();
  }

  Future<int> _movement(
    StockLot lot,
    double delta,
    MovementKind kind, {
    int? completionId,
    int? logEntryId,
  }) => db
      .into(db.stockMovements)
      .insert(
        StockMovementsCompanion.insert(
          lotId: lot.id!,
          delta: delta,
          kind: kind.code,
          at: DateTime.now(),
          completionId: Value(completionId),
          logEntryId: Value(logEntryId),
          label: Value(lot.label),
          barcode: Value(lot.barcode),
          ingredientId: Value(lot.ingredientId),
          unit: Value(lot.unit.code),
          location: Value(lot.location.code),
        ),
      );

  /// Ajoute un lot ; renvoie l'id du mouvement d'entrée.
  Future<int> addLot(
    StockLot lot, {
    MovementKind kind = MovementKind.manualIn,
  }) => db.transaction(() async {
    final id = await db.into(db.stockLots).insert(stockLotCompanion(lot));
    return _movement(lot.copyWith(id: id), lot.quantity, kind);
  });

  /// Scan : ajoute un paquet (× [multiplier]) ou [quantity] du produit.
  Future<int> addProduct(
    Product p, {
    String? ingredientId,
    Ingredient? ingredient,
    double multiplier = 1,
    double? quantity,
    StockLocation? location,
  }) {
    final unit = p.packageUnit ?? StockUnit.piece;
    final qty = quantity ?? (p.packageQty ?? 1) * multiplier;
    return addLot(
      StockLot(
        barcode: p.barcode,
        ingredientId: ingredientId,
        label: p.displayName,
        quantity: qty,
        unit: unit,
        location: location ?? defaultLocation(ingredient),
        addedAt: DateTime.now(),
      ),
      kind: MovementKind.scanIn,
    );
  }

  Future<StockLot?> _lot(int id) async {
    final r = await (db.select(
      db.stockLots,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return r == null ? null : stockLotFromRow(r);
  }

  /// Ajuste la quantité (jamais négative) et journalise l'écart.
  Future<void> adjustLot(int id, double quantity) => db.transaction(() async {
    final lot = await _lot(id);
    if (lot == null) return;
    final q = quantity < 0 ? 0.0 : quantity;
    await (db.update(db.stockLots)..where((t) => t.id.equals(id))).write(
      StockLotsCompanion(quantity: Value(q)),
    );
    await _movement(lot, q - lot.quantity, MovementKind.adjust);
  });

  Future<void> finishLot(int id) => adjustLot(id, 0);

  Future<void> deleteLot(int id) =>
      (db.delete(db.stockLots)..where((t) => t.id.equals(id))).go();

  Future<void> updateLot(
    int id, {
    StockLocation? location,
    DateTime? bestBefore,
    bool clearBestBefore = false,
  }) => (db.update(db.stockLots)..where((t) => t.id.equals(id))).write(
    StockLotsCompanion(
      location: location == null ? const Value.absent() : Value(location.code),
      bestBefore: clearBestBefore
          ? const Value(null)
          : (bestBefore == null ? const Value.absent() : Value(bestBefore)),
    ),
  );

  /// Annule un mouvement d'entrée (« annuler le dernier » du rangement).
  Future<void> undoEntry(int movementId) => db.transaction(() async {
    final m = await (db.select(
      db.stockMovements,
    )..where((t) => t.id.equals(movementId))).getSingleOrNull();
    if (m == null) return;
    final lot = await _lot(m.lotId);
    if (lot != null) {
      final left = lot.quantity - m.delta;
      if (left <= 1e-9) {
        await deleteLot(lot.id!);
      } else {
        await (db.update(db.stockLots)..where((t) => t.id.equals(lot.id!)))
            .write(StockLotsCompanion(quantity: Value(left)));
      }
    }
    await (db.delete(
      db.stockMovements,
    )..where((t) => t.id.equals(movementId))).go();
  });

  Future<List<StockMovement>> movements({int limit = 200}) async {
    final rows =
        await (db.select(db.stockMovements)
              ..orderBy([(t) => OrderingTerm.desc(t.id)])
              ..limit(limit))
            .get();
    return [
      for (final r in rows)
        StockMovement(
          id: r.id,
          lotId: r.lotId,
          delta: r.delta,
          kind: MovementKind.fromCode(r.kind),
          at: r.at,
          completionId: r.completionId,
          logEntryId: r.logEntryId,
          label: r.label,
        ),
    ];
  }

  /// Applique des sorties ; renvoie rien. Chaque sortie est journalisée.
  Future<void> _withdraw(
    List<Withdrawal> ws,
    MovementKind kind, {
    int? completionId,
    int? logEntryId,
  }) async {
    for (final w in ws) {
      final lot = await _lot(w.lotId);
      if (lot == null) continue;
      final take = w.quantity > lot.quantity ? lot.quantity : w.quantity;
      if (take <= 0) continue;
      await (db.update(db.stockLots)..where((t) => t.id.equals(lot.id!))).write(
        StockLotsCompanion(quantity: Value(lot.quantity - take)),
      );
      await _movement(
        lot,
        -take,
        kind,
        completionId: completionId,
        logEntryId: logEntryId,
      );
    }
  }

  /// Remet exactement le stock retiré par les mouvements donnés (recrée le
  /// lot s'il a été supprimé entre-temps), puis efface ces mouvements.
  Future<void> _restore(List<StockMovementRow> moves) async {
    for (final m in moves) {
      final lot = await _lot(m.lotId);
      if (lot != null) {
        await (db.update(db.stockLots)..where((t) => t.id.equals(lot.id!)))
            .write(StockLotsCompanion(quantity: Value(lot.quantity - m.delta)));
      } else if (m.unit != null) {
        await db
            .into(db.stockLots)
            .insert(
              StockLotsCompanion.insert(
                id: Value(m.lotId),
                barcode: Value(m.barcode),
                ingredientId: Value(m.ingredientId),
                label: m.label ?? '',
                quantity: -m.delta,
                unit: m.unit!,
                location: m.location ?? StockLocation.pantry.code,
                addedAt: m.at,
              ),
            );
      }
      await (db.delete(
        db.stockMovements,
      )..where((t) => t.id.equals(m.id))).go();
    }
  }

  // ------------------------------------------------------------ repas faits

  Future<Map<String, MealCompletion>> completions(int menuId) async {
    final rows = await (db.select(
      db.mealCompletions,
    )..where((t) => t.menuId.equals(menuId))).get();
    return {
      for (final r in rows)
        completionKey(completionFromRow(r)): completionFromRow(r),
    };
  }

  static String completionKey(MealCompletion c) =>
      c.slot != null ? 'slot:${slotKeyCode(c.slot!)}' : 'extra:${c.extraId}';

  /// « Fait » (SPEC-V2 §6) : sortie de stock min(besoin, stock) pour les
  /// portions cuisinées, puis ma part au journal du jour (recette complète
  /// telle que prévue). Un seul geste, aucune erreur si le stock manque.
  Future<int> markDone({
    required WeekMenu menu,
    required Recipe recipe,
    required DateTime date,
    SlotKey? slot,
    int? extraId,
    required int cookedServings,
    double portionsEaten = 1,
    Set<String> excluded = const {},
    Map<String, String> replacements = const {},
  }) async {
    final catalogue = {for (final i in await base.ingredients()) i.id: i};
    final repl = {
      for (final e in replacements.entries)
        if (catalogue[e.value] != null) e.key: catalogue[e.value]!,
    };
    return db.transaction(() async {
      final id = await db
          .into(db.mealCompletions)
          .insert(
            MealCompletionsCompanion.insert(
              menuId: menu.id!,
              slot: Value(slot == null ? null : slotKeyCode(slot)),
              extraId: Value(extraId),
              recipeId: recipe.id,
              cookedServings: cookedServings,
              portionsEaten: Value(portionsEaten),
              excluded: Value(excluded.join(',')),
              replacements: Value(jsonEncode(replacements)),
              at: DateTime.now(),
            ),
          );
      if (cookedServings > 0) {
        final ws = planMealWithdrawals(
          recipe,
          cookedServings,
          await stock(),
          catalogue,
          excluded: excluded,
          replacements: repl,
        );
        await _withdraw(ws, MovementKind.mealOut, completionId: id);
      }
      if (portionsEaten > 0) {
        final macros = mealPortionMacros(
          recipe,
          portions: portionsEaten,
          excluded: excluded,
          replacements: repl,
        );
        await _insertLog(
          FoodLogEntry(
            date: date,
            moment: slot == null ? Moment.dinner : Moment.forMeal(slot.meal),
            label: recipe.title,
            source: LogSource.meal,
            ref: '${recipe.id}',
            macros: macros,
            completionId: id,
          ),
        );
      }
      return id;
    });
  }

  /// Annule « Fait » : remet exactement le stock retiré et retire l'entrée
  /// du journal.
  Future<void> undoDone(int completionId) => db.transaction(() async {
    final moves = await (db.select(
      db.stockMovements,
    )..where((t) => t.completionId.equals(completionId))).get();
    await _restore(moves);
    await (db.delete(
      db.foodLogEntries,
    )..where((t) => t.completionId.equals(completionId))).go();
    await (db.delete(
      db.mealCompletions,
    )..where((t) => t.id.equals(completionId))).go();
  });

  // ---------------------------------------------------------------- journal

  Future<int> _insertLog(FoodLogEntry e) => db
      .into(db.foodLogEntries)
      .insert(
        FoodLogEntriesCompanion.insert(
          date: _day(e.date),
          moment: e.moment.code,
          label: e.label,
          source: e.source.code,
          ref: Value(e.ref),
          grams: Value(e.grams),
          kcal: e.macros.kcal,
          protein: Value(e.macros.protein),
          carbs: Value(e.macros.carbs),
          fat: Value(e.macros.fat),
          completionId: Value(e.completionId),
        ),
      );

  /// Saisie libre ou repas dehors : rien ne sort du stock.
  Future<int> addLogEntry(FoodLogEntry e) => _insertLog(e);

  /// « J'ai mangé » (SPEC-V2 §6) : journal + sortie de stock avec la règle
  /// min(besoin, stock). [ingredient] ou [barcode] désignent ce qui sort.
  Future<int> eat(
    FoodLogEntry e, {
    Ingredient? ingredient,
    String? barcode,
    double? grams,
    List<(Ingredient, double)> items = const [],
  }) => db.transaction(() async {
    final id = await _insertLog(e);
    // Repas de la banque : chaque ligne liée à un ingrédient sort du stock.
    for (final (ing, g) in items) {
      final ws = planWithdrawal(ing, Amount(Dimension.mass, g), await stock());
      await _withdraw(ws, MovementKind.eatenOut, logEntryId: id);
    }
    if (grams != null && grams > 0) {
      final lots = await stock();
      final need = Amount(Dimension.mass, grams);
      List<Withdrawal> ws;
      if (ingredient != null) {
        ws = planWithdrawal(ingredient, need, lots);
      } else if (barcode != null) {
        // Produit sans lien : ses propres lots, convertis via les grammes.
        final pseudo = Ingredient(
          id: '#$barcode',
          name: barcode,
          aisle: Aisle.misc,
          defaultUnit: Unit.g,
        );
        ws = planWithdrawal(pseudo, need, [
          for (final l in lots)
            if (l.barcode == barcode && l.unit != StockUnit.piece)
              l.copyWith(ingredientId: pseudo.id),
        ]);
      } else {
        ws = const [];
      }
      await _withdraw(ws, MovementKind.eatenOut, logEntryId: id);
    }
    return id;
  });

  /// Supprime une entrée du journal et remet le stock qu'elle avait retiré.
  Future<void> deleteLogEntry(int id) => db.transaction(() async {
    final row = await (db.select(
      db.foodLogEntries,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    if (row.completionId != null) {
      await undoDone(row.completionId!);
      return;
    }
    final moves = await (db.select(
      db.stockMovements,
    )..where((t) => t.logEntryId.equals(id))).get();
    await _restore(moves);
    await (db.delete(db.foodLogEntries)..where((t) => t.id.equals(id))).go();
  });

  Future<List<FoodLogEntry>> logEntries(DateTime from, DateTime to) async {
    final rows =
        await (db.select(db.foodLogEntries)
              ..where(
                (t) =>
                    t.date.isBiggerOrEqualValue(_day(from)) &
                    t.date.isSmallerOrEqualValue(_day(to)),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.id)]))
            .get();
    return rows.map(logEntryFromRow).toList();
  }

  // ----------------------------------------------------- banque de repas

  Future<List<MealPreset>> presets() async {
    final rows = await (db.select(
      db.mealPresets,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
    final items = await (db.select(
      db.mealPresetItems,
    )..orderBy([(t) => OrderingTerm.asc(t.position)])).get();
    return [
      for (final r in rows)
        MealPreset(
          id: r.id,
          name: r.name,
          defaultMoment: r.defaultMoment == null
              ? null
              : Moment.fromCode(r.defaultMoment!),
          recipeId: r.recipeId,
          recipePortions: r.recipePortions,
          items: [
            for (final i in items)
              if (i.presetId == r.id)
                PresetItem(
                  label: i.label,
                  grams: i.grams,
                  nutrients: nutrientsFromText(i.nutrition)!,
                  ingredientId: i.ingredientId,
                  barcode: i.barcode,
                ),
          ],
        ),
    ];
  }

  Future<int> savePreset(MealPreset p) => db.transaction(() async {
    final companion = MealPresetsCompanion.insert(
      name: p.name,
      defaultMoment: Value(p.defaultMoment?.code),
      recipeId: Value(p.recipeId),
      recipePortions: Value(p.recipePortions),
      createdAt: DateTime.now(),
    );
    int id;
    if (p.id == null) {
      id = await db.into(db.mealPresets).insert(companion);
    } else {
      id = p.id!;
      await (db.update(
        db.mealPresets,
      )..where((t) => t.id.equals(id))).write(companion);
      await (db.delete(
        db.mealPresetItems,
      )..where((t) => t.presetId.equals(id))).go();
    }
    var pos = 0;
    for (final i in p.items) {
      await db
          .into(db.mealPresetItems)
          .insert(
            MealPresetItemsCompanion.insert(
              presetId: id,
              label: i.label,
              grams: i.grams,
              nutrition: nutrientsToText(i.nutrients)!,
              ingredientId: Value(i.ingredientId),
              barcode: Value(i.barcode),
              position: pos++,
            ),
          );
    }
    return id;
  });

  Future<void> deletePreset(int id) =>
      (db.delete(db.mealPresets)..where((t) => t.id.equals(id))).go();

  // ------------------------------------------------------------- nutrition

  Future<NutritionProfile?> nutritionProfile() async {
    final r = await db.select(db.nutritionProfiles).getSingleOrNull();
    return r == null
        ? null
        : NutritionProfile(
            sex: Sex.fromCode(r.sex),
            birthDate: r.birthDate,
            heightCm: r.heightCm,
            activity: ActivityLevel.fromCode(r.activity),
          );
  }

  Future<void> saveNutritionProfile(NutritionProfile p) => db
      .into(db.nutritionProfiles)
      .insertOnConflictUpdate(
        NutritionProfilesCompanion.insert(
          id: const Value(1),
          sex: p.sex.code,
          birthDate: p.birthDate,
          heightCm: p.heightCm,
          activity: p.activity.code,
        ),
      );

  Future<List<Goal>> goals() async => [
    for (final r in await db.select(db.nutritionGoals).get())
      Goal(
        id: r.id,
        startDate: r.startDate,
        kind: GoalKind.fromCode(r.kind),
        dailyKcalDelta: r.dailyKcalDelta,
        targetWeightKg: r.targetWeightKg,
      ),
  ];

  Future<void> addGoal(Goal g) => db
      .into(db.nutritionGoals)
      .insert(
        NutritionGoalsCompanion.insert(
          startDate: _day(g.startDate),
          kind: g.kind.code,
          dailyKcalDelta: g.dailyKcalDelta,
          targetWeightKg: Value(g.targetWeightKg),
        ),
      );

  Future<List<WeightPoint>> weights() async => [
    for (final r in await (db.select(
      db.bodyWeights,
    )..orderBy([(t) => OrderingTerm.asc(t.date)])).get())
      WeightPoint(
        id: r.id,
        date: r.date,
        weightKg: r.weightKg,
        bodyFatPct: r.bodyFatPct,
      ),
  ];

  Future<void> addWeight(WeightPoint w) => db
      .into(db.bodyWeights)
      .insert(
        BodyWeightsCompanion.insert(
          date: _day(w.date),
          weightKg: w.weightKg,
          bodyFatPct: Value(w.bodyFatPct),
        ),
      );

  Future<void> deleteWeight(int id) =>
      (db.delete(db.bodyWeights)..where((t) => t.id.equals(id))).go();

  Future<Map<DateTime, int>> steps(DateTime from, DateTime to) async => {
    for (final r
        in await (db.select(db.dailySteps)..where(
              (t) =>
                  t.date.isBiggerOrEqualValue(_day(from)) &
                  t.date.isSmallerOrEqualValue(_day(to)),
            ))
            .get())
      r.date: r.steps,
  };

  /// Une valeur par jour : la nouvelle remplace l'ancienne.
  Future<void> setSteps(DateTime day, int? steps) async {
    if (steps == null) {
      await (db.delete(
        db.dailySteps,
      )..where((t) => t.date.equals(_day(day)))).go();
      return;
    }
    await db
        .into(db.dailySteps)
        .insertOnConflictUpdate(
          DailyStepsCompanion.insert(date: _day(day), steps: steps),
        );
  }

  Future<List<Workout>> workouts(DateTime from, DateTime to) async => [
    for (final r
        in await (db.select(db.workouts)..where(
              (t) =>
                  t.date.isBiggerOrEqualValue(_day(from)) &
                  t.date.isSmallerOrEqualValue(_day(to)),
            ))
            .get())
      Workout(
        id: r.id,
        date: r.date,
        exerciseName: r.exerciseName,
        met: r.met,
        durationMin: r.durationMin,
        intensity: Intensity.fromCode(r.intensity),
        kcalOverride: r.kcalOverride,
        note: r.note,
      ),
  ];

  Future<void> addWorkout(Workout w) => db
      .into(db.workouts)
      .insert(
        WorkoutsCompanion.insert(
          date: _day(w.date),
          exerciseName: w.exerciseName,
          met: w.met,
          durationMin: w.durationMin,
          intensity: Value(w.intensity.code),
          kcalOverride: Value(w.kcalOverride),
          note: Value(w.note),
        ),
      );

  Future<void> deleteWorkout(int id) =>
      (db.delete(db.workouts)..where((t) => t.id.equals(id))).go();

  Future<List<StrengthSession>> strengthSessions(
    DateTime from,
    DateTime to,
  ) async {
    final rows =
        await (db.select(db.strengthSessions)..where(
              (t) =>
                  t.date.isBiggerOrEqualValue(_day(from)) &
                  t.date.isSmallerOrEqualValue(_day(to)),
            ))
            .get();
    final sets = await (db.select(
      db.strengthSets,
    )..orderBy([(t) => OrderingTerm.asc(t.setIndex)])).get();
    return [
      for (final r in rows)
        StrengthSession(
          id: r.id,
          date: r.date,
          name: r.name,
          durationMin: r.durationMin,
          kcalOverride: r.kcalOverride,
          note: r.note,
          sets: [
            for (final s in sets)
              if (s.sessionId == r.id)
                StrengthSet(
                  id: s.id,
                  exercise: s.exercise,
                  setIndex: s.setIndex,
                  reps: s.reps,
                  weightKg: s.weightKg,
                  restSec: s.restSec,
                ),
          ],
        ),
    ];
  }

  Future<int> addStrengthSession(StrengthSession s) => db.transaction(() async {
    final id = await db
        .into(db.strengthSessions)
        .insert(
          StrengthSessionsCompanion.insert(
            date: _day(s.date),
            name: Value(s.name),
            durationMin: Value(s.durationMin),
            kcalOverride: Value(s.kcalOverride),
            note: Value(s.note),
          ),
        );
    for (final set in s.sets) {
      await db
          .into(db.strengthSets)
          .insert(
            StrengthSetsCompanion.insert(
              sessionId: id,
              exercise: set.exercise,
              setIndex: set.setIndex,
              reps: set.reps,
              weightKg: set.weightKg,
              restSec: Value(set.restSec),
            ),
          );
    }
    return id;
  });

  Future<void> deleteStrengthSession(int id) =>
      (db.delete(db.strengthSessions)..where((t) => t.id.equals(id))).go();

  /// Bilans de [days] jours (du plus ancien au plus récent) se terminant à
  /// [end].
  Future<List<(DateTime, DaySummary)>> summaries(DateTime end, int days) async {
    final last = _day(end);
    final first = last.subtract(Duration(days: days - 1));
    final profile = await nutritionProfile();
    final allGoals = await goals();
    final allWeights = await weights();
    final log = await logEntries(first, last);
    final allSteps = await steps(first, last);
    final allWorkouts = await workouts(first, last);
    final allStrength = await strengthSessions(first, last);
    return [
      for (var i = 0; i < days; i++)
        () {
          final d = DateTime(first.year, first.month, first.day + i);
          bool same(DateTime x) => _day(x) == d;
          return (
            d,
            summarizeDay(
              day: d,
              profile: profile,
              weightKg: weightOnDay(allWeights, d),
              goalDailyKcalDelta: goalOnDay(allGoals, d)?.dailyKcalDelta,
              intake: sumMacros(
                log.where((e) => same(e.date)).map((e) => e.macros),
              ),
              workouts: allWorkouts.where((w) => same(w.date)).toList(),
              strength: allStrength.where((s) => same(s.date)).toList(),
              steps: allSteps[d],
            ),
          );
        }(),
    ];
  }

  // ----------------------------------------------------- liste avec stock

  /// Usages chronologiques des créneaux pas encore faits et des extras
  /// (SPEC-V2 §7). Les restes sont cuisinés avec le créneau source.
  Future<List<PlannedUse>> plannedUses(WeekMenu m) async {
    final recipes = {for (final r in await base.recipes()) r.id: r};
    final done = m.id == null
        ? <String, MealCompletion>{}
        : await completions(m.id!);
    final uses = <PlannedUse>[];
    final slots = [...m.slots]..sort((a, b) => a.key.compareTo(b.key));
    for (final s in slots) {
      if (s.kind != SlotKind.recipe || s.recipeId == null) continue;
      if (done.containsKey('slot:${slotKeyCode(s.key)}')) continue;
      final r = recipes[s.recipeId];
      if (r == null) continue;
      var servings = s.servings;
      for (final o in slots) {
        if (o.kind == SlotKind.leftovers && o.leftoversFrom == s.key) {
          servings += o.servings;
        }
      }
      uses.add(PlannedUse(recipe: r, servings: servings, slot: s.key));
    }
    for (final e in m.extras) {
      if (done.containsKey('extra:${e.id}')) continue;
      final r = recipes[e.recipeId];
      if (r != null) uses.add(PlannedUse(recipe: r, servings: e.servings));
    }
    return uses;
  }

  Future<StockPlan> stockPlan(WeekMenu m) async =>
      planShoppingWithStock(await plannedUses(m), await stock());

  Future<double> stockWeight() async =>
      double.tryParse(await base.meta(metaStockWeight) ?? '') ?? 10;

  Future<void> setStockWeight(double w) => base.setMeta(metaStockWeight, '$w');
}
