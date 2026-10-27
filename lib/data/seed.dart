import 'dart:convert';

import '../domain/enums.dart';
import '../domain/models.dart';

/// Contenu brut des données fournies, lu depuis les assets dans l'app ou depuis
/// le disque dans les tests.
abstract class SeedSource {
  Future<String> read(String relativePath);
}

class SeedManifest {
  const SeedManifest(this.version, this.lots);
  final int version;
  final List<String> lots;
}

class SeedRecipeLine {
  const SeedRecipeLine(
    this.ingredientId,
    this.qty,
    this.unit,
    this.optional,
    this.note,
  );
  final String ingredientId;
  final double qty;
  final Unit unit;
  final bool optional;
  final String? note;
}

/// Recette telle qu'écrite dans un lot (ingrédients par identifiant).
class SeedRecipe {
  const SeedRecipe({
    required this.slug,
    required this.title,
    required this.description,
    required this.type,
    required this.servings,
    required this.prepMin,
    required this.cookMin,
    required this.difficulty,
    required this.equipment,
    required this.mainBase,
    required this.lines,
    required this.steps,
  });

  final String slug;
  final String title;
  final String description;
  final RecipeType type;
  final int servings;
  final int prepMin;
  final int cookMin;
  final Difficulty difficulty;
  final Set<Equipment> equipment;
  final MainBase mainBase;
  final List<SeedRecipeLine> lines;
  final List<String> steps;

  Recipe toRecipe(Map<String, Ingredient> catalogue, {int id = 0}) => Recipe(
    id: id,
    slug: slug,
    title: title,
    description: description,
    type: type,
    servings: servings,
    prepMin: prepMin,
    cookMin: cookMin,
    difficulty: difficulty,
    equipment: equipment,
    mainBase: mainBase,
    ingredients: [
      for (final l in lines)
        RecipeIngredient(
          ingredient: catalogue[l.ingredientId]!,
          qty: l.qty,
          unit: l.unit,
          optional: l.optional,
          note: l.note,
        ),
    ],
    steps: steps,
  );
}

class SeedData {
  const SeedData(this.manifest, this.ingredients, this.recipes);
  final SeedManifest manifest;
  final List<Ingredient> ingredients;
  final List<SeedRecipe> recipes;
}

SeedManifest parseManifest(String json) {
  final m = jsonDecode(json) as Map<String, dynamic>;
  return SeedManifest(m['version'] as int, (m['lots'] as List).cast<String>());
}

Ingredient parseIngredient(Map<String, dynamic> m) => Ingredient(
  id: m['id'] as String,
  name: m['name'] as String,
  aisle: Aisle.fromCode(m['aisle'] as String),
  defaultUnit: Unit.fromCode(m['defaultUnit'] as String),
  avgPieceWeightG: (m['avgPieceWeightG'] as num?)?.toDouble(),
  pantry: m['pantry'] as bool? ?? false,
  perishable: m['perishable'] as bool? ?? false,
  markers: {
    for (final c in (m['markers'] as List? ?? const []))
      Marker.fromCode(c as String),
  },
  allergens: {
    for (final c in (m['allergens'] as List? ?? const []))
      Allergen.fromCode(c as String),
  },
  seasonMonths: {
    for (final c in (m['seasonMonths'] as List? ?? const [])) c as int,
  },
);

List<Ingredient> parseIngredients(String json) {
  final m = jsonDecode(json) as Map<String, dynamic>;
  return [
    for (final i in (m['ingredients'] as List))
      parseIngredient(i as Map<String, dynamic>),
  ];
}

SeedRecipe parseSeedRecipe(Map<String, dynamic> m) => SeedRecipe(
  slug: m['slug'] as String,
  title: m['title'] as String,
  description: m['description'] as String? ?? '',
  type: RecipeType.fromCode(m['type'] as String),
  servings: m['servings'] as int,
  prepMin: m['prepMin'] as int,
  cookMin: m['cookMin'] as int,
  difficulty: Difficulty.fromCode(m['difficulty'] as String),
  equipment: {
    for (final c in (m['equipment'] as List? ?? const []))
      Equipment.fromCode(c as String),
  },
  mainBase: MainBase.fromCode(m['mainBase'] as String),
  lines: [
    for (final l in (m['ingredients'] as List).cast<Map<String, dynamic>>())
      SeedRecipeLine(
        l['id'] as String,
        (l['qty'] as num).toDouble(),
        Unit.fromCode(l['unit'] as String),
        l['optional'] as bool? ?? false,
        l['note'] as String?,
      ),
  ],
  steps: (m['steps'] as List).cast<String>(),
);

List<SeedRecipe> parseLot(String json) {
  final m = jsonDecode(json) as Map<String, dynamic>;
  return [
    for (final r in (m['recipes'] as List))
      parseSeedRecipe(r as Map<String, dynamic>),
  ];
}

Future<SeedData> loadSeed(SeedSource src) async {
  final manifest = parseManifest(await src.read('seed.json'));
  final ingredients = parseIngredients(await src.read('ingredients.json'));
  final recipes = <SeedRecipe>[];
  for (final lot in manifest.lots) {
    recipes.addAll(parseLot(await src.read('recipes/$lot.json')));
  }
  return SeedData(manifest, ingredients, recipes);
}
