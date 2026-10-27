import 'enums.dart';
import 'models.dart';

/// Régime et allergènes d'une recette, toujours calculés depuis les marqueurs
/// de ses ingrédients (SPEC §4), jamais saisis.
class RecipeTraits {
  const RecipeTraits({
    required this.diets,
    required this.allergens,
    required this.hasMeat,
    required this.hasPork,
  });

  /// Régimes compatibles.
  final Set<Diet> diets;
  final Set<Allergen> allergens;
  final bool hasMeat;

  /// Porc ou gélatine (le plus souvent d'origine porcine).
  final bool hasPork;

  bool get isVegan => diets.contains(Diet.vegan);
  bool get isVegetarian => diets.contains(Diet.vegetarian);
}

const _notVegan = {
  Marker.meat,
  Marker.pork,
  Marker.poultry,
  Marker.fish,
  Marker.seafood,
  Marker.dairy,
  Marker.egg,
  Marker.honey,
  Marker.gelatin,
};
const _notVegetarian = {
  Marker.meat,
  Marker.pork,
  Marker.poultry,
  Marker.fish,
  Marker.seafood,
  Marker.gelatin,
};
const _notPescetarian = {
  Marker.meat,
  Marker.pork,
  Marker.poultry,
  Marker.gelatin,
};

/// Les ingrédients facultatifs comptent aussi : par prudence, une recette avec
/// des lardons facultatifs n'est pas végétarienne.
RecipeTraits computeTraits(Iterable<Ingredient> ingredients) {
  final markers = <Marker>{};
  final allergens = <Allergen>{};
  for (final i in ingredients) {
    markers.addAll(i.markers);
    allergens.addAll(i.allergens);
    // Cohérence minimale même si une donnée perso est incomplète.
    if (i.markers.contains(Marker.fish)) allergens.add(Allergen.fish);
    if (i.markers.contains(Marker.egg)) allergens.add(Allergen.eggs);
    if (i.markers.contains(Marker.dairy)) allergens.add(Allergen.milk);
  }
  final diets = {Diet.omnivore, Diet.flexitarian};
  if (markers.intersection(_notPescetarian).isEmpty) {
    diets.add(Diet.pescetarian);
  }
  if (markers.intersection(_notVegetarian).isEmpty) diets.add(Diet.vegetarian);
  if (markers.intersection(_notVegan).isEmpty) diets.add(Diet.vegan);
  return RecipeTraits(
    diets: diets,
    allergens: allergens,
    hasMeat:
        markers.contains(Marker.meat) ||
        markers.contains(Marker.pork) ||
        markers.contains(Marker.poultry),
    hasPork: markers.contains(Marker.pork) || markers.contains(Marker.gelatin),
  );
}

RecipeTraits traitsOf(Recipe r) =>
    computeTraits(r.ingredients.map((ri) => ri.ingredient));

/// Raison d'incompatibilité d'une recette avec le profil.
sealed class Incompatibility {
  const Incompatibility();
}

class DietIncompatibility extends Incompatibility {
  const DietIncompatibility(this.diet);
  final Diet diet;
}

class PorkIncompatibility extends Incompatibility {
  const PorkIncompatibility();
}

class AllergenIncompatibility extends Incompatibility {
  const AllergenIncompatibility(this.allergen);
  final Allergen allergen;
}

class AversionIncompatibility extends Incompatibility {
  const AversionIncompatibility(this.ingredient);
  final Ingredient ingredient;
}

class EquipmentIncompatibility extends Incompatibility {
  const EquipmentIncompatibility(this.equipment);
  final Equipment equipment;
}

/// Contraintes statiques du profil (hors temps et état utilisateur).
List<Incompatibility> incompatibilities(
  Recipe recipe,
  RecipeTraits traits,
  HouseholdProfile profile,
) {
  final out = <Incompatibility>[];
  if (!traits.diets.contains(profile.diet)) {
    out.add(DietIncompatibility(profile.diet));
  }
  if (profile.noPork && traits.hasPork) out.add(const PorkIncompatibility());
  for (final a in Allergen.values) {
    if (profile.exclusions.contains(a) && traits.allergens.contains(a)) {
      out.add(AllergenIncompatibility(a));
    }
  }
  final seen = <String>{};
  for (final ri in recipe.ingredients) {
    if (profile.aversions.contains(ri.ingredient.id) &&
        seen.add(ri.ingredient.id)) {
      out.add(AversionIncompatibility(ri.ingredient));
    }
  }
  for (final e in Equipment.values) {
    if (recipe.equipment.contains(e) && !profile.equipment.contains(e)) {
      out.add(EquipmentIncompatibility(e));
    }
  }
  return out;
}

bool isCompatible(Recipe recipe, RecipeTraits traits, HouseholdProfile p) =>
    incompatibilities(recipe, traits, p).isEmpty;

/// Saison : part des fruits et légumes de saison au mois donné (1 si la recette
/// n'en contient pas de saisonniers).
double seasonRatio(Recipe recipe, int month) {
  var seasonal = 0;
  var ok = 0;
  for (final ri in recipe.ingredients) {
    if (ri.ingredient.isSeasonal) {
      seasonal++;
      if (ri.ingredient.seasonMonths.contains(month)) ok++;
    }
  }
  return seasonal == 0 ? 1 : ok / seasonal;
}

/// « De saison » pour le filtre du catalogue : contient des produits
/// saisonniers, tous de saison ce mois-ci.
bool isInSeason(Recipe recipe, int month) =>
    recipe.ingredients.any((ri) => ri.ingredient.isSeasonal) &&
    seasonRatio(recipe, month) == 1;
