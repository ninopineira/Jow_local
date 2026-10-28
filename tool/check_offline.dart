// Contrôle « 100 % hors ligne » (SPEC §1.5, SPEC-V2 §1).
//
// Usage, après `flutter build apk --release` :
//   dart run tool/check_offline.dart [chemin/vers/app-release.apk]
//
// Échoue (code 1) si :
//   1. l'APK release déclare INTERNET ou ACCESS_NETWORK_STATE (manifeste
//      fusionné, lu avec aapt2 ou apkanalyzer du SDK Android), ou une
//      permission hors de la liste attendue (V2 : CAMERA est la seule
//      nouvelle permission tolérée) ;
//   2. pubspec.lock contient un paquet de la liste noire dans le graphe des
//      dépendances de l'app (les outils de dev comme build_runner ne partent
//      pas dans l'APK : ils sont signalés pour information, voir DECISIONS.md) ;
//   3. lib/ contient un motif réseau interdit.
import 'dart:convert';
import 'dart:io';

const forbiddenPermissions = [
  'android.permission.INTERNET',
  'android.permission.ACCESS_NETWORK_STATE',
];

/// Permissions attendues dans l'APK release : CAMERA (scan, SPEC-V2 §1) et
/// la permission interne générée par AndroidX pour les récepteurs.
const allowedPermissions = ['android.permission.CAMERA'];
const allowedPermissionSuffixes = ['.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION'];

/// Paquets interdits (noms exacts) et familles (préfixes ou fragments).
const blacklistExact = {
  'http',
  'dio',
  'chopper',
  'retrofit',
  'web_socket_channel',
  'grpc',
  'google_fonts',
  'cached_network_image',
  'url_launcher',
  // SDK Open Food Facts (réseau) : la base produits est importée par fichier.
  'openfoodfacts',
};
const blacklistPrefixes = ['firebase_', 'sentry', 'supabase', 'url_launcher_'];
const blacklistFragments = [
  'analytics',
  'crashlytics',
  'admob',
  'google_mobile_ads',
  'mixpanel',
  'amplitude',
  'appsflyer',
  'onesignal',
  'bugsnag',
  'datadog',
  'segment_',
  'nutritionix',
  'edamam',
  'spoonacular',
  'fatsecret',
];

/// Motifs interdits dans lib/ (SPEC §1.2), plus quelques équivalents.
final forbiddenCode = <String, RegExp>{
  'HttpClient': RegExp(r'\bHttpClient\b'),
  'Image.network': RegExp(r'Image\.network\b'),
  'NetworkImage': RegExp(r'\bNetworkImage\b'),
  'Uri.http': RegExp(r'Uri\.https?\s*\('),
  'Socket': RegExp(r'\b(Raw)?(Secure)?(Web)?Socket\b'),
  'dart:html': RegExp(r'''['"]dart:html['"]'''),
  'drift remote': RegExp(r'package:drift/remote\.dart'),
  'URL http(s)': RegExp(r'https?://'),
  'HttpServer / InternetAddress': RegExp(r'\b(HttpServer|InternetAddress)\b'),
};

bool isBlacklisted(String name) =>
    blacklistExact.contains(name) ||
    blacklistPrefixes.any(name.startsWith) ||
    blacklistFragments.any(name.contains);

Future<void> main(List<String> args) async {
  final failures = <String>[];
  final infos = <String>[];

  // 1. Permissions de l'APK release.
  final apk = File(
    args.isNotEmpty
        ? args.first
        : 'build/app/outputs/flutter-apk/app-release.apk',
  );
  if (!apk.existsSync()) {
    failures.add(
      'APK release introuvable (${apk.path}) : lancer `flutter build apk --release`.',
    );
  } else {
    final perms = await apkPermissions(apk.path);
    if (perms == null) {
      failures.add('aapt2 / apkanalyzer introuvables dans le SDK Android.');
    } else {
      stdout.writeln('Permissions de l’APK release (${perms.length}) :');
      for (final p in perms) {
        stdout.writeln('  - $p');
      }
      for (final f in forbiddenPermissions) {
        if (perms.contains(f)) {
          failures.add('Permission interdite dans l’APK : $f');
        }
      }
      for (final p in perms) {
        final expected =
            allowedPermissions.contains(p) ||
            allowedPermissionSuffixes.any(p.endsWith) ||
            forbiddenPermissions.contains(p);
        if (!expected) {
          failures.add('Permission inattendue dans l’APK : $p');
        }
      }
    }
  }

  // 1 bis. Scan sur l'appareil (SPEC-V2 §1) : le modèle ML Kit doit rester
  // embarqué ; `useUnbundled` le ferait télécharger par les services Google.
  for (final f in [
    File('android/gradle.properties'),
    File('android/app/build.gradle.kts'),
  ]) {
    if (f.existsSync() &&
        RegExp(r'useUnbundled\s*=\s*true').hasMatch(f.readAsStringSync())) {
      failures.add('mobile_scanner en mode « unbundled » dans ${f.path}');
    }
  }

  // 2. Dépendances.
  final lockPackages = readLockPackages(File('pubspec.lock'));
  final runtime = await runtimeClosure();
  if (runtime == null) {
    failures.add(
      'Impossible de calculer le graphe des dépendances (dart pub deps).',
    );
  } else {
    for (final name in lockPackages.where(isBlacklisted)) {
      if (runtime.contains(name)) {
        failures.add('Paquet de la liste noire dans l’app : $name');
      } else {
        infos.add('$name (outil de dev seulement, absent de l’APK)');
      }
    }
    stdout.writeln(
      'Dépendances : ${lockPackages.length} dans pubspec.lock, '
      '${runtime.length} dans le graphe de l’app.',
    );
  }

  // 3. Code de lib/.
  var scanned = 0;
  for (final f in Directory(
    'lib',
  ).listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    scanned++;
    final lines = f.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      for (final e in forbiddenCode.entries) {
        if (e.value.hasMatch(lines[i])) {
          failures.add('${f.path}:${i + 1} : motif interdit « ${e.key} »');
        }
      }
    }
  }
  stdout.writeln('Code : $scanned fichiers Dart analysés dans lib/.');

  for (final i in infos) {
    stdout.writeln('info : $i');
  }
  if (failures.isEmpty) {
    stdout.writeln(
      'check_offline : OK — aucune permission réseau, aucun paquet ni motif interdit.',
    );
    return;
  }
  for (final f in failures) {
    stderr.writeln('ÉCHEC : $f');
  }
  stderr.writeln('check_offline : ${failures.length} problème(s).');
  exitCode = 1;
}

Set<String> readLockPackages(File lock) {
  final names = <String>{};
  var inPackages = false;
  for (final line in lock.readAsLinesSync()) {
    if (line.startsWith('packages:')) {
      inPackages = true;
      continue;
    }
    if (inPackages && line.isNotEmpty && !line.startsWith(' ')) {
      inPackages = false;
    }
    final m = RegExp(r'^  ([a-z0-9_]+):\s*$').firstMatch(line);
    if (inPackages && m != null) names.add(m.group(1)!);
  }
  return names;
}

/// Paquets atteignables depuis les dépendances non-dev du projet.
Future<Set<String>?> runtimeClosure() async {
  final r = await Process.run('dart', [
    'pub',
    'deps',
    '--json',
  ], runInShell: true);
  if (r.exitCode != 0) return null;
  final out = r.stdout as String;
  final data =
      jsonDecode(out.substring(out.indexOf('{'))) as Map<String, dynamic>;
  final packages = {
    for (final p in (data['packages'] as List).cast<Map<String, dynamic>>())
      p['name'] as String: p,
  };
  final root = data['root'] as String;
  final rootPkg = packages[root]!;
  final directDeps =
      (rootPkg['directDependencies'] as List? ??
              rootPkg['dependencies'] as List)
          .cast<String>();
  final seen = <String>{};
  final todo = [...directDeps];
  while (todo.isNotEmpty) {
    final n = todo.removeLast();
    if (!seen.add(n)) continue;
    final deps = (packages[n]?['dependencies'] as List?)?.cast<String>() ?? [];
    todo.addAll(deps);
  }
  return seen;
}

/// Permissions déclarées par l'APK (manifeste fusionné).
Future<Set<String>?> apkPermissions(String apk) async {
  final sdk = androidSdk();
  if (sdk == null) return null;
  final win = Platform.isWindows;
  final buildTools = Directory('${sdk.path}/build-tools');
  if (buildTools.existsSync()) {
    final versions = buildTools.listSync().whereType<Directory>().toList()
      ..sort((a, b) => b.path.compareTo(a.path));
    for (final v in versions) {
      final aapt2 = File('${v.path}/aapt2${win ? '.exe' : ''}');
      if (!aapt2.existsSync()) continue;
      final r = await Process.run(aapt2.path, ['dump', 'permissions', apk]);
      if (r.exitCode != 0) continue;
      return {
        for (final m in RegExp(
          r"name='([^']+)'",
        ).allMatches(r.stdout as String))
          m.group(1)!,
      };
    }
  }
  final analyzer = File(
    '${sdk.path}/cmdline-tools/latest/bin/apkanalyzer${win ? '.bat' : ''}',
  );
  if (analyzer.existsSync()) {
    final r = await Process.run(analyzer.path, [
      'manifest',
      'permissions',
      apk,
    ], runInShell: true);
    if (r.exitCode == 0) {
      return (r.stdout as String)
          .split(RegExp(r'\r?\n'))
          .map((l) => l.trim())
          .where((l) => l.isNotEmpty)
          .toSet();
    }
  }
  return null;
}

Directory? androidSdk() {
  final env = Platform.environment;
  final candidates = [
    env['ANDROID_HOME'],
    env['ANDROID_SDK_ROOT'],
    if (env['LOCALAPPDATA'] != null) '${env['LOCALAPPDATA']}/Android/Sdk',
    if (env['HOME'] != null) '${env['HOME']}/Android/Sdk',
  ];
  for (final c in candidates) {
    if (c != null && Directory(c).existsSync()) return Directory(c);
  }
  return null;
}
