import 'dart:convert';
import 'dart:io';

import 'package:popote/data/seed.dart';

/// Lit les données fournies depuis le disque (tests sur l'hôte).
class FileSeedSource implements SeedSource {
  FileSeedSource([this.root = 'assets/recipes']);

  final String root;

  @override
  Future<String> read(String relativePath) =>
      File('$root/$relativePath').readAsString();
}

/// Source en mémoire, pour simuler une nouvelle version du seed.
class MemorySeedSource implements SeedSource {
  MemorySeedSource(this.files);

  final Map<String, String> files;

  @override
  Future<String> read(String relativePath) async => files[relativePath]!;
}

Object? readJson(String relativePath) =>
    jsonDecode(File('assets/recipes/$relativePath').readAsStringSync());
