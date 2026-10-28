import 'dart:convert';

import 'package:drift/drift.dart';

import '../domain/enums.dart';
import '../domain/models.dart';
import '../domain/nutrition.dart';
import '../domain/shopping.dart';
import 'database.dart';
import 'seed.dart';

String _joinCodes(Iterable<String> codes) => codes.join(',');
List<String> _split(String s) =>
    s.isEmpty ? const [] : s.split(',').where((e) => e.isNotEmpty).toList();

String slotKeyCode(SlotKey k) => '${k.day}:${k.meal.code}';
SlotKey slotKeyFromCode(String c) {
  final parts = c.split(':');
  return SlotKey(int.parse(parts[0]), Meal.fromCode(parts[1]));
}

/// Accès aux données : convertit les lignes drift en modèles du domaine.
class Repository {
  Repository(this.db);

  final AppDatabase db;

  static const metaSeedVersion = 'seed_version';
  static const metaLastReviewedWeek = 'last_reviewed_week';

  // ---------------------------------------------------------------- méta

  Future<String?> meta(String key) async {
    final row = await (db.select(
      db.appMeta,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> setMeta(String key, String value) => db
      .into(db.appMeta)
      .insertOnConflictUpdate(AppMetaCompanion.insert(key: key, value: value));

  // ---------------------------------------------------------------- seed

  /// Importe les données fournies si la version du seed a augmenté. Mise à
  /// jour par slug : l'état utilisateur et les recettes perso ne sont jamais
  /// touchés. Idempotent.
  Future<bool> importSeedIfNeeded(SeedSource src) async {
    final manifest = parseManifest(await src.read('seed.json'));
    final current = int.tryParse(await meta(metaSeedVersion) ?? '') ?? 0;
    if (manifest.version <= current) return false;
    final data = await loadSeed(src);
    await importSeed(data);
    return true;
  }

  Future<void> importSeed(SeedData data) async {
    final now = DateTime.now();
    await db.transaction(() async {
      for (final i in data.ingredients) {
        await db
            .into(db.ingredients)
            .insertOnConflictUpdate(_ingredientCompanion(i, Origin.provided));
      }
      for (final r in data.recipes) {
        final existing = await (db.select(
          db.recipes,
        )..where((t) => t.slug.equals(r.slug))).getSingleOrNull();
        final companion = RecipesCompanion(
          slug: Value(r.slug),
          title: Value(r.title),
          description: Value(r.description),
          type: Value(r.type.code),
          servings: Value(r.servings),
          prepMin: Value(r.prepMin),
          cookMin: Value(r.cookMin),
          difficulty: Value(r.difficulty.code),
          equipment: Value(_joinCodes(r.equipment.map((e) => e.code))),
          mainBase: Value(r.mainBase.code),
          origin: Value(Origin.provided.code),
          seedVersion: Value(data.manifest.version),
          updatedAt: Value(now),
        );
        int id;
        if (existing == null) {
          id = await db
              .into(db.recipes)
              .insert(companion.copyWith(createdAt: Value(now)));
        } else {
          id = existing.id;
          await (db.update(
            db.recipes,
          )..where((t) => t.id.equals(id))).write(companion);
          await (db.delete(
            db.recipeIngredients,
          )..where((t) => t.recipeId.equals(id))).go();
          await (db.delete(
            db.recipeSteps,
          )..where((t) => t.recipeId.equals(id))).go();
        }
        var pos = 0;
        for (final l in r.lines) {
          await db
              .into(db.recipeIngredients)
              .insert(
                RecipeIngredientsCompanion.insert(
                  recipeId: id,
                  ingredientId: l.ingredientId,
                  qty: l.qty,
                  unit: l.unit.code,
                  optional: Value(l.optional),
                  note: Value(l.note),
                  position: pos++,
                ),
              );
        }
        pos = 0;
        for (final s in r.steps) {
          await db
              .into(db.recipeSteps)
              .insert(
                RecipeStepsCompanion.insert(
                  recipeId: id,
                  position: pos++,
                  body: s,
                ),
              );
        }
      }
      await setMeta(metaSeedVersion, '${data.manifest.version}');
    });
  }

  // --------------------------------------------------------- ingrédients

  IngredientsCompanion _ingredientCompanion(Ingredient i, Origin origin) =>
      IngredientsCompanion.insert(
        id: i.id,
        name: i.name,
        aisle: i.aisle.code,
        defaultUnit: i.defaultUnit.code,
        avgPieceWeightG: Value(i.avgPieceWeightG),
        pantry: Value(i.pantry),
        perishable: Value(i.perishable),
        markers: Value(_joinCodes(i.markers.map((m) => m.code))),
        allergens: Value(_joinCodes(i.allergens.map((a) => a.code))),
        seasonMonths: Value(_joinCodes(i.seasonMonths.map((m) => '$m'))),
        origin: origin.code,
        nutrition: Value(
          i.nutrition == null ? null : jsonEncode(i.nutrition!.toJson()),
        ),
        density: Value(i.density),
        ciqualCode: Value(i.ciqualCode),
      );

  Ingredient _ingredient(IngredientRow r) => Ingredient(
    id: r.id,
    name: r.name,
    aisle: Aisle.fromCode(r.aisle),
    defaultUnit: Unit.fromCode(r.defaultUnit),
    avgPieceWeightG: r.avgPieceWeightG,
    pantry: r.pantry,
    perishable: r.perishable,
    markers: _split(r.markers).map(Marker.fromCode).toSet(),
    allergens: _split(r.allergens).map(Allergen.fromCode).toSet(),
    seasonMonths: _split(r.seasonMonths).map(int.parse).toSet(),
    origin: Origin.fromCode(r.origin),
    nutrition: r.nutrition == null
        ? null
        : Nutrients.fromJson(jsonDecode(r.nutrition!) as Map<String, dynamic>),
    density: r.density,
    ciqualCode: r.ciqualCode,
  );

  Future<List<Ingredient>> ingredients() async {
    final rows = await (db.select(
      db.ingredients,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
    return rows.map(_ingredient).toList();
  }

  /// Crée un ingrédient perso (éditeur de recette).
  Future<Ingredient> createIngredient(Ingredient i) async {
    final base = 'perso-${_slugify(i.name)}';
    var id = base;
    var n = 2;
    while (await (db.select(
          db.ingredients,
        )..where((t) => t.id.equals(id))).getSingleOrNull() !=
        null) {
      id = '$base-${n++}';
    }
    final created = Ingredient(
      id: id,
      name: i.name,
      aisle: i.aisle,
      defaultUnit: i.defaultUnit,
      avgPieceWeightG: i.avgPieceWeightG,
      pantry: i.pantry,
      perishable: i.perishable,
      markers: i.markers,
      allergens: i.allergens,
      seasonMonths: i.seasonMonths,
      origin: Origin.personal,
      nutrition: i.nutrition,
      density: i.density,
      ciqualCode: i.ciqualCode,
    );
    await db
        .into(db.ingredients)
        .insert(_ingredientCompanion(created, Origin.personal));
    return created;
  }

  Future<void> upsertIngredient(Ingredient i) => db
      .into(db.ingredients)
      .insertOnConflictUpdate(_ingredientCompanion(i, i.origin));

  // ------------------------------------------------------------ recettes

  Future<List<Recipe>> recipes() async {
    final ingredientsById = {for (final i in await ingredients()) i.id: i};
    final rows = await db.select(db.recipes).get();
    final lines = await (db.select(
      db.recipeIngredients,
    )..orderBy([(t) => OrderingTerm.asc(t.position)])).get();
    final steps = await (db.select(
      db.recipeSteps,
    )..orderBy([(t) => OrderingTerm.asc(t.position)])).get();
    final linesBy = <int, List<RecipeIngredientRow>>{};
    for (final l in lines) {
      (linesBy[l.recipeId] ??= []).add(l);
    }
    final stepsBy = <int, List<String>>{};
    for (final s in steps) {
      (stepsBy[s.recipeId] ??= []).add(s.body);
    }
    final out = [
      for (final r in rows)
        _recipe(
          r,
          linesBy[r.id] ?? const [],
          stepsBy[r.id] ?? const [],
          ingredientsById,
        ),
    ];
    out.sort((a, b) => a.title.compareTo(b.title));
    return out;
  }

  Recipe _recipe(
    RecipeRow r,
    List<RecipeIngredientRow> lines,
    List<String> steps,
    Map<String, Ingredient> ingredientsById,
  ) => Recipe(
    id: r.id,
    slug: r.slug,
    title: r.title,
    description: r.description,
    type: RecipeType.fromCode(r.type),
    servings: r.servings,
    prepMin: r.prepMin,
    cookMin: r.cookMin,
    difficulty: Difficulty.fromCode(r.difficulty),
    equipment: _split(r.equipment).map(Equipment.fromCode).toSet(),
    mainBase: MainBase.fromCode(r.mainBase),
    origin: Origin.fromCode(r.origin),
    seedVersion: r.seedVersion,
    photoPath: r.photoPath,
    ingredients: [
      for (final l in lines)
        if (ingredientsById[l.ingredientId] != null)
          RecipeIngredient(
            ingredient: ingredientsById[l.ingredientId]!,
            qty: l.qty,
            unit: Unit.fromCode(l.unit),
            optional: l.optional,
            note: l.note,
          ),
    ],
    steps: steps,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );

  /// Enregistre une recette perso (création si id == 0). Renvoie son id.
  Future<int> savePersonalRecipe(Recipe r) async {
    final now = DateTime.now();
    return db.transaction(() async {
      final companion = RecipesCompanion(
        slug: const Value(null),
        title: Value(r.title),
        description: Value(r.description),
        type: Value(r.type.code),
        servings: Value(r.servings),
        prepMin: Value(r.prepMin),
        cookMin: Value(r.cookMin),
        difficulty: Value(r.difficulty.code),
        equipment: Value(_joinCodes(r.equipment.map((e) => e.code))),
        mainBase: Value(r.mainBase.code),
        origin: Value(Origin.personal.code),
        seedVersion: const Value(null),
        photoPath: Value(r.photoPath),
        updatedAt: Value(r.updatedAt ?? now),
      );
      int id;
      if (r.id == 0) {
        id = await db
            .into(db.recipes)
            .insert(companion.copyWith(createdAt: Value(r.createdAt ?? now)));
      } else {
        id = r.id;
        await (db.update(
          db.recipes,
        )..where((t) => t.id.equals(id))).write(companion);
        await (db.delete(
          db.recipeIngredients,
        )..where((t) => t.recipeId.equals(id))).go();
        await (db.delete(
          db.recipeSteps,
        )..where((t) => t.recipeId.equals(id))).go();
      }
      var pos = 0;
      for (final l in r.ingredients) {
        await db
            .into(db.recipeIngredients)
            .insert(
              RecipeIngredientsCompanion.insert(
                recipeId: id,
                ingredientId: l.ingredient.id,
                qty: l.qty,
                unit: l.unit.code,
                optional: Value(l.optional),
                note: Value(l.note),
                position: pos++,
              ),
            );
      }
      pos = 0;
      for (final s in r.steps) {
        await db
            .into(db.recipeSteps)
            .insert(
              RecipeStepsCompanion.insert(
                recipeId: id,
                position: pos++,
                body: s,
              ),
            );
      }
      return id;
    });
  }

  /// Duplique une recette (fournie ou perso) en recette perso.
  Future<int> duplicateRecipe(Recipe r, String titleSuffix) =>
      savePersonalRecipe(
        r.copyWith(
          id: 0,
          clearSlug: true,
          title: '${r.title}$titleSuffix',
          origin: Origin.personal,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

  /// Supprime une recette perso et ce qui y fait référence.
  Future<void> deleteRecipe(int id) => db.transaction(() async {
    await (db.update(db.menuSlots)..where((t) => t.recipeId.equals(id))).write(
      MenuSlotsCompanion(
        kind: Value(SlotKind.empty.code),
        recipeId: const Value(null),
      ),
    );
    await (db.delete(db.weekExtras)..where((t) => t.recipeId.equals(id))).go();
    await (db.delete(
      db.recipeUserStates,
    )..where((t) => t.recipeId.equals(id))).go();
    await (db.delete(
      db.recipeIngredients,
    )..where((t) => t.recipeId.equals(id))).go();
    await (db.delete(db.recipeSteps)..where((t) => t.recipeId.equals(id))).go();
    await (db.delete(db.recipes)..where((t) => t.id.equals(id))).go();
  });

  // ------------------------------------------------------ état utilisateur

  Future<Map<int, RecipeUserState>> userStates() async {
    final rows = await db.select(db.recipeUserStates).get();
    return {
      for (final r in rows)
        r.recipeId: RecipeUserState(
          favorite: r.favorite,
          toPlace: r.toPlace,
          disliked: r.disliked,
          lastPlannedAt: r.lastPlannedAt,
        ),
    };
  }

  Future<void> setUserState(int recipeId, RecipeUserState s) => db
      .into(db.recipeUserStates)
      .insertOnConflictUpdate(
        RecipeUserStatesCompanion.insert(
          recipeId: Value(recipeId),
          favorite: Value(s.favorite),
          toPlace: Value(s.toPlace),
          disliked: Value(s.disliked),
          lastPlannedAt: Value(s.lastPlannedAt),
        ),
      );

  Future<void> updateUserState(
    int recipeId,
    RecipeUserState Function(RecipeUserState) f,
  ) async {
    final current = (await userStates())[recipeId] ?? RecipeUserState.none;
    await setUserState(recipeId, f(current));
  }

  // --------------------------------------------------------------- profil

  Future<bool> isOnboarded() async {
    final row = await (db.select(
      db.profiles,
    )..where((t) => t.id.equals(1))).getSingleOrNull();
    return row?.onboarded ?? false;
  }

  Future<HouseholdProfile> profile() async {
    final row = await (db.select(
      db.profiles,
    )..where((t) => t.id.equals(1))).getSingleOrNull();
    if (row == null) return HouseholdProfile();
    final aversions = await db.select(db.profileAversions).get();
    final exclusions = await db.select(db.profileExclusions).get();
    final equipment = await db.select(db.profileEquipment).get();
    final slots = await db.select(db.profileSlots).get();
    final order = _split(row.aisleOrder).map(Aisle.fromCode).toList();
    for (final a in Aisle.values) {
      if (!order.contains(a)) order.add(a);
    }
    return HouseholdProfile(
      people: row.people,
      diet: Diet.fromCode(row.diet),
      noPork: row.noPork,
      exclusions: exclusions.map((e) => Allergen.fromCode(e.allergen)).toSet(),
      aversions: aversions.map((a) => a.ingredientId).toSet(),
      equipment: equipment.map((e) => Equipment.fromCode(e.equipment)).toSet(),
      activeSlots: slots
          .map((s) => SlotKey(s.day, Meal.fromCode(s.meal)))
          .toSet(),
      maxMinWeekday: row.maxMinWeekday,
      maxMinWeekend: row.maxMinWeekend,
      weekStartDay: row.weekStartDay,
      favoriteShare: row.favoriteShare,
      antiRepeatWeeks: row.antiRepeatWeeks,
      aisleOrder: order,
      theme: ThemePreference.fromCode(row.themeMode),
    );
  }

  Future<void> saveProfile(HouseholdProfile p, {bool onboarded = true}) =>
      db.transaction(() async {
        await db
            .into(db.profiles)
            .insertOnConflictUpdate(
              ProfilesCompanion.insert(
                id: const Value(1),
                onboarded: Value(onboarded),
                people: Value(p.people),
                diet: Value(p.diet.code),
                noPork: Value(p.noPork),
                maxMinWeekday: Value(p.maxMinWeekday),
                maxMinWeekend: Value(p.maxMinWeekend),
                weekStartDay: Value(p.weekStartDay),
                favoriteShare: Value(p.favoriteShare),
                antiRepeatWeeks: Value(p.antiRepeatWeeks),
                aisleOrder: Value(_joinCodes(p.aisleOrder.map((a) => a.code))),
                themeMode: Value(p.theme.code),
              ),
            );
        await db.delete(db.profileAversions).go();
        await db.delete(db.profileExclusions).go();
        await db.delete(db.profileEquipment).go();
        await db.delete(db.profileSlots).go();
        for (final a in p.aversions) {
          await db
              .into(db.profileAversions)
              .insert(ProfileAversionsCompanion.insert(ingredientId: a));
        }
        for (final e in p.exclusions) {
          await db
              .into(db.profileExclusions)
              .insert(ProfileExclusionsCompanion.insert(allergen: e.code));
        }
        for (final e in p.equipment) {
          await db
              .into(db.profileEquipment)
              .insert(ProfileEquipmentCompanion.insert(equipment: e.code));
        }
        for (final s in p.activeSlots) {
          await db
              .into(db.profileSlots)
              .insert(
                ProfileSlotsCompanion.insert(day: s.day, meal: s.meal.code),
              );
        }
      });

  // ---------------------------------------------------------------- menus

  Future<WeekMenu?> menuFor(DateTime start) async {
    final row = await (db.select(
      db.weekMenus,
    )..where((t) => t.startDate.equals(start))).getSingleOrNull();
    if (row == null) return null;
    return _menu(row);
  }

  Future<WeekMenu> _menu(WeekMenuRow row) async {
    final slots = await (db.select(
      db.menuSlots,
    )..where((t) => t.menuId.equals(row.id))).get();
    final extras = await (db.select(
      db.weekExtras,
    )..where((t) => t.menuId.equals(row.id))).get();
    final list = [
      for (final s in slots)
        MenuSlot(
          key: SlotKey(s.day, Meal.fromCode(s.meal)),
          kind: SlotKind.fromCode(s.kind),
          recipeId: s.recipeId,
          servings: s.servings,
          locked: s.locked,
          leftoversFrom: s.leftoversFrom == null
              ? null
              : slotKeyFromCode(s.leftoversFrom!),
        ),
    ]..sort((a, b) => a.key.compareTo(b.key));
    return WeekMenu(
      id: row.id,
      startDate: row.startDate,
      status: MenuStatus.fromCode(row.status),
      seed: row.seed,
      slots: list,
      extras: [
        for (final e in extras)
          WeekExtra(id: e.id, recipeId: e.recipeId, servings: e.servings),
      ],
    );
  }

  Future<List<WeekMenu>> allMenus() async {
    final rows = await (db.select(
      db.weekMenus,
    )..orderBy([(t) => OrderingTerm.asc(t.startDate)])).get();
    return [for (final r in rows) await _menu(r)];
  }

  /// Enregistre le menu (créneaux et extras remplacés). Si le menu est validé,
  /// la liste est recalculée et les recettes « à caser » planifiées sont
  /// retirées de « à caser ».
  Future<WeekMenu> saveMenu(WeekMenu m) async {
    final id = await db.transaction(() async {
      int id;
      if (m.id == null) {
        final existing = await (db.select(
          db.weekMenus,
        )..where((t) => t.startDate.equals(m.startDate))).getSingleOrNull();
        if (existing != null) {
          id = existing.id;
        } else {
          id = await db
              .into(db.weekMenus)
              .insert(
                WeekMenusCompanion.insert(
                  startDate: m.startDate,
                  status: Value(m.status.code),
                  seed: Value(m.seed),
                ),
              );
        }
      } else {
        id = m.id!;
      }
      await (db.update(db.weekMenus)..where((t) => t.id.equals(id))).write(
        WeekMenusCompanion(status: Value(m.status.code), seed: Value(m.seed)),
      );
      await (db.delete(db.menuSlots)..where((t) => t.menuId.equals(id))).go();
      await (db.delete(db.weekExtras)..where((t) => t.menuId.equals(id))).go();
      for (final s in m.slots) {
        await db
            .into(db.menuSlots)
            .insert(
              MenuSlotsCompanion.insert(
                menuId: id,
                day: s.key.day,
                meal: s.key.meal.code,
                kind: s.kind.code,
                recipeId: Value(s.recipeId),
                servings: s.servings,
                locked: Value(s.locked),
                leftoversFrom: Value(
                  s.leftoversFrom == null
                      ? null
                      : slotKeyCode(s.leftoversFrom!),
                ),
              ),
            );
      }
      for (final e in m.extras) {
        await db
            .into(db.weekExtras)
            .insert(
              WeekExtrasCompanion.insert(
                // Identifiant conservé : un extra « fait » (V2) y reste lié.
                id: e.id == null ? const Value.absent() : Value(e.id!),
                menuId: id,
                recipeId: e.recipeId,
                servings: e.servings,
              ),
            );
      }
      return id;
    });
    final saved = m.copyWith(id: id);
    if (m.status == MenuStatus.validated) {
      await _afterValidation(saved);
    }
    return (await menuFor(m.startDate))!;
  }

  Future<void> _afterValidation(WeekMenu m) async {
    final states = await userStates();
    for (final s in m.slots) {
      if (s.kind != SlotKind.recipe || s.recipeId == null) continue;
      final st = states[s.recipeId] ?? RecipeUserState.none;
      await setUserState(
        s.recipeId!,
        RecipeUserState(
          favorite: st.favorite,
          toPlace: false,
          disliked: st.disliked,
          lastPlannedAt: m.startDate,
        ),
      );
    }
    await refreshShopping(m);
  }

  /// Recettes planifiées pendant les [weeks] semaines précédant [start].
  Future<Set<int>> recentRecipeIds(DateTime start, int weeks) async {
    if (weeks <= 0) return {};
    final from = DateTime(start.year, start.month, start.day - 7 * weeks);
    final rows =
        await (db.select(db.weekMenus)..where(
              (t) =>
                  t.startDate.isBiggerOrEqualValue(from) &
                  t.startDate.isSmallerThanValue(start),
            ))
            .get();
    final out = <int>{};
    for (final r in rows) {
      final slots = await (db.select(
        db.menuSlots,
      )..where((t) => t.menuId.equals(r.id))).get();
      out.addAll(slots.map((s) => s.recipeId).whereType<int>());
    }
    return out;
  }

  // ---------------------------------------------------------------- liste

  Future<List<ShoppingItem>> shoppingItems(int menuId) async {
    final rows = await (db.select(
      db.shoppingItems,
    )..where((t) => t.menuId.equals(menuId))).get();
    return [for (final r in rows) _item(r)];
  }

  ShoppingItem _item(ShoppingItemRow r) => ShoppingItem(
    id: r.id,
    ingredientId: r.ingredientId,
    label: r.label,
    quantity: r.quantity,
    unit: r.unit == null ? null : Unit.fromCode(r.unit!),
    bought: r.bought,
    atHome: r.atHome,
    manual: r.manual,
  );

  /// V2 : calcul de la liste avec le stock (besoin − stock), fourni par
  /// le dépôt V2. Null : liste V1 sans stock.
  Future<List<ShoppingLine>> Function(WeekMenu m)? stockAwareLines;

  /// Lignes calculées depuis le menu et les extras.
  Future<List<ShoppingLine>> computeLines(WeekMenu m) async {
    if (stockAwareLines != null) return stockAwareLines!(m);
    final recipesById = {for (final r in await recipes()) r.id: r};
    return aggregateShopping(
      plannedRecipes(slots: m.slots, extras: m.extras, recipes: recipesById),
    );
  }

  /// Recalcule la liste enregistrée en conservant les cases cochées des
  /// lignes inchangées.
  Future<void> refreshShopping(WeekMenu m) async {
    if (m.id == null) return;
    final lines = await computeLines(m);
    final previous = await shoppingItems(m.id!);
    final next = reconcileShopping(previous, lines);
    await db.transaction(() async {
      await (db.delete(
        db.shoppingItems,
      )..where((t) => t.menuId.equals(m.id!))).go();
      for (final i in next) {
        await db.into(db.shoppingItems).insert(_itemCompanion(m.id!, i));
      }
    });
  }

  ShoppingItemsCompanion _itemCompanion(int menuId, ShoppingItem i) =>
      ShoppingItemsCompanion.insert(
        menuId: menuId,
        ingredientId: Value(i.ingredientId),
        label: Value(i.label),
        quantity: Value(i.quantity),
        unit: Value(i.unit?.code),
        bought: Value(i.bought),
        atHome: Value(i.atHome),
        manual: Value(i.manual),
      );

  Future<void> setItemChecks(int itemId, {bool? bought, bool? atHome}) =>
      (db.update(db.shoppingItems)..where((t) => t.id.equals(itemId))).write(
        ShoppingItemsCompanion(
          bought: bought == null ? const Value.absent() : Value(bought),
          atHome: atHome == null ? const Value.absent() : Value(atHome),
        ),
      );

  Future<void> addManualItem(int menuId, String label) => db
      .into(db.shoppingItems)
      .insert(_itemCompanion(menuId, ShoppingItem(label: label, manual: true)));

  Future<void> deleteItem(int itemId) =>
      (db.delete(db.shoppingItems)..where((t) => t.id.equals(itemId))).go();

  // -------------------------------------------------------- réinitialiser

  /// Efface toutes les données utilisateur ; les données fournies restent.
  Future<void> resetAll() => db.transaction(() async {
    // Données V2 d'abord (elles référencent menus et ingrédients).
    for (final TableInfo<Table, Object?> t in [
      db.stockMovements,
      db.stockLots,
      db.mealCompletions,
      db.foodLogEntries,
      db.mealPresetItems,
      db.mealPresets,
      db.nutritionProfiles,
      db.nutritionGoals,
      db.bodyWeights,
      db.dailySteps,
      db.strengthSets,
      db.strengthSessions,
      db.workouts,
      db.productLinks,
      db.customProducts,
    ]) {
      await db.delete(t).go();
    }
    await db.delete(db.shoppingItems).go();
    await db.delete(db.weekExtras).go();
    await db.delete(db.menuSlots).go();
    await db.delete(db.weekMenus).go();
    await db.delete(db.recipeUserStates).go();
    await db.delete(db.profileAversions).go();
    await db.delete(db.profileExclusions).go();
    await db.delete(db.profileEquipment).go();
    await db.delete(db.profileSlots).go();
    await db.delete(db.profiles).go();
    final personal = await (db.select(
      db.recipes,
    )..where((t) => t.origin.equals(Origin.personal.code))).get();
    for (final r in personal) {
      await deleteRecipe(r.id);
    }
    await (db.delete(
      db.ingredients,
    )..where((t) => t.origin.equals(Origin.personal.code))).go();
    await (db.delete(
      db.appMeta,
    )..where((t) => t.key.equals(metaLastReviewedWeek))).go();
  });
}

String _slugify(String s) {
  const from = 'àâäáãéèêëíìîïóòôöõúùûüçñœæ';
  const to = 'aaaaaeeeeiiiiooooouuuucnoa';
  final b = StringBuffer();
  for (final ch in s.toLowerCase().split('')) {
    final i = from.indexOf(ch);
    b.write(i >= 0 ? to[i] : ch);
  }
  final slug = b
      .toString()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  return slug.isEmpty ? 'ingredient' : slug;
}
