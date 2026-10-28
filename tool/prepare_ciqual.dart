// Prépare l'extrait Ciqual utilisé par les données nutritionnelles (SPEC-V2 §4).
//
// Usage (pendant le développement uniquement) :
//   dart run tool/prepare_ciqual.dart <dossier des XML Ciqual>
//
// Le dossier contient alim_*.xml, alim_grp_*.xml et compo_*.xml de la table
// Ciqual 2025 (Anses, Licence Ouverte Etalab 2.0), téléchargés depuis
// https://entrepot.recherche.data.gouv.fr (doi:10.57745/RDMHWY).
//
// Sortie : tool/data/ciqual/ciqual_2025.tsv, une ligne par aliment, avec les
// valeurs brutes (« < 0,5 », « traces », « - ») et les bornes min/max des
// constituants utiles. La règle prudente est appliquée plus tard, par
// tool/build_nutrition.dart, pas ici.
import 'dart:convert';
import 'dart:io';

/// Constituants conservés : code Ciqual → nom de colonne.
const constituents = {
  '328': 'kcal',
  '25000': 'protein',
  '31000': 'carbs',
  '40000': 'fat',
  '32000': 'sugars',
  '40302': 'satFat',
  '34100': 'fiber',
  '10004': 'salt',
};

String _decode(String s) => s
    .trim()
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&apos;', "'")
    .replaceAll('&amp;', '&');

String? _field(String block, String tag) {
  final m = RegExp('<$tag>([^<]*)</$tag>').firstMatch(block);
  return m == null ? null : _decode(m.group(1)!);
}

File _find(Directory dir, String prefix) =>
    dir.listSync().whereType<File>().firstWhere(
      (f) => f.uri.pathSegments.last.startsWith(prefix),
      orElse: () =>
          throw StateError('$prefix*.xml introuvable dans ${dir.path}'),
    );

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    stderr.writeln('Usage : dart run tool/prepare_ciqual.dart <dossier XML>');
    exit(64);
  }
  final dir = Directory(args.first);
  final alimFile = _find(dir, 'alim_2');
  final grpFile = _find(dir, 'alim_grp');
  final compoFile = _find(dir, 'compo');

  final groups = <String, String>{};
  for (final m in RegExp(
    r'<ALIM_GRP>(.*?)</ALIM_GRP>',
    dotAll: true,
  ).allMatches(await grpFile.readAsString())) {
    final b = m.group(1)!;
    final code = _field(b, 'alim_ssgrp_code') ?? _field(b, 'alim_grp_code');
    final name = _field(b, 'alim_ssgrp_nom_fr') ?? _field(b, 'alim_grp_nom_fr');
    if (code != null && name != null) groups[code] = name;
  }

  final foods = <String, Map<String, String>>{};
  for (final m in RegExp(
    r'<ALIM>(.*?)</ALIM>',
    dotAll: true,
  ).allMatches(await alimFile.readAsString())) {
    final b = m.group(1)!;
    final code = _field(b, 'alim_code')!;
    foods[code] = {
      'name': _field(b, 'alim_nom_fr') ?? '',
      'group': groups[_field(b, 'alim_ssgrp_code') ?? ''] ?? '',
    };
  }

  // compo_*.xml fait ~70 Mo : lecture ligne à ligne, un bloc à la fois.
  final values = <String, Map<String, String>>{};
  final buffer = StringBuffer();
  await for (final line
      in compoFile
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
    if (line.contains('<COMPO>')) buffer.clear();
    buffer.writeln(line);
    if (!line.contains('</COMPO>')) continue;
    final b = buffer.toString();
    final column = constituents[_field(b, 'const_code')];
    if (column == null) continue;
    final code = _field(b, 'alim_code')!;
    final row = values.putIfAbsent(code, () => {});
    row[column] = _field(b, 'teneur') ?? '-';
    final min = _field(b, 'min');
    final max = _field(b, 'max');
    if (min != null && min.isNotEmpty) row['${column}Min'] = min;
    if (max != null && max.isNotEmpty) row['${column}Max'] = max;
  }

  final columns = [
    for (final c in constituents.values) ...[c, '${c}Min', '${c}Max'],
  ];
  final out = File('tool/data/ciqual/ciqual_2025.tsv');
  await out.parent.create(recursive: true);
  final sink = out.openWrite();
  sink.writeln(['code', 'name', 'group', ...columns].join('\t'));
  final codes = foods.keys.toList()
    ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
  for (final code in codes) {
    final row = values[code] ?? const {};
    sink.writeln(
      [
        code,
        foods[code]!['name'],
        foods[code]!['group'],
        for (final c in columns) row[c] ?? '',
      ].join('\t'),
    );
  }
  await sink.close();
  stdout.writeln('${codes.length} aliments écrits dans ${out.path}');
}
