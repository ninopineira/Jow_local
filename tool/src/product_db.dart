// Logique pure de tool/build_product_db.dart (SPEC-V2 §3), testée sans
// réseau dans test/tool/product_db_test.dart.

/// Version du format du fichier produit, vérifiée par l'app à l'import.
const productDbFormat = 'popote-products-1';

const productDbSchema = '''
CREATE TABLE products (
  barcode TEXT NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  brand TEXT,
  package_qty REAL,
  package_unit TEXT,
  serving_g REAL,
  kcal REAL NOT NULL,
  protein REAL,
  carbs REAL,
  sugars REAL,
  fat REAL,
  sat_fat REAL,
  fiber REAL,
  salt REAL,
  categories TEXT,
  scans INTEGER NOT NULL DEFAULT 0,
  completeness REAL NOT NULL DEFAULT 0
) WITHOUT ROWID;
CREATE TABLE meta (key TEXT NOT NULL PRIMARY KEY, value TEXT NOT NULL);
''';

/// Quantité d'un paquet, ramenée en g, ml ou pièces.
class PackageQuantity {
  const PackageQuantity(this.value, this.unit);

  final double value;

  /// `g`, `ml` ou `piece`.
  final String unit;

  @override
  bool operator ==(Object other) =>
      other is PackageQuantity &&
      other.unit == unit &&
      (other.value - value).abs() < 1e-6;

  @override
  int get hashCode => Object.hash(unit, value.round());

  @override
  String toString() => '$value $unit';
}

const _unitFactors = {
  'mg': (0.001, 'g'),
  'g': (1.0, 'g'),
  'gr': (1.0, 'g'),
  'grs': (1.0, 'g'),
  'gramme': (1.0, 'g'),
  'grammes': (1.0, 'g'),
  'kg': (1000.0, 'g'),
  'ml': (1.0, 'ml'),
  'cl': (10.0, 'ml'),
  'dl': (100.0, 'ml'),
  'l': (1000.0, 'ml'),
  'litre': (1000.0, 'ml'),
  'litres': (1000.0, 'ml'),
  'pièce': (1.0, 'piece'),
  'pièces': (1.0, 'piece'),
  'piece': (1.0, 'piece'),
  'pieces': (1.0, 'piece'),
  'pcs': (1.0, 'piece'),
  'unité': (1.0, 'piece'),
  'unités': (1.0, 'piece'),
  'oeufs': (1.0, 'piece'),
  'œufs': (1.0, 'piece'),
  'sachets': (1.0, 'piece'),
  'tranches': (1.0, 'piece'),
};

final _quantityPattern = RegExp(
  r'^(?:(\d+)\s*[x×*]\s*)?(\d+(?:[.,]\d+)?)\s*([a-zàâçéèêëîïôûùüÿœ]+)\.?$',
);

/// « 500 g », « 4 x 125 g », « 1,5 L », « 6x33cl », « 12 pièces »… Renvoie
/// null quand le texte n'est pas reconnu (on ne devine pas).
PackageQuantity? parsePackageQuantity(String? raw) {
  if (raw == null) return null;
  var text = raw.toLowerCase().trim();
  // Garde la première indication (« 500 g (2 x 250 g) » → « 500 g »).
  text = text.split(RegExp(r'[(\[;/]')).first.trim();
  text = text.replaceAll(RegExp(r'\s+'), ' ');
  final m = _quantityPattern.firstMatch(text);
  if (m == null) return null;
  final count = m.group(1) == null ? 1 : int.parse(m.group(1)!);
  final value = double.parse(m.group(2)!.replaceAll(',', '.'));
  final unit = _unitFactors[m.group(3)!];
  if (unit == null || value <= 0 || count <= 0) return null;
  final total = count * value * unit.$1;
  if (total <= 0 || total > 100000) return null;
  return PackageQuantity(total, unit.$2);
}

/// Nombre OFF (point ou virgule) ; null si absent ou invalide.
double? parseNumber(String? raw) {
  if (raw == null) return null;
  final t = raw.trim().replaceAll(',', '.');
  if (t.isEmpty) return null;
  final v = double.tryParse(t);
  if (v == null || v.isNaN || v.isInfinite || v < 0) return null;
  return v;
}

/// Ligne prête à insérer dans `products`.
class ProductRow {
  const ProductRow({
    required this.barcode,
    required this.name,
    this.brand,
    this.package,
    this.servingG,
    required this.kcal,
    this.protein,
    this.carbs,
    this.sugars,
    this.fat,
    this.satFat,
    this.fiber,
    this.salt,
    this.categories,
    this.scans = 0,
    this.completeness = 0,
  });

  final String barcode;
  final String name;
  final String? brand;
  final PackageQuantity? package;
  final double? servingG;
  final double kcal;
  final double? protein;
  final double? carbs;
  final double? sugars;
  final double? fat;
  final double? satFat;
  final double? fiber;
  final double? salt;
  final String? categories;
  final int scans;
  final double completeness;

  List<Object?> get values => [
    barcode,
    name,
    brand,
    package?.value,
    package?.unit,
    servingG,
    kcal,
    protein,
    carbs,
    sugars,
    fat,
    satFat,
    fiber,
    salt,
    categories,
    scans,
    completeness,
  ];
}

const insertProductSql =
    'INSERT OR REPLACE INTO products VALUES '
    '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';

/// Colonnes de l'export CSV d'Open Food Facts utilisées.
const requiredColumns = [
  'code',
  'product_name',
  'brands',
  'quantity',
  'product_quantity',
  'serving_quantity',
  'categories_tags',
  'countries_tags',
  'unique_scans_n',
  'completeness',
  'energy-kcal_100g',
  'energy_100g',
  'proteins_100g',
  'carbohydrates_100g',
  'sugars_100g',
  'fat_100g',
  'saturated-fat_100g',
  'fiber_100g',
  'salt_100g',
];

final _barcodePattern = RegExp(r'^\d{6,14}$');

/// Garde les produits vendus en France avec un code-barres, un nom et une
/// énergie pour 100 g ou 100 ml. Une valeur absente reste nulle, jamais 0.
ProductRow? productFromCsv(List<String> fields, Map<String, int> header) {
  String? f(String name) {
    final i = header[name];
    if (i == null || i >= fields.length) return null;
    final v = fields[i].trim();
    return v.isEmpty ? null : v;
  }

  final countries = f('countries_tags') ?? '';
  if (!countries.split(',').contains('en:france')) return null;
  final barcode = f('code');
  if (barcode == null || !_barcodePattern.hasMatch(barcode)) return null;
  final name = f('product_name');
  if (name == null) return null;
  var kcal = parseNumber(f('energy-kcal_100g'));
  if (kcal == null) {
    final kj = parseNumber(f('energy_100g'));
    if (kj != null) kcal = kj / 4.184;
  }
  if (kcal == null || kcal > 950) return null;

  var package = parsePackageQuantity(f('quantity'));
  final productQty = parseNumber(f('product_quantity'));
  if (package == null && productQty != null && productQty > 0) {
    package = PackageQuantity(productQty, 'g');
  }
  final brand = f('brands')?.split(',').first.trim();
  final tags = (f('categories_tags') ?? '')
      .split(',')
      .where((t) => t.startsWith('en:') || t.startsWith('fr:'))
      .map((t) => t.substring(3))
      .toList();
  // Les catégories les plus précises sont en fin de liste.
  final categories = tags.length > 6 ? tags.sublist(tags.length - 6) : tags;

  return ProductRow(
    barcode: barcode,
    name: name.length > 120 ? name.substring(0, 120) : name,
    brand: (brand == null || brand.isEmpty) ? null : brand,
    package: package,
    servingG: parseNumber(f('serving_quantity')),
    kcal: kcal,
    protein: parseNumber(f('proteins_100g')),
    carbs: parseNumber(f('carbohydrates_100g')),
    sugars: parseNumber(f('sugars_100g')),
    fat: parseNumber(f('fat_100g')),
    satFat: parseNumber(f('saturated-fat_100g')),
    fiber: parseNumber(f('fiber_100g')),
    salt: parseNumber(f('salt_100g')),
    categories: categories.isEmpty ? null : categories.join(','),
    scans: parseNumber(f('unique_scans_n'))?.round() ?? 0,
    completeness: parseNumber(f('completeness')) ?? 0,
  );
}

/// Index des colonnes depuis la ligne d'en-tête ; erreur si une manque.
Map<String, int> parseHeader(String line) {
  final cols = line.split('\t');
  final header = {for (var i = 0; i < cols.length; i++) cols[i].trim(): i};
  final missing = requiredColumns.where((c) => !header.containsKey(c));
  if (missing.isNotEmpty) {
    throw FormatException('Colonnes absentes de l\'export : $missing');
  }
  return header;
}
