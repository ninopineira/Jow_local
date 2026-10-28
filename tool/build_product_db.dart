// Construit la base produits hors ligne depuis l'export Open Food Facts
// (SPEC-V2 §3). À lancer sur le PC, pendant le développement uniquement :
//
//   dart run tool/build_product_db.dart [--source <url|fichier .csv/.csv.gz>]
//                                       [--out <dossier>] [--max-mb 150]
//
// L'export (≈ 0,9 Go compressé, ≈ 9 Go décompressé) est lu **en flux** :
// rien n'est stocké décompressé. Seule une base SQLite temporaire, filtrée,
// est écrite puis supprimée. Sortie : <out>/produits-fr-AAAAMMJJ.db.gz et
// <out>/produits-fr-AAAAMMJJ.rapport.md (par défaut dans build/product_db/).
// Données Open Food Facts sous licence ODbL.
import 'dart:convert';
import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

import 'src/product_db.dart';

const defaultSource =
    'https://static.openfoodfacts.org/data/en.openfoodfacts.org.products.csv.gz';

Future<void> main(List<String> args) async {
  String option(String name, String fallback) {
    final i = args.indexOf('--$name');
    return i >= 0 && i + 1 < args.length ? args[i + 1] : fallback;
  }

  final source = option('source', defaultSource);
  final outDir = Directory(option('out', 'build/product_db'));
  final maxBytes = (double.parse(option('max-mb', '150')) * 1024 * 1024)
      .round();
  final now = DateTime.now();
  final stamp =
      '${now.year}${now.month.toString().padLeft(2, '0')}'
      '${now.day.toString().padLeft(2, '0')}';
  await outDir.create(recursive: true);
  final tmp = await Directory.systemTemp.createTemp('popote_products_');
  final dbFile = File('${tmp.path}/products.db');
  final watch = Stopwatch()..start();

  try {
    final db = sqlite3.open(dbFile.path);
    db.execute('PRAGMA journal_mode = OFF; PRAGMA synchronous = OFF;');
    db.execute(productDbSchema);
    final insert = db.prepare(insertProductSql);
    var lines = 0, kept = 0;
    Map<String, int>? header;
    db.execute('BEGIN');
    await for (final line in _openLines(source)) {
      if (header == null) {
        header = parseHeader(line);
        continue;
      }
      lines++;
      final row = productFromCsv(line.split('\t'), header);
      if (row != null) {
        insert.execute(row.values);
        kept++;
      }
      if (lines % 200000 == 0) {
        db.execute('COMMIT; BEGIN');
        stdout.writeln('  $lines lignes lues, $kept produits gardés');
      }
    }
    db.execute('COMMIT');
    insert.close();
    final total = db.select('SELECT COUNT(*) AS n FROM products').first['n'];
    db.execute('PRAGMA journal_mode = DELETE');

    // Réduction si le fichier compressé dépasse la taille visée : on garde
    // les produits les plus scannés, puis les plus complets.
    final outFile = File('${outDir.path}/produits-fr-$stamp.db.gz');
    var removed = 0;
    for (;;) {
      _writeMeta(db, stamp, source);
      db.execute('VACUUM');
      await _gzip(dbFile, outFile, db);
      final size = await outFile.length();
      if (size <= maxBytes) break;
      final count =
          db.select('SELECT COUNT(*) AS n FROM products').first['n'] as int;
      final keep = (count * maxBytes / size * 0.95).floor();
      db.execute(
        'DELETE FROM products WHERE barcode NOT IN (SELECT barcode FROM '
        'products ORDER BY scans DESC, completeness DESC LIMIT $keep)',
      );
      removed += count - keep;
      stdout.writeln('  $size octets > $maxBytes : $keep produits gardés');
    }
    final finalCount =
        db.select('SELECT COUNT(*) AS n FROM products').first['n'] as int;
    final withPackage = db
        .select(
          'SELECT COUNT(*) AS n FROM products WHERE package_qty IS NOT NULL',
        )
        .first['n'];
    final withMacros = db
        .select(
          'SELECT COUNT(*) AS n FROM products WHERE protein IS NOT NULL '
          'AND carbs IS NOT NULL AND fat IS NOT NULL',
        )
        .first['n'];
    db.close();
    final dbSize = await dbFile.length();
    final gzSize = await outFile.length();

    final report = StringBuffer()
      ..writeln('# Base produits Open Food Facts — $stamp')
      ..writeln()
      ..writeln('- Source : $source (licence ODbL)')
      ..writeln('- Lignes de l\'export lues : $lines')
      ..writeln(
        '- Produits retenus (France, code-barres, nom, énergie) : $total',
      )
      ..writeln('- Écartés pour la taille visée (moins scannés) : $removed')
      ..writeln('- Produits dans le fichier : $finalCount')
      ..writeln('  - avec quantité du paquet : $withPackage')
      ..writeln('  - avec protéines, glucides et lipides : $withMacros')
      ..writeln(
        '- Base SQLite : ${_mb(dbSize)} ; fichier compressé : '
        '${_mb(gzSize)} (`${outFile.uri.pathSegments.last}`)',
      )
      ..writeln('- Format : `$productDbFormat`')
      ..writeln('- Durée : ${watch.elapsed.inMinutes} min');
    final reportFile = File('${outDir.path}/produits-fr-$stamp.rapport.md');
    await reportFile.writeAsString(report.toString());
    stdout.write(report);
  } finally {
    await tmp.delete(recursive: true);
  }
}

String _mb(int bytes) => '${(bytes / 1024 / 1024).toStringAsFixed(1)} Mo';

void _writeMeta(Database db, String stamp, String source) {
  final count = db.select('SELECT COUNT(*) AS n FROM products').first['n'];
  final stmt = db.prepare('INSERT OR REPLACE INTO meta VALUES (?, ?)');
  for (final e in {
    'format': productDbFormat,
    'date': stamp,
    'count': '$count',
    'source': 'Open Food Facts (ODbL)',
  }.entries) {
    stmt.execute([e.key, e.value]);
  }
  stmt.close();
}

Future<void> _gzip(File src, File dst, Database db) async {
  await src
      .openRead()
      .transform(GZipCodec(level: 9).encoder)
      .pipe(dst.openWrite());
}

/// Lignes de l'export, depuis une URL ou un fichier local (gzip ou non),
/// décompressées à la volée.
Stream<String> _openLines(String source) async* {
  Stream<List<int>> bytes;
  HttpClient? client;
  if (source.startsWith('http://') || source.startsWith('https://')) {
    client = HttpClient();
    final response = await (await client.getUrl(Uri.parse(source))).close();
    if (response.statusCode != 200) {
      throw HttpException('HTTP ${response.statusCode} pour $source');
    }
    bytes = response;
  } else {
    bytes = File(source).openRead();
  }
  if (source.endsWith('.gz')) bytes = bytes.transform(gzip.decoder);
  try {
    yield* bytes
        .transform(const Utf8Decoder(allowMalformed: true))
        .transform(const LineSplitter());
  } finally {
    client?.close(force: true);
  }
}
