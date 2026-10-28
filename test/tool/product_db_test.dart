import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../tool/src/product_db.dart';

void main() {
  group('parsePackageQuantity', () {
    test('formats courants', () {
      expect(parsePackageQuantity('500 g'), const PackageQuantity(500, 'g'));
      expect(
        parsePackageQuantity('4 x 125 g'),
        const PackageQuantity(500, 'g'),
      );
      expect(parsePackageQuantity('6x33cl'), const PackageQuantity(1980, 'ml'));
      expect(parsePackageQuantity('1,5 L'), const PackageQuantity(1500, 'ml'));
      expect(parsePackageQuantity('1 kg'), const PackageQuantity(1000, 'g'));
      expect(
        parsePackageQuantity('12 pièces'),
        const PackageQuantity(12, 'piece'),
      );
      expect(
        parsePackageQuantity('6 oeufs'),
        const PackageQuantity(6, 'piece'),
      );
      expect(
        parsePackageQuantity('500 g (2 x 250 g)'),
        const PackageQuantity(500, 'g'),
      );
    });

    test('texte non reconnu → null', () {
      expect(parsePackageQuantity(null), isNull);
      expect(parsePackageQuantity('un gros paquet'), isNull);
      expect(parsePackageQuantity('0 g'), isNull);
    });
  });

  group('productFromCsv (fixture, sans réseau)', () {
    late Map<String, int> header;
    late List<List<String>> rows;

    setUpAll(() {
      final lines = File('test/tool/fixtures/off_sample.csv').readAsLinesSync();
      header = parseHeader(lines.first);
      rows = [for (final l in lines.skip(1)) l.split('\t')];
    });

    test('filtre France, code-barres, nom et énergie', () {
      final kept = [for (final r in rows) ?productFromCsv(r, header)]
          .map((p) => p.barcode)
          .toList();
      expect(kept, [
        '3017620422003',
        '3250390000001',
        '3000000000002',
        '3000000000005',
      ]);
    });

    test('valeurs, multipack, kJ → kcal, valeurs absentes nulles', () {
      final yog = productFromCsv(rows[2], header)!;
      expect(yog.package, const PackageQuantity(500, 'g'));
      expect(yog.kcal, closeTo(250 / 4.184, 1e-9));
      expect(yog.fiber, isNull);
      expect(yog.brand, isNull);
      final spread = productFromCsv(rows[0], header)!;
      expect(spread.brand, 'Ferrero');
      expect(spread.categories, 'spreads,sweet-spreads');
      expect(spread.fiber, isNull);
      expect(spread.servingG, 15);
    });

    test('schéma SQLite et insertion', () {
      final db = sqlite3.openInMemory();
      db.execute(productDbSchema);
      final stmt = db.prepare(insertProductSql);
      for (final r in rows) {
        final p = productFromCsv(r, header);
        if (p != null) stmt.execute(p.values);
      }
      stmt.close();
      final res = db.select(
        'SELECT name, package_qty, package_unit FROM products '
        "WHERE barcode = '3250390000001'",
      );
      expect(res.first['name'], 'Spaghetti n°5');
      expect(res.first['package_qty'], 500);
      expect(res.first['package_unit'], 'g');
      db.close();
    });
  });

  test('en-tête incomplet refusé', () {
    expect(() => parseHeader('code\tproduct_name'), throwsFormatException);
  });
}
