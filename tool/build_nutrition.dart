// Calcule assets/recipes/nutrition.json depuis les lots de correspondance
// (assets/recipes/nutrition/<lot>.json, écrits par le sous-agent
// redacteur-nutrition) et l'extrait Ciqual tool/data/ciqual/ciqual_2025.tsv.
//
//   dart run tool/build_nutrition.dart
//
// Règle prudente (docs/INVENTAIRE_NUTRITION.md, choix C3-C4) : glucides,
// lipides, sucres, AG saturés et sel à la borne haute ; protéines et fibres à
// la borne basse ; énergie à sa borne haute, sinon décalée de l'énergie
// (4/4/9) des grammes ajoutés ou retirés. « < x » → x (0 pour protéines et
// fibres), « traces » → 0. Énergie absente (« - ») : déduite des macros,
// signalée dans le rapport.
import 'dart:convert';
import 'dart:io';

const _high = {'carbs', 'fat', 'sugars', 'satFat', 'salt', 'kcal'};
const _nutrients = [
  'kcal',
  'protein',
  'carbs',
  'fat',
  'sugars',
  'satFat',
  'fiber',
  'salt',
];

double? _value(String? raw, String nutrient) {
  if (raw == null) return null;
  final t = raw.trim();
  if (t.isEmpty || t == '-') return null;
  if (t.toLowerCase() == 'traces') return 0;
  if (t.startsWith('<')) {
    if (!_high.contains(nutrient)) return 0;
    return double.tryParse(t.substring(1).trim().replaceAll(',', '.'));
  }
  return double.tryParse(t.replaceAll(',', '.'));
}

void main() {
  final tsv = File('tool/data/ciqual/ciqual_2025.tsv').readAsLinesSync();
  final cols = tsv.first.split('\t');
  final ciqual = <String, Map<String, String>>{};
  for (final line in tsv.skip(1)) {
    final f = line.split('\t');
    ciqual[f[0]] = {
      for (var i = 0; i < cols.length && i < f.length; i++) cols[i]: f[i],
    };
  }

  final catalogue =
      (jsonDecode(
                File('assets/recipes/ingredients.json').readAsStringSync(),
              )['ingredients']
              as List)
          .cast<Map<String, dynamic>>();
  final mapping = <String, Map<String, dynamic>>{};
  final lots =
      Directory('assets/recipes/nutrition')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final lot in lots) {
    final data = jsonDecode(lot.readAsStringSync()) as Map<String, dynamic>;
    for (final item in (data['items'] as List).cast<Map<String, dynamic>>()) {
      mapping[item['id'] as String] = item;
    }
  }

  final report = <String>[];
  final items = <String, Map<String, Object?>>{};
  for (final ing in catalogue) {
    final id = ing['id'] as String;
    final m = mapping[id];
    if (m == null) {
      report.add('ABSENT  $id : aucun lot ne le traite');
      continue;
    }
    if (m['zero'] == true) {
      items[id] = {
        'ciqual': null,
        'kcal': 0.0,
        'protein': 0.0,
        'carbs': 0.0,
        'fat': 0.0,
      };
      report.add('ZÉRO  $id : quantité négligeable');
      continue;
    }
    final code = m['ciqualCode'] as String?;
    final row = code == null ? null : ciqual[code];
    if (row == null) {
      report.add('SANS CODE  $id ${code ?? ''} ${m['note'] ?? ''}');
      continue;
    }
    final single = {for (final n in _nutrients) n: _value(row[n], n)};
    final min = {for (final n in _nutrients) n: _value(row['${n}Min'], n)};
    final max = {for (final n in _nutrients) n: _value(row['${n}Max'], n)};
    for (final n in ['protein', 'carbs', 'fat']) {
      if (single[n] == null) {
        report.add('MACRO 0  $id : $n absent dans Ciqual $code, compté 0');
        single[n] = 0;
      }
    }
    final resolved = <String, double?>{};
    for (final n in _nutrients.skip(1)) {
      final bound = _high.contains(n) ? max[n] : min[n];
      resolved[n] = bound ?? single[n];
    }
    double kcalOf(Map<String, double?> v) =>
        4 * v['protein']! + 4 * v['carbs']! + 9 * v['fat']!;
    double kcal;
    if (single['kcal'] == null) {
      kcal = kcalOf(resolved) + 2 * (resolved['fiber'] ?? 0);
      report.add(
        'KCAL DÉDUITES  $id : ${kcal.toStringAsFixed(1)} (Ciqual $code)',
      );
    } else if (max['kcal'] != null) {
      kcal = max['kcal']!;
    } else {
      kcal = single['kcal']! + kcalOf(resolved) - kcalOf(single);
      if (kcal < 0) kcal = 0;
    }
    double r(double v) => (v * 1000).round() / 1000;
    final density = (m['density'] ?? m['densityGPerMl']) as num?;
    items[id] = {
      'ciqual': code,
      'kcal': r(kcal),
      for (final n in _nutrients.skip(1))
        if (resolved[n] != null) n: r(resolved[n]!),
      if (density != null) 'density': density.toDouble(),
    };
  }

  final out = {
    'source': 'Table Ciqual 2025 (Anses), Licence Ouverte Etalab 2.0',
    'ciqualVersion': '2025-11-03',
    'items': items,
  };
  File('assets/recipes/nutrition.json')
      .writeAsStringSync('${const JsonEncoder.withIndent(' ').convert(out)}\n');
  stdout.writeln(
    '${items.length}/${catalogue.length} ingrédients avec valeurs '
    '→ assets/recipes/nutrition.json',
  );
  for (final line in report) {
    stdout.writeln('  $line');
  }
}
