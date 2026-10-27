import 'enums.dart';
import 'models.dart';

/// Dimension physique d'une quantité, une fois convertie en unité de base.
enum Dimension { mass, volume, count, pinch }

/// Quantité exprimée dans l'unité de base de sa dimension :
/// grammes, millilitres, pièces ou pincées.
class Amount {
  const Amount(this.dimension, this.value);

  final Dimension dimension;
  final double value;

  Amount operator +(Amount o) {
    assert(o.dimension == dimension);
    return Amount(dimension, value + o.value);
  }

  Amount scaled(double f) => Amount(dimension, value * f);

  /// Unité de stockage en base.
  Unit get baseUnit => switch (dimension) {
    Dimension.mass => Unit.g,
    Dimension.volume => Unit.ml,
    Dimension.count => Unit.piece,
    Dimension.pinch => Unit.pinch,
  };

  @override
  bool operator ==(Object other) =>
      other is Amount &&
      other.dimension == dimension &&
      (other.value - value).abs() < 1e-6;

  @override
  int get hashCode => Object.hash(dimension, value.toStringAsFixed(4));

  @override
  String toString() => 'Amount(${dimension.name}, $value)';
}

/// Cuillère à soupe = 15 ml, cuillère à café = 5 ml.
Amount toBase(double qty, Unit unit) => switch (unit) {
  Unit.g => Amount(Dimension.mass, qty),
  Unit.kg => Amount(Dimension.mass, qty * 1000),
  Unit.ml => Amount(Dimension.volume, qty),
  Unit.cl => Amount(Dimension.volume, qty * 10),
  Unit.l => Amount(Dimension.volume, qty * 1000),
  Unit.tbsp => Amount(Dimension.volume, qty * 15),
  Unit.tsp => Amount(Dimension.volume, qty * 5),
  Unit.piece => Amount(Dimension.count, qty),
  Unit.pinch => Amount(Dimension.pinch, qty),
};

Dimension dimensionOf(Unit u) => toBase(1, u).dimension;

/// Fusionne pièces et grammes d'un même ingrédient quand son poids moyen est
/// connu, vers la dimension de son unité par défaut. Sinon les dimensions
/// restent séparées (pas de conversion volume ↔ masse sans densité).
List<Amount> mergeAmounts(Ingredient ing, Iterable<Amount> amounts) {
  final byDim = <Dimension, double>{};
  for (final a in amounts) {
    byDim[a.dimension] = (byDim[a.dimension] ?? 0) + a.value;
  }
  final w = ing.avgPieceWeightG;
  if (w != null &&
      w > 0 &&
      byDim.containsKey(Dimension.mass) &&
      byDim.containsKey(Dimension.count)) {
    if (dimensionOf(ing.defaultUnit) == Dimension.count) {
      byDim[Dimension.count] =
          byDim[Dimension.count]! + byDim[Dimension.mass]! / w;
      byDim.remove(Dimension.mass);
    } else {
      byDim[Dimension.mass] =
          byDim[Dimension.mass]! + byDim[Dimension.count]! * w;
      byDim.remove(Dimension.count);
    }
  }
  return [
    for (final d in Dimension.values)
      if (byDim[d] != null && byDim[d]! > 0) Amount(d, byDim[d]!),
  ];
}

double _ceilTo(double v, double step) => (v / step - 1e-9).ceil() * step;
double _roundTo(double v, double step) => (v / step).round() * step;

/// Arrondi lisible (SPEC §3.7) : pièces à l'unité supérieure (au demi pour les
/// fruits et légumes), grammes et millilitres à 5 près sous 100 et à 10 près
/// au-delà, pincées à l'unité supérieure.
Amount roundForShopping(Amount a, Ingredient ing) {
  final v = a.value;
  switch (a.dimension) {
    case Dimension.count:
      final step = ing.aisle == Aisle.produce ? 0.5 : 1.0;
      return Amount(a.dimension, _ceilTo(v, step));
    case Dimension.pinch:
      return Amount(a.dimension, _ceilTo(v, 1));
    case Dimension.mass:
    case Dimension.volume:
      if (v <= 0) return a;
      if (v < 100) return Amount(a.dimension, _ceilTo(v, 5));
      if (v < 1000) return Amount(a.dimension, _roundTo(v, 10));
      return Amount(a.dimension, _roundTo(v, 100));
  }
}

/// Nombre en français : virgule décimale, sans « ,0 ».
String formatNumber(double v) {
  final r = (v * 10).round() / 10;
  if (r == r.roundToDouble()) return r.toInt().toString();
  return r.toStringAsFixed(1).replaceAll('.', ',');
}

/// Libellés d'unités (français). Centralisés ici car le domaine produit le
/// texte copié/partagé de la liste ; l'interface les réutilise.
String formatAmount(Amount a) {
  final v = a.value;
  switch (a.dimension) {
    case Dimension.mass:
      if (v >= 1000) return '${formatNumber(v / 1000)} kg';
      return '${formatNumber(v)} g';
    case Dimension.volume:
      if (v >= 1000) return '${formatNumber(v / 1000)} l';
      if (v < 60) {
        if (v >= 15 && (v % 15).abs() < 1e-6) {
          final n = v / 15;
          return '${formatNumber(n)} c. à soupe';
        }
        if ((v % 5).abs() < 1e-6) {
          final n = v / 5;
          return '${formatNumber(n)} c. à café';
        }
      }
      if (v >= 100) return '${formatNumber(v / 10)} cl';
      return '${formatNumber(v)} ml';
    case Dimension.count:
      return formatNumber(v);
    case Dimension.pinch:
      return '${formatNumber(v)} ${v > 1 ? 'pincées' : 'pincée'}';
  }
}

/// Quantité d'une ligne de recette mise à l'échelle, pour la fiche recette.
String formatRecipeQuantity(double qty, Unit unit) {
  final n = formatNumber(qty);
  return switch (unit) {
    Unit.g => '$n g',
    Unit.kg => '$n kg',
    Unit.ml => '$n ml',
    Unit.cl => '$n cl',
    Unit.l => '$n l',
    Unit.piece => n,
    Unit.tbsp => '$n c. à soupe',
    Unit.tsp => '$n c. à café',
    Unit.pinch => '$n ${qty > 1 ? 'pincées' : 'pincée'}',
  };
}
