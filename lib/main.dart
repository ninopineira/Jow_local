import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'data/database.dart';
import 'data/repository.dart';
import 'data/seed.dart';
import 'ui/app.dart';
import 'ui/platform.dart';
import 'ui/providers.dart';
import 'ui/v2_providers.dart';

/// Données fournies lues depuis les assets de l'app.
class AssetSeedSource implements SeedSource {
  @override
  Future<String> read(String relativePath) =>
      rootBundle.loadString('assets/recipes/$relativePath');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final db = AppDatabase(
    NativeDatabase.createInBackground(File('${dir.path}/popote.sqlite')),
  );
  final repo = Repository(db);
  await repo.importSeedIfNeeded(AssetSeedSource());
  final onboarded = await repo.isOnboarded();
  runApp(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWithValue(repo),
        photoStoreProvider.overrideWithValue(
          FilePhotoStore(Directory('${dir.path}/photos')),
        ),
        // Base produits importée (SPEC-V2 §3), dans le dossier privé.
        productDbFileProvider.overrideWithValue(
          File('${dir.path}/products.db'),
        ),
      ],
      child: PopoteApp(onboarded: onboarded),
    ),
  );
}
