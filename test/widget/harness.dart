import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/database.dart';
import 'package:popote/data/repository.dart';
import 'package:popote/domain/models.dart';
import 'package:popote/ui/app.dart';
import 'package:popote/ui/platform.dart';
import 'package:popote/ui/providers.dart';
import 'package:popote/ui/scanner.dart';
import 'package:popote/ui/v2_providers.dart';

import '../helpers/seed_files.dart';

class FakePlatform implements PlatformBridge {
  final shared = <String>[];
  final screenOn = <bool>[];

  @override
  Future<void> shareText(String text, String subject) async => shared.add(text);

  @override
  Future<void> keepScreenOn(bool on) async => screenOn.add(on);

  @override
  Future<bool> saveDocument(String f, String m, Uint8List b) async => true;

  @override
  Future<Uint8List?> openDocument() async => null;

  @override
  Future<bool> copyDocument(String destPath) async => false;

  @override
  Future<bool> pickImage({
    required bool camera,
    required String destPath,
  }) async => false;
}

/// Scanner simulé (SPEC-V2 §12) : un bouton par code à « scanner ».
class FakeScanner implements BarcodeScannerService {
  final codes = <String>[];

  @override
  Widget preview(void Function(String code) onCode) => Column(
    children: [
      for (final c in codes)
        TextButton(
          key: Key('scan-$c'),
          onPressed: () => onCode(c),
          child: Text('scan $c'),
        ),
    ],
  );
}

class Harness {
  Harness(this.repo, this.platform, this.scanner);

  final Repository repo;
  final FakePlatform platform;
  final FakeScanner scanner;
}

/// Mardi 3 mars 2026 : semaine du lundi 2 mars.
final today = DateTime(2026, 3, 3);

/// Base en mémoire avec les données fournies, et éventuellement un profil.
Future<Harness> pumpApp(
  WidgetTester tester, {
  HouseholdProfile? profile,
  Future<void> Function(Repository)? setup,
}) async {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2.5;
  addTearDown(tester.view.reset);

  final repo = Repository(AppDatabase(NativeDatabase.memory()));
  final platform = FakePlatform();
  final scanner = FakeScanner();
  final photos = Directory.systemTemp.createTempSync('popote-photos');
  await tester.runAsync(() async {
    await repo.importSeedIfNeeded(FileSeedSource());
    if (profile != null) await repo.saveProfile(profile);
    if (setup != null) await setup(repo);
  });
  addTearDown(() async {
    await tester.runAsync(() => repo.db.close());
    photos.deleteSync(recursive: true);
  });
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWithValue(repo),
        photoStoreProvider.overrideWithValue(FilePhotoStore(photos)),
        platformProvider.overrideWithValue(platform),
        todayProvider.overrideWithValue(today),
        scannerProvider.overrideWithValue(scanner),
      ],
      child: PopoteApp(onboarded: profile != null),
    ),
  );
  await settle(tester);
  return Harness(repo, platform, scanner);
}

/// Laisse les requêtes de la base (vraies E/S) se terminer, puis l'interface.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 30)),
    );
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

Future<void> tapAndSettle(WidgetTester tester, Finder f) async {
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await settle(tester);
}

/// Fait défiler la première liste jusqu'à ce que [f] soit construit.
Future<void> scrollTo(WidgetTester tester, Finder f) async {
  await tester.scrollUntilVisible(
    f,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}
