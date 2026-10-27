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
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Version du schéma. Toute évolution ajoute une étape dans [migration] et
  /// un test dans `test/data/migration_test.dart`.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
