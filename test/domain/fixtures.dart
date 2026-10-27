import 'package:popote/domain/enums.dart';
import 'package:popote/domain/models.dart';

/// Petits ingrédients et recettes de test.
const tofu = Ingredient(
  id: 'tofu',
  name: 'Tofu',
  aisle: Aisle.dairy,
  defaultUnit: Unit.g,
  allergens: {Allergen.soy},
);
const poulet = Ingredient(
  id: 'poulet',
  name: 'Poulet',
  aisle: Aisle.meatFish,
  defaultUnit: Unit.g,
  perishable: true,
  markers: {Marker.meat, Marker.poultry},
);
const lardons = Ingredient(
  id: 'lardons',
  name: 'Lardons',
  aisle: Aisle.meatFish,
  defaultUnit: Unit.g,
  markers: {Marker.meat, Marker.pork},
);
const saumon = Ingredient(
  id: 'saumon',
  name: 'Saumon',
  aisle: Aisle.meatFish,
  defaultUnit: Unit.g,
  markers: {Marker.fish},
  allergens: {Allergen.fish},
);
const oeuf = Ingredient(
  id: 'oeuf',
  name: 'Œuf',
  aisle: Aisle.dairy,
  defaultUnit: Unit.piece,
  avgPieceWeightG: 55,
  markers: {Marker.egg},
  allergens: {Allergen.eggs},
);
const creme = Ingredient(
  id: 'creme',
  name: 'Crème',
  aisle: Aisle.dairy,
  defaultUnit: Unit.ml,
  perishable: true,
  markers: {Marker.dairy},
  allergens: {Allergen.milk},
);
const miel = Ingredient(
  id: 'miel',
  name: 'Miel',
  aisle: Aisle.sweet,
  defaultUnit: Unit.tbsp,
  pantry: true,
  markers: {Marker.honey},
);
const gelatine = Ingredient(
  id: 'gelatine',
  name: 'Gélatine',
  aisle: Aisle.sweet,
  defaultUnit: Unit.piece,
  markers: {Marker.gelatin},
);
const pates = Ingredient(
  id: 'pates',
  name: 'Pâtes',
  aisle: Aisle.savory,
  defaultUnit: Unit.g,
  allergens: {Allergen.gluten},
);
const oignon = Ingredient(
  id: 'oignon',
  name: 'Oignon',
  aisle: Aisle.produce,
  defaultUnit: Unit.piece,
  avgPieceWeightG: 100,
  perishable: true,
);
const courgette = Ingredient(
  id: 'courgette',
  name: 'Courgette',
  aisle: Aisle.produce,
  defaultUnit: Unit.piece,
  avgPieceWeightG: 200,
  perishable: true,
  seasonMonths: {6, 7, 8, 9},
);
const sel = Ingredient(
  id: 'sel',
  name: 'Sel',
  aisle: Aisle.savory,
  defaultUnit: Unit.pinch,
  pantry: true,
);
const huile = Ingredient(
  id: 'huile',
  name: 'Huile',
  aisle: Aisle.savory,
  defaultUnit: Unit.tbsp,
  pantry: true,
);

Recipe recipe(
  int id,
  List<Ingredient> ings, {
  RecipeType type = RecipeType.main,
  int prep = 10,
  int cook = 10,
  MainBase base = MainBase.vegetables,
  Set<Equipment> equipment = const {Equipment.hob},
  String? title,
}) => Recipe(
  id: id,
  slug: 'r$id',
  title: title ?? 'Recette $id',
  type: type,
  prepMin: prep,
  cookMin: cook,
  mainBase: base,
  equipment: equipment,
  ingredients: [
    for (final i in ings)
      RecipeIngredient(ingredient: i, qty: 100, unit: Unit.g),
  ],
);

/// Lundi 2 mars 2026 (une semaine de printemps).
final monday = DateTime(2026, 3, 2);

Set<SlotKey> allSlots() => {
  for (var d = 0; d < 7; d++) ...[
    SlotKey(d, Meal.lunch),
    SlotKey(d, Meal.dinner),
  ],
};
