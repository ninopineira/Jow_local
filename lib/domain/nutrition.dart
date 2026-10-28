// Calculs nutritionnels purs (SPEC-V2 §4, docs/INVENTAIRE_NUTRITION.md §3.10).
// Valeurs stockées pour 100 g ; la conversion à la portion se fait au calcul.
// Aucun arrondi ici : il est réservé à l'affichage.

import 'enums.dart';
import 'models.dart';
import 'quantities.dart';

/// Énergie des macros (kcal/g).
const kcalPerGramProtein = 4.0;
const kcalPerGramCarbs = 4.0;
const kcalPerGramFat = 9.0;

/// Poids d'une pincée (choix C5).
const pinchGrams = 0.5;

/// Totaux d'énergie et de macros (une portion, un repas, une journée).
class Macros {
  const Macros({this.kcal = 0, this.protein = 0, this.carbs = 0, this.fat = 0});

  final double kcal;
  final double protein;
  final double carbs;
  final double fat;

  static const zero = Macros();

  Macros operator +(Macros o) => Macros(
    kcal: kcal + o.kcal,
    protein: protein + o.protein,
    carbs: carbs + o.carbs,
    fat: fat + o.fat,
  );

  Macros scaled(double f) => Macros(
    kcal: kcal * f,
    protein: protein * f,
    carbs: carbs * f,
    fat: fat * f,
  );

  @override
  bool operator ==(Object other) =>
      other is Macros &&
      (other.kcal - kcal).abs() < 1e-6 &&
      (other.protein - protein).abs() < 1e-6 &&
      (other.carbs - carbs).abs() < 1e-6 &&
      (other.fat - fat).abs() < 1e-6;

  @override
  int get hashCode => Object.hash(kcal.round(), protein.round());

  @override
  String toString() => 'Macros(kcal: $kcal, P: $protein, G: $carbs, L: $fat)';
}

Macros sumMacros(Iterable<Macros> items) =>
    items.fold(Macros.zero, (a, b) => a + b);

double kcalFromMacros(double protein, double carbs, double fat) =>
    protein * kcalPerGramProtein +
    carbs * kcalPerGramCarbs +
    fat * kcalPerGramFat;

/// Valeurs pour 100 g (ou 100 ml), avec fourchettes facultatives. Les valeurs
/// secondaires (sucres, AG saturés, fibres, sel) sont nulles si inconnues.
class Nutrients {
  const Nutrients({
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.sugars,
    this.satFat,
    this.fiber,
    this.salt,
    this.kcalMin,
    this.kcalMax,
    this.proteinMin,
    this.proteinMax,
    this.carbsMin,
    this.carbsMax,
    this.fatMin,
    this.fatMax,
  });

  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
  final double? sugars;
  final double? satFat;
  final double? fiber;
  final double? salt;
  final double? kcalMin;
  final double? kcalMax;
  final double? proteinMin;
  final double? proteinMax;
  final double? carbsMin;
  final double? carbsMax;
  final double? fatMin;
  final double? fatMax;

  bool get hasRange =>
      kcalMin != null ||
      kcalMax != null ||
      proteinMin != null ||
      proteinMax != null ||
      carbsMin != null ||
      carbsMax != null ||
      fatMin != null ||
      fatMax != null;

  /// Lecture prudente (règle péjorative de l'ancienne app) : glucides et
  /// lipides à la borne haute, protéines à la borne basse ; énergie à sa
  /// borne haute si déclarée, sinon décalée de l'énergie 4/4/9 des grammes
  /// ajoutés ou retirés. Sans fourchette, l'aliment est rendu tel quel.
  Nutrients resolved() {
    if (!hasRange) return this;
    final p = proteinMin ?? protein;
    final c = carbsMax ?? carbs;
    final f = fatMax ?? fat;
    final shift = kcalFromMacros(p, c, f) - kcalFromMacros(protein, carbs, fat);
    final k = kcalMax ?? (kcal + shift < 0 ? 0.0 : kcal + shift);
    return Nutrients(
      kcal: k,
      protein: p,
      carbs: c,
      fat: f,
      sugars: sugars,
      satFat: satFat,
      fiber: fiber,
      salt: salt,
    );
  }

  /// Énergie et macros de [grams] grammes, lecture prudente comprise.
  Macros forGrams(double grams) {
    final v = resolved();
    final r = grams / 100;
    return Macros(
      kcal: v.kcal * r,
      protein: v.protein * r,
      carbs: v.carbs * r,
      fat: v.fat * r,
    );
  }

  /// Écart de plus de [tolerance] entre l'énergie déclarée et celle des
  /// macros (après lecture prudente) : donnée suspecte.
  bool isEnergyInconsistent([double tolerance = 0.2]) {
    final v = resolved();
    final implied = kcalFromMacros(v.protein, v.carbs, v.fat);
    if (v.kcal == 0 && implied == 0) return false;
    final reference = v.kcal < 1 ? 1.0 : v.kcal;
    return (implied - v.kcal).abs() / reference > tolerance;
  }

  Map<String, dynamic> toJson() => {
    'kcal': kcal,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'sugars': ?sugars,
    'satFat': ?satFat,
    'fiber': ?fiber,
    'salt': ?salt,
    'kcalMin': ?kcalMin,
    'kcalMax': ?kcalMax,
    'proteinMin': ?proteinMin,
    'proteinMax': ?proteinMax,
    'carbsMin': ?carbsMin,
    'carbsMax': ?carbsMax,
    'fatMin': ?fatMin,
    'fatMax': ?fatMax,
  };

  static double? _d(Object? v) => (v as num?)?.toDouble();

  factory Nutrients.fromJson(Map<String, dynamic> m) => Nutrients(
    kcal: _d(m['kcal']) ?? 0,
    protein: _d(m['protein']) ?? 0,
    carbs: _d(m['carbs']) ?? 0,
    fat: _d(m['fat']) ?? 0,
    sugars: _d(m['sugars']),
    satFat: _d(m['satFat']),
    fiber: _d(m['fiber']),
    salt: _d(m['salt']),
    kcalMin: _d(m['kcalMin']),
    kcalMax: _d(m['kcalMax']),
    proteinMin: _d(m['proteinMin']),
    proteinMax: _d(m['proteinMax']),
    carbsMin: _d(m['carbsMin']),
    carbsMax: _d(m['carbsMax']),
    fatMin: _d(m['fatMin']),
    fatMax: _d(m['fatMax']),
  );
}

/// Grammes d'une quantité d'ingrédient (choix C5) : pièces via le poids
/// moyen, volumes via la densité (1 par défaut), pincée = 0,5 g. Null si une
/// pièce n'a pas de poids moyen.
double? gramsOf(Ingredient ing, double qty, Unit unit) {
  final a = toBase(qty, unit);
  return gramsOfAmount(ing, a);
}

double? gramsOfAmount(Ingredient ing, Amount a) => switch (a.dimension) {
  Dimension.mass => a.value,
  Dimension.volume => a.value * (ing.density ?? 1),
  Dimension.pinch => a.value * pinchGrams,
  Dimension.count =>
    ing.avgPieceWeightG == null ? null : a.value * ing.avgPieceWeightG!,
};

/// Valeurs d'une recette complète pour [servings] portions, ingrédients
/// facultatifs compris (estimation prudente), sans tenir compte du stock.
/// [excluded] et [replacements] reflètent un ajustement (SPEC-V2 §6).
Macros recipeMacros(
  Recipe r, {
  int? servings,
  Set<String> excluded = const {},
  Map<String, Ingredient> replacements = const {},
}) {
  final factor = (servings ?? r.servings) / r.servings;
  var total = Macros.zero;
  for (final ri in r.ingredients) {
    if (excluded.contains(ri.ingredient.id)) continue;
    final ing = replacements[ri.ingredient.id] ?? ri.ingredient;
    final n = ing.nutrition;
    if (n == null) continue;
    final g = gramsOf(ing, ri.qty * factor, ri.unit);
    if (g == null) continue;
    total += n.forGrams(g);
  }
  return total;
}

/// Valeurs par portion d'une recette (fiche recette).
Macros recipeMacrosPerServing(Recipe r) =>
    recipeMacros(r).scaled(1 / r.servings);
