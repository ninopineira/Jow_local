import 'package:drift/drift.dart';

part 'database.g.dart';

/// Tables du SPEC §4. Les listes (marqueurs, allergènes, mois, équipements)
/// sont stockées en texte séparé par des virgules ; les énumérations par leur
/// code stable.

@DataClassName('IngredientRow')
class Ingredients extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get aisle => text()();
  TextColumn get defaultUnit => text()();
  RealColumn get avgPieceWeightG => real().nullable()();
  BoolColumn get pantry => boolean().withDefault(const Constant(false))();
  BoolColumn get perishable => boolean().withDefault(const Constant(false))();
  TextColumn get markers => text().withDefault(const Constant(''))();
  TextColumn get allergens => text().withDefault(const Constant(''))();
  TextColumn get seasonMonths => text().withDefault(const Constant(''))();
  TextColumn get origin => text()();

  /// V2 : valeurs nutritionnelles pour 100 g (JSON de `Nutrients`).
  TextColumn get nutrition => text().nullable()();
  RealColumn get density => real().nullable()();
  TextColumn get ciqualCode => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RecipeRow')
class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text().nullable().unique()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get type => text()();
  IntColumn get servings => integer()();
  IntColumn get prepMin => integer()();
  IntColumn get cookMin => integer()();
  TextColumn get difficulty => text()();
  TextColumn get equipment => text().withDefault(const Constant(''))();
  TextColumn get mainBase => text()();
  TextColumn get origin => text()();
  IntColumn get seedVersion => integer().nullable()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('RecipeIngredientRow')
class RecipeIngredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  TextColumn get ingredientId => text().references(Ingredients, #id)();
  RealColumn get qty => real()();
  TextColumn get unit => text()();
  BoolColumn get optional => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  IntColumn get position => integer()();
}

@DataClassName('RecipeStepRow')
class RecipeSteps extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();
  TextColumn get body => text()();
}

@DataClassName('RecipeUserStateRow')
class RecipeUserStates extends Table {
  @override
  String get tableName => 'recipe_user_state';

  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
  BoolColumn get toPlace => boolean().withDefault(const Constant(false))();
  BoolColumn get disliked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastPlannedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {recipeId};
}

/// Une seule ligne (id = 1).
@DataClassName('ProfileRow')
class Profiles extends Table {
  @override
  String get tableName => 'profile';

  IntColumn get id => integer()();
  BoolColumn get onboarded => boolean().withDefault(const Constant(false))();
  IntColumn get people => integer().withDefault(const Constant(2))();
  TextColumn get diet => text().withDefault(const Constant('omnivore'))();
  BoolColumn get noPork => boolean().withDefault(const Constant(false))();
  IntColumn get maxMinWeekday => integer().withDefault(const Constant(30))();
  IntColumn get maxMinWeekend => integer().withDefault(const Constant(60))();
  IntColumn get weekStartDay => integer().withDefault(const Constant(1))();
  RealColumn get favoriteShare => real().withDefault(const Constant(0.4))();
  IntColumn get antiRepeatWeeks => integer().withDefault(const Constant(2))();
  TextColumn get aisleOrder => text().withDefault(const Constant(''))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProfileAversionRow')
class ProfileAversions extends Table {
  TextColumn get ingredientId => text().references(Ingredients, #id)();

  @override
  Set<Column> get primaryKey => {ingredientId};
}

@DataClassName('ProfileExclusionRow')
class ProfileExclusions extends Table {
  TextColumn get allergen => text()();

  @override
  Set<Column> get primaryKey => {allergen};
}

@DataClassName('ProfileEquipmentRow')
class ProfileEquipment extends Table {
  TextColumn get equipment => text()();

  @override
  Set<Column> get primaryKey => {equipment};
}

@DataClassName('ProfileSlotRow')
class ProfileSlots extends Table {
  IntColumn get day => integer()();
  TextColumn get meal => text()();

  @override
  Set<Column> get primaryKey => {day, meal};
}

@DataClassName('WeekMenuRow')
class WeekMenus extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startDate => dateTime().unique()();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  IntColumn get seed => integer().withDefault(const Constant(0))();
}

@DataClassName('MenuSlotRow')
class MenuSlots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get menuId =>
      integer().references(WeekMenus, #id, onDelete: KeyAction.cascade)();
  IntColumn get day => integer()();
  TextColumn get meal => text()();
  TextColumn get kind => text()();
  IntColumn get recipeId => integer().nullable().references(Recipes, #id)();
  IntColumn get servings => integer()();
  BoolColumn get locked => boolean().withDefault(const Constant(false))();

  /// Créneau source des restes, codé « jour:repas » dans le même menu.
  TextColumn get leftoversFrom => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {menuId, day, meal},
  ];
}

@DataClassName('WeekExtraRow')
class WeekExtras extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get menuId =>
      integer().references(WeekMenus, #id, onDelete: KeyAction.cascade)();
  IntColumn get recipeId => integer().references(Recipes, #id)();
  IntColumn get servings => integer()();
}

@DataClassName('ShoppingItemRow')
class ShoppingItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get menuId =>
      integer().references(WeekMenus, #id, onDelete: KeyAction.cascade)();
  TextColumn get ingredientId =>
      text().nullable().references(Ingredients, #id)();
  TextColumn get label => text().nullable()();
  RealColumn get quantity => real().nullable()();
  TextColumn get unit => text().nullable()();
  BoolColumn get bought => boolean().withDefault(const Constant(false))();
  BoolColumn get atHome => boolean().withDefault(const Constant(false))();
  BoolColumn get manual => boolean().withDefault(const Constant(false))();
}

/// Métadonnées techniques (version du seed importée, dernier bilan fait).
@DataClassName('AppMetaRow')
class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

// ---------------------------------------------------------------------------
// Tables V2 (SPEC-V2, docs/INVENTAIRE_NUTRITION.md choix C1).

/// Produit saisi ou corrigé à la main : prioritaire sur la base produits.
@DataClassName('CustomProductRow')
class CustomProducts extends Table {
  TextColumn get barcode => text()();
  TextColumn get name => text()();
  TextColumn get brand => text().nullable()();
  RealColumn get packageQty => real().nullable()();
  TextColumn get packageUnit => text().nullable()();
  RealColumn get servingG => real().nullable()();
  TextColumn get nutrition => text().nullable()();
  TextColumn get categories => text().withDefault(const Constant(''))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {barcode};
}

/// Lien mémorisé code-barres → ingrédient (null : produit sans lien).
@DataClassName('ProductLinkRow')
class ProductLinks extends Table {
  TextColumn get barcode => text()();
  TextColumn get ingredientId =>
      text().nullable().references(Ingredients, #id)();
  DateTimeColumn get linkedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {barcode};
}

@DataClassName('StockLotRow')
class StockLots extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get barcode => text().nullable()();
  TextColumn get ingredientId =>
      text().nullable().references(Ingredients, #id)();
  TextColumn get label => text()();
  RealColumn get quantity => real()();
  TextColumn get unit => text()();
  TextColumn get location => text()();
  DateTimeColumn get addedAt => dateTime()();
  DateTimeColumn get bestBefore => dateTime().nullable()();
}

/// Journal des mouvements. Le lot est recopié (ingrédient, unité,
/// emplacement) pour pouvoir le recréer à l'annulation s'il a été supprimé.
@DataClassName('StockMovementRow')
class StockMovements extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lotId => integer()();
  RealColumn get delta => real()();
  TextColumn get kind => text()();
  DateTimeColumn get at => dateTime()();
  IntColumn get completionId => integer().nullable()();
  IntColumn get logEntryId => integer().nullable()();
  TextColumn get label => text().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get ingredientId => text().nullable()();
  TextColumn get unit => text().nullable()();
  TextColumn get location => text().nullable()();
}

@DataClassName('MealCompletionRow')
class MealCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get menuId =>
      integer().references(WeekMenus, #id, onDelete: KeyAction.cascade)();

  /// Créneau « jour:repas », ou null pour un extra.
  TextColumn get slot => text().nullable()();
  IntColumn get extraId => integer().nullable()();
  IntColumn get recipeId => integer()();
  IntColumn get cookedServings => integer()();
  RealColumn get portionsEaten => real().withDefault(const Constant(1))();
  TextColumn get excluded => text().withDefault(const Constant(''))();

  /// JSON { ingrédient d'origine: remplacement }.
  TextColumn get replacements => text().withDefault(const Constant('{}'))();
  DateTimeColumn get at => dateTime()();
}

/// Journal alimentaire : valeurs figées à la saisie (choix C6).
@DataClassName('FoodLogEntryRow')
class FoodLogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get moment => text()();
  TextColumn get label => text()();
  TextColumn get source => text()();
  TextColumn get ref => text().nullable()();
  RealColumn get grams => real().nullable()();
  RealColumn get kcal => real()();
  RealColumn get protein => real().withDefault(const Constant(0))();
  RealColumn get carbs => real().withDefault(const Constant(0))();
  RealColumn get fat => real().withDefault(const Constant(0))();
  IntColumn get completionId => integer().nullable()();
}

@DataClassName('MealPresetRow')
class MealPresets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get defaultMoment => text().nullable()();
  IntColumn get recipeId => integer().nullable()();
  RealColumn get recipePortions => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('MealPresetItemRow')
class MealPresetItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get presetId =>
      integer().references(MealPresets, #id, onDelete: KeyAction.cascade)();
  TextColumn get label => text()();
  RealColumn get grams => real()();
  TextColumn get nutrition => text()();
  TextColumn get ingredientId => text().nullable()();
  TextColumn get barcode => text().nullable()();
  IntColumn get position => integer()();
}

/// Profil nutrition, une seule ligne (id = 1), distinct du profil du foyer.
@DataClassName('NutritionProfileRow')
class NutritionProfiles extends Table {
  @override
  String get tableName => 'nutrition_profile';

  IntColumn get id => integer()();
  TextColumn get sex => text()();
  DateTimeColumn get birthDate => dateTime()();
  RealColumn get heightCm => real()();
  TextColumn get activity => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('NutritionGoalRow')
class NutritionGoals extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startDate => dateTime()();
  TextColumn get kind => text()();
  RealColumn get dailyKcalDelta => real()();
  RealColumn get targetWeightKg => real().nullable()();
}

@DataClassName('BodyWeightRow')
class BodyWeights extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  RealColumn get weightKg => real()();
  RealColumn get bodyFatPct => real().nullable()();
}

@DataClassName('DailyStepsRow')
class DailySteps extends Table {
  DateTimeColumn get date => dateTime()();
  IntColumn get steps => integer()();

  @override
  Set<Column> get primaryKey => {date};
}

@DataClassName('WorkoutRow')
class Workouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get exerciseName => text()();
  RealColumn get met => real()();
  RealColumn get durationMin => real()();
  TextColumn get intensity => text().withDefault(const Constant('moderate'))();
  RealColumn get kcalOverride => real().nullable()();
  TextColumn get note => text().nullable()();
}

@DataClassName('StrengthSessionRow')
class StrengthSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get name => text().nullable()();
  RealColumn get durationMin => real().nullable()();
  RealColumn get kcalOverride => real().nullable()();
  TextColumn get note => text().nullable()();
}

@DataClassName('StrengthSetRow')
class StrengthSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(
    StrengthSessions,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get exercise => text()();
  IntColumn get setIndex => integer()();
  IntColumn get reps => integer()();
  RealColumn get weightKg => real()();
  IntColumn get restSec => integer().nullable()();
}

@DriftDatabase(
  tables: [
    Ingredients,
    Recipes,
    RecipeIngredients,
    RecipeSteps,
    RecipeUserStates,
    Profiles,
    ProfileAversions,
    ProfileExclusions,
    ProfileEquipment,
    ProfileSlots,
    WeekMenus,
    MenuSlots,
    WeekExtras,
    ShoppingItems,
    AppMeta,
    CustomProducts,
    ProductLinks,
    StockLots,
    StockMovements,
    MealCompletions,
    FoodLogEntries,
    MealPresets,
    MealPresetItems,
    NutritionProfiles,
    NutritionGoals,
    BodyWeights,
    DailySteps,
    Workouts,
    StrengthSessions,
    StrengthSets,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Version du schéma. Toute évolution ajoute une étape dans [migration] et
  /// un test dans `test/data/migration_test.dart`.
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // V2 (SPEC-V2 §11) : migration additive, aucune donnée V1 touchée.
        await m.addColumn(ingredients, ingredients.nutrition);
        await m.addColumn(ingredients, ingredients.density);
        await m.addColumn(ingredients, ingredients.ciqualCode);
        for (final TableInfo<Table, Object?> t in [
          customProducts,
          productLinks,
          stockLots,
          stockMovements,
          mealCompletions,
          foodLogEntries,
          mealPresets,
          mealPresetItems,
          nutritionProfiles,
          nutritionGoals,
          bodyWeights,
          dailySteps,
          workouts,
          strengthSessions,
          strengthSets,
        ]) {
          await m.createTable(t);
        }
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
