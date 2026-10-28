import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

import '../domain/food_log.dart';
import '../domain/nutrition.dart';
import '../domain/stock.dart';

/// Format attendu (tool/src/product_db.dart).
const productDbFormat = 'popote-products-1';

class ProductDbInfo {
  const ProductDbInfo({required this.date, required this.count});
  final String date;
  final int count;
}

/// Base produits Open Food Facts importée (SPEC-V2 §3), en lecture seule.
abstract class ProductCatalog {
  ProductDbInfo? get info;
  Product? byBarcode(String barcode);
  List<Product> search(String query, {int limit = 30});
}

/// Aucune base importée : seuls les produits perso existent.
class EmptyProductCatalog implements ProductCatalog {
  const EmptyProductCatalog();
  @override
  ProductDbInfo? get info => null;
  @override
  Product? byBarcode(String barcode) => null;
  @override
  List<Product> search(String query, {int limit = 30}) => const [];
}

class SqliteProductCatalog implements ProductCatalog {
  SqliteProductCatalog._(this._db, this.info);

  final Database _db;
  @override
  final ProductDbInfo info;

  /// Ouvre [file] en lecture seule ; null s'il est absent ou invalide.
  static SqliteProductCatalog? open(File file) {
    if (!file.existsSync()) return null;
    try {
      final db = sqlite3.open(file.path, mode: OpenMode.readOnly);
      final info = readInfo(db);
      if (info == null) {
        db.close();
        return null;
      }
      return SqliteProductCatalog._(db, info);
    } on SqliteException {
      return null;
    }
  }

  static ProductDbInfo? readInfo(Database db) {
    try {
      final meta = {
        for (final r in db.select('SELECT key, value FROM meta'))
          r['key'] as String: r['value'] as String,
      };
      if (meta['format'] != productDbFormat) return null;
      return ProductDbInfo(
        date: meta['date'] ?? '',
        count: int.tryParse(meta['count'] ?? '') ?? 0,
      );
    } on SqliteException {
      return null;
    }
  }

  void close() => _db.close();

  @override
  Product? byBarcode(String barcode) {
    final rows = _db.select('SELECT * FROM products WHERE barcode = ?', [
      barcode,
    ]);
    return rows.isEmpty ? null : _product(rows.first);
  }

  @override
  List<Product> search(String query, {int limit = 30}) {
    final q = query.trim();
    if (q.length < 2) return const [];
    final rows = _db.select(
      'SELECT * FROM products WHERE name LIKE ? OR brand LIKE ? '
      'ORDER BY scans DESC LIMIT ?',
      ['%$q%', '$q%', limit],
    );
    return rows.map(_product).toList();
  }

  static double? _d(Object? v) => (v as num?)?.toDouble();

  Product _product(Row r) {
    final kcal = _d(r['kcal']);
    final unit = r['package_unit'] as String?;
    return Product(
      barcode: r['barcode'] as String,
      name: r['name'] as String,
      brand: r['brand'] as String?,
      packageQty: _d(r['package_qty']),
      packageUnit: unit == null ? null : StockUnit.fromCode(unit),
      servingG: _d(r['serving_g']),
      // Macros absentes : comptées 0 mais énergie conservée (prudence :
      // l'énergie déclarée prime pour les calories).
      nutrients: kcal == null
          ? null
          : Nutrients(
              kcal: kcal,
              protein: _d(r['protein']) ?? 0,
              carbs: _d(r['carbs']) ?? 0,
              fat: _d(r['fat']) ?? 0,
              sugars: _d(r['sugars']),
              satFat: _d(r['sat_fat']),
              fiber: _d(r['fiber']),
              salt: _d(r['salt']),
            ),
      categories: ((r['categories'] as String?) ?? '')
          .split(',')
          .where((c) => c.isNotEmpty)
          .toList(),
    );
  }
}

/// Importe une base `produits-fr-AAAAMMJJ.db.gz` (ou `.db`) copiée par
/// l'utilisateur : décompression en flux vers un fichier temporaire,
/// vérification du format, puis remplacement de la base courante. Les
/// produits perso et les liens produit → ingrédient (base principale) ne
/// sont pas touchés. Lève [FormatException] si le fichier est invalide.
Future<ProductDbInfo> importProductDb(File source, File target) async {
  final tmp = File('${target.path}.import');
  final head = await source.openRead(0, 2).first;
  final gzipped = head.length == 2 && head[0] == 0x1f && head[1] == 0x8b;
  final input = source.openRead();
  await (gzipped ? input.transform(gzip.decoder) : input).pipe(tmp.openWrite());
  ProductDbInfo? info;
  try {
    final db = sqlite3.open(tmp.path, mode: OpenMode.readOnly);
    info = SqliteProductCatalog.readInfo(db);
    db.close();
  } on SqliteException {
    info = null;
  }
  if (info == null) {
    await tmp.delete();
    throw const FormatException('Ce fichier n\'est pas une base produits.');
  }
  if (target.existsSync()) await target.delete();
  await tmp.rename(target.path);
  return info;
}
