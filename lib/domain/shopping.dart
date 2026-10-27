import 'enums.dart';
import 'models.dart';
import 'quantities.dart';

/// Ligne calculée de la liste des ingrédients (avant fusion avec les cases
/// cochées enregistrées).
class ShoppingLine {
  const ShoppingLine({
    required this.ingredient,
    required this.amount,
    required this.recipeTitles,
    required this.optional,
  });

  final Ingredient ingredient;

  /// Quantité arrondie pour l'affichage.
  final Amount amount;

  /// « pour : recette A, recette B ».
  final List<String> recipeTitles;

  /// Toutes les utilisations sont facultatives.
  final bool optional;

  /// Clé stable : ingrédient et dimension. Sert à conserver les cases cochées
  /// quand le menu change.
  String get key => lineKey(ingredient.id, amount.dimension);

  bool get pantry => ingredient.pantry;
}

String lineKey(String ingredientId, Dimension d) => '$ingredientId|${d.name}';

/// Un usage de recette dans la semaine, avec ses portions totales.
class PlannedRecipe {
  const PlannedRecipe(this.recipe, this.servings);
  final Recipe recipe;
  final int servings;
}

/// Recettes à cuisiner pour la semaine : créneaux « recette » (portions des
/// créneaux « restes » qui en dépendent ajoutées : cuisiner en double) et
/// extras. Les créneaux « restes » orphelins, « dehors » et vides ne comptent
/// pas.
List<PlannedRecipe> plannedRecipes({
  required List<MenuSlot> slots,
  required List<WeekExtra> extras,
  required Map<int, Recipe> recipes,
}) {
  final byKey = {for (final s in slots) s.key: s};
  final out = <PlannedRecipe>[];
  for (final s in slots) {
    if (s.kind != SlotKind.recipe || s.recipeId == null) continue;
    final r = recipes[s.recipeId];
    if (r == null) continue;
    var servings = s.servings;
    for (final other in slots) {
      if (other.kind == SlotKind.leftovers &&
          other.leftoversFrom == s.key &&
          byKey[other.leftoversFrom] != null) {
        servings += other.servings;
      }
    }
    out.add(PlannedRecipe(r, servings));
  }
  for (final e in extras) {
    final r = recipes[e.recipeId];
    if (r != null) out.add(PlannedRecipe(r, e.servings));
  }
  return out;
}

/// Agrège les quantités par ingrédient (SPEC §3.7) : mise à l'échelle des
/// portions, conversions vers g / ml / pièces / pincées, fusion pièces ↔
/// grammes si le poids moyen est connu, arrondis lisibles.
List<ShoppingLine> aggregateShopping(List<PlannedRecipe> planned) {
  final amounts = <String, List<Amount>>{};
  final ingredients = <String, Ingredient>{};
  final titles = <String, List<String>>{};
  final allOptional = <String, bool>{};
  for (final p in planned) {
    final factor = p.servings / p.recipe.servings;
    for (final ri in p.recipe.ingredients) {
      final id = ri.ingredient.id;
      ingredients[id] = ri.ingredient;
      (amounts[id] ??= []).add(toBase(ri.qty, ri.unit).scaled(factor));
      final t = titles[id] ??= [];
      if (!t.contains(p.recipe.title)) t.add(p.recipe.title);
      allOptional[id] = (allOptional[id] ?? true) && ri.optional;
    }
  }
  final lines = <ShoppingLine>[];
  for (final id in amounts.keys) {
    final ing = ingredients[id]!;
    for (final a in mergeAmounts(ing, amounts[id]!)) {
      lines.add(
        ShoppingLine(
          ingredient: ing,
          amount: roundForShopping(a, ing),
          recipeTitles: titles[id]!,
          optional: allOptional[id]!,
        ),
      );
    }
  }
  lines.sort((a, b) {
    final c = a.ingredient.aisle.index.compareTo(b.ingredient.aisle.index);
    return c != 0 ? c : a.ingredient.name.compareTo(b.ingredient.name);
  });
  return lines;
}

/// Ligne enregistrée (table `shopping_items`).
class ShoppingItem {
  const ShoppingItem({
    this.id,
    this.ingredientId,
    this.label,
    this.quantity,
    this.unit,
    this.bought = false,
    this.atHome = false,
    this.manual = false,
  });

  final int? id;
  final String? ingredientId;

  /// Libellé libre pour les articles ajoutés à la main.
  final String? label;
  final double? quantity;
  final Unit? unit;
  final bool bought;
  final bool atHome;
  final bool manual;

  String? get key => ingredientId == null || unit == null
      ? null
      : lineKey(ingredientId!, dimensionOf(unit!));

  ShoppingItem copyWith({bool? bought, bool? atHome}) => ShoppingItem(
    id: id,
    ingredientId: ingredientId,
    label: label,
    quantity: quantity,
    unit: unit,
    bought: bought ?? this.bought,
    atHome: atHome ?? this.atHome,
    manual: manual,
  );
}

/// Recalcule les lignes enregistrées depuis les lignes calculées, en gardant
/// les cases cochées des lignes inchangées (même ingrédient, même quantité) et
/// tous les articles ajoutés à la main.
List<ShoppingItem> reconcileShopping(
  List<ShoppingItem> previous,
  List<ShoppingLine> computed,
) {
  final prevByKey = {
    for (final p in previous)
      if (!p.manual && p.key != null) p.key!: p,
  };
  final out = <ShoppingItem>[];
  for (final line in computed) {
    final prev = prevByKey[line.key];
    final unchanged =
        prev != null &&
        prev.quantity != null &&
        (prev.quantity! - line.amount.value).abs() < 1e-6;
    out.add(
      ShoppingItem(
        id: unchanged ? prev.id : null,
        ingredientId: line.ingredient.id,
        quantity: line.amount.value,
        unit: line.amount.baseUnit,
        bought: unchanged && prev.bought,
        atHome: unchanged && prev.atHome,
      ),
    );
  }
  out.addAll(previous.where((p) => p.manual));
  return out;
}

/// Texte de la liste à copier ou partager, rayons dans l'ordre choisi.
String shoppingText({
  required List<ShoppingLine> lines,
  required List<ShoppingItem> manualItems,
  required Map<String, ShoppingItem> stateByKey,
  required List<Aisle> aisleOrder,
  required String Function(Aisle) aisleLabel,
  required String title,
  required String pantryTitle,
  required String manualTitle,
}) {
  final b = StringBuffer('$title\n');
  String lineText(ShoppingLine l) {
    final q = formatAmount(l.amount);
    return l.amount.dimension == Dimension.count
        ? '$q × ${l.ingredient.name}'
        : '${l.ingredient.name} : $q';
  }

  bool skip(ShoppingLine l) {
    final s = stateByKey[l.key];
    return s != null && (s.bought || s.atHome);
  }

  for (final aisle in aisleOrder) {
    final inAisle = lines
        .where((l) => !l.pantry && l.ingredient.aisle == aisle && !skip(l))
        .toList();
    if (inAisle.isEmpty) continue;
    b.writeln('\n${aisleLabel(aisle)}');
    for (final l in inAisle) {
      b.writeln('- ${lineText(l)}');
    }
  }
  final pantry = lines.where((l) => l.pantry && !skip(l)).toList();
  if (pantry.isNotEmpty) {
    b.writeln('\n$pantryTitle');
    for (final l in pantry) {
      b.writeln('- ${lineText(l)}');
    }
  }
  final manual = manualItems.where((m) => !m.bought && !m.atHome).toList();
  if (manual.isNotEmpty) {
    b.writeln('\n$manualTitle');
    for (final m in manual) {
      b.writeln('- ${m.label}');
    }
  }
  return b.toString().trimRight();
}
