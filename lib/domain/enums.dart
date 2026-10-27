/// Énumérations du domaine. Chaque valeur a un `code` stable utilisé dans les
/// JSON fournis, la base et l'export : ne jamais renommer un code existant.
library;

T _byCode<T extends Enum>(List<T> values, String code, String Function(T) of) {
  for (final v in values) {
    if (of(v) == code) return v;
  }
  throw FormatException('Code inconnu pour $T : $code');
}

/// Rayons du magasin (SPEC §3.7).
enum Aisle {
  produce('produce'),
  meatFish('meat_fish'),
  dairy('dairy'),
  savory('savory'),
  sweet('sweet'),
  frozen('frozen'),
  bakery('bakery'),
  drinks('drinks'),
  misc('misc');

  const Aisle(this.code);
  final String code;
  static Aisle fromCode(String c) => _byCode(values, c, (v) => v.code);
}

/// Unités de quantité. Les JSON fournis n'utilisent que g, ml, piece, tbsp,
/// tsp et pinch ; kg, cl et l servent aux recettes perso.
enum Unit {
  g('g'),
  kg('kg'),
  ml('ml'),
  cl('cl'),
  l('l'),
  piece('piece'),
  tbsp('tbsp'),
  tsp('tsp'),
  pinch('pinch');

  const Unit(this.code);
  final String code;
  static Unit fromCode(String c) => _byCode(values, c, (v) => v.code);
}

/// Marqueurs de régime portés par les ingrédients.
enum Marker {
  meat('meat'),
  pork('pork'),
  poultry('poultry'),
  fish('fish'),
  seafood('seafood'),
  dairy('dairy'),
  egg('egg'),
  honey('honey'),
  gelatin('gelatin'),
  alcohol('alcohol');

  const Marker(this.code);
  final String code;
  static Marker fromCode(String c) => _byCode(values, c, (v) => v.code);
}

/// Les 14 allergènes réglementaires.
enum Allergen {
  gluten('gluten'),
  crustaceans('crustaceans'),
  eggs('eggs'),
  fish('fish'),
  peanuts('peanuts'),
  soy('soy'),
  milk('milk'),
  nuts('nuts'),
  celery('celery'),
  mustard('mustard'),
  sesame('sesame'),
  sulphites('sulphites'),
  lupin('lupin'),
  molluscs('molluscs');

  const Allergen(this.code);
  final String code;
  static Allergen fromCode(String c) => _byCode(values, c, (v) => v.code);
}

enum Equipment {
  oven('oven'),
  hob('hob'),
  microwave('microwave'),
  blender('blender'),
  multicooker('multicooker'),
  airFryer('air_fryer'),
  steamer('steamer'),
  pressureCooker('pressure_cooker');

  const Equipment(this.code);
  final String code;
  static Equipment fromCode(String c) => _byCode(values, c, (v) => v.code);
}

/// Base principale d'une recette : sert à la variété et à la vignette.
enum MainBase {
  poultry('poultry'),
  beef('beef'),
  pork('pork'),
  lamb('lamb'),
  fish('fish'),
  seafood('seafood'),
  legumes('legumes'),
  tofu('tofu'),
  eggs('eggs'),
  cheese('cheese'),
  pasta('pasta'),
  rice('rice'),
  grains('grains'),
  potatoes('potatoes'),
  vegetables('vegetables'),
  sweet('sweet');

  const MainBase(this.code);
  final String code;
  static MainBase fromCode(String c) => _byCode(values, c, (v) => v.code);
}

enum RecipeType {
  main('main'),
  dessert('dessert'),
  breakfast('breakfast');

  const RecipeType(this.code);
  final String code;
  static RecipeType fromCode(String c) => _byCode(values, c, (v) => v.code);
}

enum Difficulty {
  easy('easy'),
  medium('medium'),
  hard('hard');

  const Difficulty(this.code);
  final String code;
  static Difficulty fromCode(String c) => _byCode(values, c, (v) => v.code);
}

/// Origine d'un ingrédient ou d'une recette.
enum Origin {
  provided('provided'),
  personal('personal');

  const Origin(this.code);
  final String code;
  static Origin fromCode(String c) => _byCode(values, c, (v) => v.code);
}

/// Régimes, du plus permissif au plus strict.
enum Diet {
  omnivore('omnivore'),
  flexitarian('flexitarian'),
  pescetarian('pescetarian'),
  vegetarian('vegetarian'),
  vegan('vegan');

  const Diet(this.code);
  final String code;
  static Diet fromCode(String c) => _byCode(values, c, (v) => v.code);
}

enum Meal {
  lunch('lunch'),
  dinner('dinner');

  const Meal(this.code);
  final String code;
  static Meal fromCode(String c) => _byCode(values, c, (v) => v.code);
}

enum SlotKind {
  recipe('recipe'),
  leftovers('leftovers'),
  eatingOut('eating_out'),
  empty('empty');

  const SlotKind(this.code);
  final String code;
  static SlotKind fromCode(String c) => _byCode(values, c, (v) => v.code);
}

enum MenuStatus {
  draft('draft'),
  validated('validated');

  const MenuStatus(this.code);
  final String code;
  static MenuStatus fromCode(String c) => _byCode(values, c, (v) => v.code);
}

enum ThemePreference {
  system('system'),
  light('light'),
  dark('dark');

  const ThemePreference(this.code);
  final String code;
  static ThemePreference fromCode(String c) =>
      _byCode(values, c, (v) => v.code);
}
