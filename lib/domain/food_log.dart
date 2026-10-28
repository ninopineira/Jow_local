// Produits scannés, journal alimentaire, banque de repas et repas faits
// (SPEC-V2 §3, §5, §6, §9).

import 'enums.dart';
import 'models.dart';
import 'nutrition.dart';
import 'stock.dart';

/// Produit de la base Open Food Facts ou produit perso (prioritaire).
class Product {
  const Product({
    required this.barcode,
    required this.name,
    this.brand,
    this.packageQty,
    this.packageUnit,
    this.servingG,
    this.nutrients,
    this.categories = const [],
    this.custom = false,
  });

  final String barcode;
  final String name;
  final String? brand;

  /// Quantité du paquet (g, ml ou pièces).
  final double? packageQty;
  final StockUnit? packageUnit;
  final double? servingG;

  /// Valeurs pour 100 g ou 100 ml ; null si inconnues.
  final Nutrients? nutrients;
  final List<String> categories;

  /// Saisi ou corrigé à la main.
  final bool custom;

  String get displayName => brand == null ? name : '$name · $brand';

  Product copyWith({
    String? name,
    String? brand,
    double? packageQty,
    StockUnit? packageUnit,
    Nutrients? nutrients,
    bool? custom,
  }) => Product(
    barcode: barcode,
    name: name ?? this.name,
    brand: brand ?? this.brand,
    packageQty: packageQty ?? this.packageQty,
    packageUnit: packageUnit ?? this.packageUnit,
    servingG: servingG,
    nutrients: nutrients ?? this.nutrients,
    categories: categories,
    custom: custom ?? this.custom,
  );
}

/// Moment de la journée du journal (choix C7).
enum Moment {
  breakfast('breakfast'),
  lunch('lunch'),
  dinner('dinner'),
  snack('snack');

  const Moment(this.code);
  final String code;
  static Moment fromCode(String c) => values.firstWhere((v) => v.code == c);

  /// Créneau du menu → moment : midi → déjeuner, soir → dîner.
  static Moment forMeal(Meal m) => m == Meal.lunch ? lunch : dinner;
}

enum LogSource {
  meal('meal'),
  product('product'),
  ingredient('ingredient'),
  preset('preset'),
  free('free');

  const LogSource(this.code);
  final String code;
  static LogSource fromCode(String c) => values.firstWhere((v) => v.code == c);
}

/// Entrée du journal. Valeurs **figées à la saisie** (choix C6).
class FoodLogEntry {
  const FoodLogEntry({
    this.id,
    required this.date,
    required this.moment,
    required this.label,
    required this.source,
    required this.macros,
    this.ref,
    this.grams,
    this.completionId,
  });

  final int? id;
  final DateTime date;
  final Moment moment;
  final String label;
  final LogSource source;
  final Macros macros;

  /// Code-barres, id d'ingrédient, id de recette ou de repas de la banque.
  final String? ref;
  final double? grams;

  /// Repas fait d'origine (pour l'annulation).
  final int? completionId;
}

/// Ligne d'un repas de la banque.
class PresetItem {
  const PresetItem({
    required this.label,
    required this.grams,
    required this.nutrients,
    this.ingredientId,
    this.barcode,
  });

  final String label;
  final double grams;

  /// Copie des valeurs pour 100 g (lecture prudente appliquée au calcul).
  final Nutrients nutrients;
  final String? ingredientId;
  final String? barcode;

  Macros get macros => nutrients.forGrams(grams);
}

/// Repas pré-composé (banque) : un modèle, jamais un journal.
class MealPreset {
  const MealPreset({
    this.id,
    required this.name,
    this.defaultMoment,
    this.items = const [],
    this.recipeId,
    this.recipePortions,
  });

  final int? id;
  final String name;
  final Moment? defaultMoment;
  final List<PresetItem> items;

  /// Recette ajoutée à la banque [H] : valeurs d'une portion de la recette.
  final int? recipeId;
  final double? recipePortions;

  Macros macros(Map<int, Recipe> recipes) {
    var total = sumMacros(items.map((i) => i.macros));
    final r = recipeId == null ? null : recipes[recipeId];
    if (r != null) {
      total += mealPortionMacros(r, portions: recipePortions ?? 1);
    }
    return total;
  }
}

/// Repas marqué « Fait » (créneau du menu ou extra).
class MealCompletion {
  const MealCompletion({
    this.id,
    required this.menuId,
    this.slot,
    this.extraId,
    required this.recipeId,
    required this.cookedServings,
    this.portionsEaten = 1,
    this.excluded = const {},
    this.replacements = const {},
    required this.at,
  });

  final int? id;
  final int menuId;
  final SlotKey? slot;
  final int? extraId;
  final int recipeId;

  /// Portions cuisinées (0 pour un créneau « restes »).
  final int cookedServings;
  final double portionsEaten;
  final Set<String> excluded;

  /// Ingrédient d'origine → ingrédient de remplacement.
  final Map<String, String> replacements;
  final DateTime at;
}

/// Jour du journal pour un repas du menu marqué « Fait » : le jour prévu,
/// sauf s'il est dans le futur (repas avancé) : alors aujourd'hui. Un repas
/// passé oublié reste sur son jour.
DateTime mealLogDate(DateTime planned, DateTime today) {
  final p = DateTime(planned.year, planned.month, planned.day);
  final t = DateTime(today.year, today.month, today.day);
  return p.isAfter(t) ? t : p;
}

String _normalize(String s) {
  const from = 'àâäáãçéèêëíìîïñóòôöõúùûüÿœæ';
  const to = 'aaaaaceeeeiiiinooooouuuuyoa';
  final b = StringBuffer();
  for (final ch in s.toLowerCase().split('')) {
    final i = from.indexOf(ch);
    b.write(i >= 0 ? to[i] : ch);
  }
  return b.toString().replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim();
}

Set<String> _tokens(String s) => {
  for (final t in _normalize(s).split(' '))
    if (t.length > 2) _stem(t),
};

String _stem(String t) => t.length > 4 && (t.endsWith('s') || t.endsWith('x'))
    ? t.substring(0, t.length - 1)
    : t;

/// Ingrédient le plus probable pour un produit (catégories Open Food Facts
/// et nom). Null si rien de convaincant.
Ingredient? suggestIngredient(Product p, Iterable<Ingredient> catalogue) {
  final nameTokens = _tokens(p.name);
  final catTokens = <String>{
    for (final c in p.categories) ..._tokens(c.replaceAll('-', ' ')),
  };
  Ingredient? best;
  var bestScore = 0.0;
  for (final ing in catalogue) {
    final it = _tokens('${ing.name} ${ing.id.replaceAll('-', ' ')}');
    if (it.isEmpty) continue;
    final inName = it.intersection(nameTokens).length;
    final inCat = it.intersection(catTokens).length;
    final score = (inName * 2 + inCat) / it.length;
    if (score > bestScore) {
      bestScore = score;
      best = ing;
    }
  }
  return bestScore >= 1 ? best : null;
}
