import 'enums.dart';
import 'nutrition.dart';

class Ingredient {
  const Ingredient({
    required this.id,
    required this.name,
    required this.aisle,
    required this.defaultUnit,
    this.avgPieceWeightG,
    this.pantry = false,
    this.perishable = false,
    this.markers = const {},
    this.allergens = const {},
    this.seasonMonths = const {},
    this.origin = Origin.provided,
    this.nutrition,
    this.density,
    this.ciqualCode,
  });

  final String id;
  final String name;
  final Aisle aisle;
  final Unit defaultUnit;
  final double? avgPieceWeightG;
  final bool pantry;
  final bool perishable;
  final Set<Marker> markers;
  final Set<Allergen> allergens;

  /// Mois de saison (1 à 12) des fruits et légumes frais ; vide sinon.
  final Set<int> seasonMonths;
  final Origin origin;

  /// Valeurs pour 100 g (SPEC-V2 §4) ; null si inconnues.
  final Nutrients? nutrition;

  /// Densité en g/ml pour convertir les volumes (1 si nulle).
  final double? density;

  /// Code de l'aliment Ciqual d'origine des valeurs.
  final String? ciqualCode;

  Ingredient withNutrition(
    Nutrients? n, {
    double? density,
    String? ciqualCode,
  }) => Ingredient(
    id: id,
    name: name,
    aisle: aisle,
    defaultUnit: defaultUnit,
    avgPieceWeightG: avgPieceWeightG,
    pantry: pantry,
    perishable: perishable,
    markers: markers,
    allergens: allergens,
    seasonMonths: seasonMonths,
    origin: origin,
    nutrition: n,
    density: density ?? this.density,
    ciqualCode: ciqualCode ?? this.ciqualCode,
  );

  bool get isMeat =>
      markers.contains(Marker.meat) ||
      markers.contains(Marker.pork) ||
      markers.contains(Marker.poultry);

  bool get isSeasonal => seasonMonths.isNotEmpty;

  bool inSeason(int month) =>
      seasonMonths.isEmpty || seasonMonths.contains(month);

  @override
  bool operator ==(Object other) => other is Ingredient && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class RecipeIngredient {
  const RecipeIngredient({
    required this.ingredient,
    required this.qty,
    required this.unit,
    this.optional = false,
    this.note,
  });

  final Ingredient ingredient;

  /// Quantité pour les portions de base de la recette.
  final double qty;
  final Unit unit;
  final bool optional;
  final String? note;
}

class Recipe {
  const Recipe({
    required this.id,
    this.slug,
    required this.title,
    this.description = '',
    required this.type,
    this.servings = 4,
    required this.prepMin,
    required this.cookMin,
    this.difficulty = Difficulty.easy,
    this.equipment = const {},
    required this.mainBase,
    this.origin = Origin.provided,
    this.seedVersion,
    this.photoPath,
    this.ingredients = const [],
    this.steps = const [],
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String? slug;
  final String title;
  final String description;
  final RecipeType type;
  final int servings;
  final int prepMin;
  final int cookMin;
  final Difficulty difficulty;
  final Set<Equipment> equipment;
  final MainBase mainBase;
  final Origin origin;
  final int? seedVersion;
  final String? photoPath;
  final List<RecipeIngredient> ingredients;
  final List<String> steps;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  int get totalMin => prepMin + cookMin;

  Recipe copyWith({
    int? id,
    String? slug,
    bool clearSlug = false,
    String? title,
    String? description,
    RecipeType? type,
    int? servings,
    int? prepMin,
    int? cookMin,
    Difficulty? difficulty,
    Set<Equipment>? equipment,
    MainBase? mainBase,
    Origin? origin,
    String? photoPath,
    bool clearPhoto = false,
    List<RecipeIngredient>? ingredients,
    List<String>? steps,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Recipe(
      id: id ?? this.id,
      slug: clearSlug ? null : (slug ?? this.slug),
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      servings: servings ?? this.servings,
      prepMin: prepMin ?? this.prepMin,
      cookMin: cookMin ?? this.cookMin,
      difficulty: difficulty ?? this.difficulty,
      equipment: equipment ?? this.equipment,
      mainBase: mainBase ?? this.mainBase,
      origin: origin ?? this.origin,
      seedVersion: seedVersion,
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// État propre à l'utilisateur pour une recette (SPEC §3.4).
class RecipeUserState {
  const RecipeUserState({
    this.favorite = false,
    this.toPlace = false,
    this.disliked = false,
    this.lastPlannedAt,
  });

  final bool favorite;

  /// « À caser » : à placer en priorité au prochain menu généré.
  final bool toPlace;

  /// « Pas aimée » : n'est plus proposée automatiquement.
  final bool disliked;
  final DateTime? lastPlannedAt;

  static const none = RecipeUserState();

  RecipeUserState copyWith({
    bool? favorite,
    bool? toPlace,
    bool? disliked,
    DateTime? lastPlannedAt,
  }) => RecipeUserState(
    favorite: favorite ?? this.favorite,
    toPlace: toPlace ?? this.toPlace,
    disliked: disliked ?? this.disliked,
    lastPlannedAt: lastPlannedAt ?? this.lastPlannedAt,
  );
}

/// Un créneau de la grille : jour (0 = premier jour de la semaine) et repas.
class SlotKey implements Comparable<SlotKey> {
  const SlotKey(this.day, this.meal);

  final int day;
  final Meal meal;

  int get index => day * 2 + meal.index;

  @override
  int compareTo(SlotKey other) => index.compareTo(other.index);

  @override
  bool operator ==(Object other) =>
      other is SlotKey && other.day == day && other.meal == meal;

  @override
  int get hashCode => Object.hash(day, meal);

  @override
  String toString() => 'SlotKey($day, ${meal.code})';
}

class HouseholdProfile {
  HouseholdProfile({
    this.people = 2,
    this.diet = Diet.omnivore,
    this.noPork = false,
    this.exclusions = const {},
    this.aversions = const {},
    this.equipment = const {Equipment.oven, Equipment.hob, Equipment.microwave},
    Set<SlotKey>? activeSlots,
    this.maxMinWeekday = 30,
    this.maxMinWeekend = 60,
    this.weekStartDay = DateTime.monday,
    this.favoriteShare = 0.4,
    this.antiRepeatWeeks = 2,
    this.aisleOrder = Aisle.values,
    this.theme = ThemePreference.system,
  }) : activeSlots = activeSlots ?? defaultSlots;

  /// Défaut : tous les soirs.
  static final defaultSlots = {
    SlotKey(0, Meal.dinner),
    SlotKey(1, Meal.dinner),
    SlotKey(2, Meal.dinner),
    SlotKey(3, Meal.dinner),
    SlotKey(4, Meal.dinner),
    SlotKey(5, Meal.dinner),
    SlotKey(6, Meal.dinner),
  };

  /// Flexitarien : viande au plus 3 repas par semaine (SPEC §3.1 [H]).
  static const flexitarianMeatMax = 3;

  final int people;
  final Diet diet;
  final bool noPork;
  final Set<Allergen> exclusions;

  /// Identifiants d'ingrédients que le foyer n'aime pas.
  final Set<String> aversions;
  final Set<Equipment> equipment;
  final Set<SlotKey> activeSlots;
  final int maxMinWeekday;
  final int maxMinWeekend;

  /// 1 = lundi … 7 = dimanche (convention `DateTime.weekday`).
  final int weekStartDay;
  final double favoriteShare;
  final int antiRepeatWeeks;
  final List<Aisle> aisleOrder;
  final ThemePreference theme;

  HouseholdProfile copyWith({
    int? people,
    Diet? diet,
    bool? noPork,
    Set<Allergen>? exclusions,
    Set<String>? aversions,
    Set<Equipment>? equipment,
    Set<SlotKey>? activeSlots,
    int? maxMinWeekday,
    int? maxMinWeekend,
    int? weekStartDay,
    double? favoriteShare,
    int? antiRepeatWeeks,
    List<Aisle>? aisleOrder,
    ThemePreference? theme,
  }) => HouseholdProfile(
    people: people ?? this.people,
    diet: diet ?? this.diet,
    noPork: noPork ?? this.noPork,
    exclusions: exclusions ?? this.exclusions,
    aversions: aversions ?? this.aversions,
    equipment: equipment ?? this.equipment,
    activeSlots: activeSlots ?? this.activeSlots,
    maxMinWeekday: maxMinWeekday ?? this.maxMinWeekday,
    maxMinWeekend: maxMinWeekend ?? this.maxMinWeekend,
    weekStartDay: weekStartDay ?? this.weekStartDay,
    favoriteShare: favoriteShare ?? this.favoriteShare,
    antiRepeatWeeks: antiRepeatWeeks ?? this.antiRepeatWeeks,
    aisleOrder: aisleOrder ?? this.aisleOrder,
    theme: theme ?? this.theme,
  );
}

class MenuSlot {
  const MenuSlot({
    required this.key,
    this.kind = SlotKind.empty,
    this.recipeId,
    this.servings = 2,
    this.locked = false,
    this.leftoversFrom,
  });

  final SlotKey key;
  final SlotKind kind;

  /// Recette du créneau (kind == recipe).
  final int? recipeId;
  final int servings;
  final bool locked;

  /// Pour kind == leftovers : créneau qui a cuisiné en double.
  final SlotKey? leftoversFrom;

  MenuSlot copyWith({
    SlotKind? kind,
    int? recipeId,
    bool clearRecipe = false,
    int? servings,
    bool? locked,
    SlotKey? leftoversFrom,
    bool clearLeftovers = false,
  }) => MenuSlot(
    key: key,
    kind: kind ?? this.kind,
    recipeId: clearRecipe ? null : (recipeId ?? this.recipeId),
    servings: servings ?? this.servings,
    locked: locked ?? this.locked,
    leftoversFrom: clearLeftovers
        ? null
        : (leftoversFrom ?? this.leftoversFrom),
  );

  MenuSlot cleared() => MenuSlot(key: key, servings: servings);
}

class WeekExtra {
  const WeekExtra({required this.recipeId, required this.servings, this.id});

  final int? id;
  final int recipeId;
  final int servings;
}

/// Date sans heure du premier jour de la semaine contenant [date].
DateTime weekStartOf(DateTime date, int weekStartDay) {
  final d = DateTime(date.year, date.month, date.day);
  final diff = (d.weekday - weekStartDay + 7) % 7;
  return DateTime(d.year, d.month, d.day - diff);
}

/// Date réelle d'un jour de la grille.
DateTime dayDate(DateTime weekStart, int day) =>
    DateTime(weekStart.year, weekStart.month, weekStart.day + day);

bool isWeekend(DateTime date) =>
    date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

class WeekMenu {
  const WeekMenu({
    this.id,
    required this.startDate,
    this.status = MenuStatus.draft,
    this.seed = 0,
    this.slots = const [],
    this.extras = const [],
  });

  final int? id;
  final DateTime startDate;
  final MenuStatus status;
  final int seed;
  final List<MenuSlot> slots;
  final List<WeekExtra> extras;

  MenuSlot? slotAt(SlotKey k) {
    for (final s in slots) {
      if (s.key == k) return s;
    }
    return null;
  }

  WeekMenu copyWith({
    int? id,
    MenuStatus? status,
    int? seed,
    List<MenuSlot>? slots,
    List<WeekExtra>? extras,
  }) => WeekMenu(
    id: id ?? this.id,
    startDate: startDate,
    status: status ?? this.status,
    seed: seed ?? this.seed,
    slots: slots ?? this.slots,
    extras: extras ?? this.extras,
  );

  /// Remplace (ou ajoute) un créneau.
  WeekMenu withSlot(MenuSlot slot) {
    final list = [
      for (final s in slots)
        if (s.key != slot.key) s,
      slot,
    ]..sort((a, b) => a.key.compareTo(b.key));
    return copyWith(slots: list);
  }
}
