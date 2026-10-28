import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/backup.dart';
import 'package:popote/data/database.dart';
import 'package:popote/data/repository.dart';
import 'package:popote/data/seed.dart';
import 'package:popote/domain/enums.dart';
import 'package:popote/domain/models.dart';

import '../helpers/seed_files.dart';

class MemoryPhotos implements PhotoStore {
  final files = <String, Uint8List>{};

  @override
  Future<Uint8List?> read(String name) async => files[name];

  @override
  Future<void> write(String name, Uint8List bytes) async => files[name] = bytes;
}

Future<Repository> seededRepo() async {
  final repo = Repository(AppDatabase(NativeDatabase.memory()));
  await repo.importSeedIfNeeded(FileSeedSource());
  return repo;
}

/// Seed modifié : version +1, titre de la première recette changé.
MemorySeedSource bumpedSeed() {
  String read(String p) => File('assets/recipes/$p').readAsStringSync();
  final manifest = jsonDecode(read('seed.json')) as Map<String, dynamic>;
  final files = <String, String>{
    'ingredients.json': read('ingredients.json'),
    'nutrition.json': read('nutrition.json'),
    'seed.json': jsonEncode({
      'version': (manifest['version'] as int) + 1,
      'lots': manifest['lots'],
    }),
  };
  final lots = (manifest['lots'] as List).cast<String>();
  for (final lot in lots) {
    files['recipes/$lot.json'] = read('recipes/$lot.json');
  }
  final first =
      jsonDecode(files['recipes/${lots.first}.json']!) as Map<String, dynamic>;
  ((first['recipes'] as List).first as Map)['title'] = 'Titre mis à jour';
  files['recipes/${lots.first}.json'] = jsonEncode(first);
  return MemorySeedSource(files);
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  group('import du seed', () {
    test('import initial complet', () async {
      final repo = await seededRepo();
      final recipes = await repo.recipes();
      expect(recipes.length, greaterThanOrEqualTo(150));
      expect(
        recipes.every((r) => r.ingredients.isNotEmpty && r.steps.isNotEmpty),
        isTrue,
      );
      expect(await repo.meta(Repository.metaSeedVersion), isNotNull);
      await repo.db.close();
    });

    test('import idempotent', () async {
      final repo = await seededRepo();
      final before = await repo.recipes();
      expect(await repo.importSeedIfNeeded(FileSeedSource()), isFalse);
      // Même un import forcé ne crée pas de doublon.
      final data = await loadSeedForTest();
      await repo.importSeed(data);
      final after = await repo.recipes();
      expect(after.length, before.length);
      final lines = await repo.db.select(repo.db.recipeIngredients).get();
      expect(
        lines.length,
        before.fold<int>(0, (n, r) => n + r.ingredients.length),
      );
      await repo.db.close();
    });

    test('nouvelle version : mise à jour par slug sans perte d’état', () async {
      final repo = await seededRepo();
      final first = (await repo.recipes()).firstWhere(
        (r) => r.slug == bumpedFirstSlug(),
      );
      await repo.setUserState(
        first.id,
        const RecipeUserState(favorite: true, disliked: true),
      );
      final perso = await repo.savePersonalRecipe(
        first.copyWith(
          id: 0,
          clearSlug: true,
          title: 'Ma version',
          origin: Origin.personal,
        ),
      );
      expect(await repo.importSeedIfNeeded(bumpedSeed()), isTrue);
      final recipes = await repo.recipes();
      final updated = recipes.firstWhere((r) => r.id == first.id);
      expect(updated.title, 'Titre mis à jour');
      final state = (await repo.userStates())[first.id]!;
      expect(state.favorite, isTrue);
      expect(state.disliked, isTrue);
      expect(recipes.firstWhere((r) => r.id == perso).title, 'Ma version');
      await repo.db.close();
    });
  });

  group('migrations', () {
    test('schéma v2 créé depuis zéro et cohérent', () async {
      final db = AppDatabase(NativeDatabase.memory());
      expect(db.schemaVersion, 2);
      final tables = await db
          .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
          .get();
      final names = tables.map((r) => r.read<String>('name')).toSet();
      for (final t in [
        'ingredients',
        'recipes',
        'recipe_ingredients',
        'recipe_steps',
        'recipe_user_state',
        'profile',
        'week_menus',
        'menu_slots',
        'week_extras',
        'shopping_items',
      ]) {
        expect(names, contains(t));
      }
      final fk = await db.customSelect('PRAGMA foreign_keys').getSingle();
      expect(fk.data.values.first, 1);
      await db.close();
    });

    test('réouverture d’une base existante sans perte', () async {
      final file = File(
        '${Directory.systemTemp.createTempSync('popote').path}/db.sqlite',
      );
      var db = AppDatabase(NativeDatabase(file));
      await Repository(db).setMeta('k', 'v');
      await db.close();
      db = AppDatabase(NativeDatabase(file));
      expect(await Repository(db).meta('k'), 'v');
      await db.close();
      file.parent.deleteSync(recursive: true);
    });
  });

  group('menus et liste', () {
    test('valider un menu : liste calculée, « à caser » retirée', () async {
      final repo = await seededRepo();
      final recipes = (await repo.recipes())
          .where((r) => r.type == RecipeType.main)
          .toList();
      await repo.setUserState(
        recipes[0].id,
        const RecipeUserState(toPlace: true),
      );
      final menu = WeekMenu(
        startDate: DateTime(2026, 3, 2),
        status: MenuStatus.validated,
        slots: [
          MenuSlot(
            key: const SlotKey(0, Meal.dinner),
            kind: SlotKind.recipe,
            recipeId: recipes[0].id,
          ),
          MenuSlot(
            key: const SlotKey(1, Meal.dinner),
            kind: SlotKind.recipe,
            recipeId: recipes[1].id,
          ),
        ],
      );
      final saved = await repo.saveMenu(menu);
      final items = await repo.shoppingItems(saved.id!);
      expect(items, isNotEmpty);
      expect((await repo.userStates())[recipes[0].id]!.toPlace, isFalse);

      // Coche une ligne, modifie le menu : la case reste si la ligne est inchangée.
      final first = items.first;
      await repo.setItemChecks(first.id!, bought: true);
      await repo.addManualItem(saved.id!, 'Éponges');
      final changed = saved.withSlot(
        MenuSlot(
          key: const SlotKey(2, Meal.dinner),
          kind: SlotKind.recipe,
          recipeId: recipes[2].id,
        ),
      );
      final saved2 = await repo.saveMenu(changed);
      final items2 = await repo.shoppingItems(saved2.id!);
      expect(items2.where((i) => i.manual).single.label, 'Éponges');
      final same = items2.where(
        (i) => i.key == first.key && i.quantity == first.quantity,
      );
      if (same.isNotEmpty) expect(same.single.bought, isTrue);
      await repo.db.close();
    });

    test('anti-répétition : recettes des semaines précédentes', () async {
      final repo = await seededRepo();
      final r = (await repo.recipes()).first;
      await repo.saveMenu(
        WeekMenu(
          startDate: DateTime(2026, 2, 23),
          slots: [
            MenuSlot(
              key: const SlotKey(0, Meal.dinner),
              kind: SlotKind.recipe,
              recipeId: r.id,
            ),
          ],
        ),
      );
      expect(await repo.recentRecipeIds(DateTime(2026, 3, 2), 2), {r.id});
      expect(await repo.recentRecipeIds(DateTime(2026, 3, 30), 2), isEmpty);
      await repo.db.close();
    });
  });

  group('export et import', () {
    Future<(Repository, MemoryPhotos)> filled() async {
      final repo = await seededRepo();
      final photos = MemoryPhotos();
      final ings = await repo.ingredients();
      final custom = await repo.createIngredient(
        const Ingredient(
          id: '',
          name: 'Sauce de grand-mère',
          aisle: Aisle.savory,
          defaultUnit: Unit.tbsp,
          allergens: {Allergen.mustard},
        ),
      );
      await repo.saveProfile(
        HouseholdProfile(
          people: 3,
          diet: Diet.pescetarian,
          aversions: {ings.first.id, custom.id},
          exclusions: {Allergen.peanuts},
        ),
      );
      photos.files['p1.jpg'] = Uint8List.fromList([1, 2, 3]);
      final provided = (await repo.recipes()).first;
      final persoId = await repo.savePersonalRecipe(
        Recipe(
          id: 0,
          title: 'Gratin du dimanche',
          type: RecipeType.main,
          prepMin: 20,
          cookMin: 40,
          mainBase: MainBase.potatoes,
          origin: Origin.personal,
          photoPath: 'p1.jpg',
          createdAt: DateTime(2026, 1, 1),
          ingredients: [
            RecipeIngredient(ingredient: custom, qty: 2, unit: Unit.tbsp),
            RecipeIngredient(
              ingredient: ings[3],
              qty: 500,
              unit: Unit.g,
              note: 'en dés',
            ),
          ],
          steps: const ['Préparer.', 'Cuire.'],
        ),
      );
      await repo.setUserState(
        provided.id,
        const RecipeUserState(favorite: true),
      );
      await repo.setUserState(persoId, const RecipeUserState(toPlace: true));
      final menu = await repo.saveMenu(
        WeekMenu(
          startDate: DateTime(2026, 3, 2),
          status: MenuStatus.validated,
          seed: 12,
          slots: [
            MenuSlot(
              key: const SlotKey(0, Meal.dinner),
              kind: SlotKind.recipe,
              recipeId: persoId,
              servings: 6,
              locked: true,
            ),
            const MenuSlot(
              key: SlotKey(1, Meal.lunch),
              kind: SlotKind.leftovers,
              leftoversFrom: SlotKey(0, Meal.dinner),
            ),
          ],
          extras: [WeekExtra(recipeId: provided.id, servings: 4)],
        ),
      );
      await repo.addManualItem(menu.id!, 'Piles');
      await repo.setMeta(Repository.metaLastReviewedWeek, '2026-02-23');
      return (repo, photos);
    }

    /// Vue comparable des données utilisateur (sans les identifiants internes).
    Future<Map<String, dynamic>> snapshot(
      Repository repo,
      MemoryPhotos photos,
    ) async {
      final data = await BackupService(repo, photos).exportData();
      data.remove('exportedAt');
      String norm(Object? o) =>
          jsonEncode(o).replaceAll(RegExp(r'perso:\d+'), 'perso');
      return {
        'json': norm(data),
        'photos': photos.files.map((k, v) => MapEntry(k, v.toList())),
      };
    }

    test(
      'un export puis un import (remplacer) redonnent les mêmes données',
      () async {
        final (repo, photos) = await filled();
        final before = await snapshot(repo, photos);
        final zip = await BackupService(repo, photos).exportZip();

        final (fresh, freshPhotos) = (await seededRepo(), MemoryPhotos());
        final service = BackupService(fresh, freshPhotos);
        final preview = service.preview(zip);
        expect(preview.hasProfile, isTrue);
        expect(preview.personalRecipes, 1);
        expect(preview.menus, 1);
        await service.apply(preview, ImportMode.replace);
        expect(await snapshot(fresh, freshPhotos), before);
        await repo.db.close();
        await fresh.db.close();
      },
    );

    test('fusion : pas de doublon de recette perso ni de menu', () async {
      final (repo, photos) = await filled();
      final service = BackupService(repo, photos);
      final zip = await service.exportZip();
      final before = await snapshot(repo, photos);
      await service.apply(service.preview(zip), ImportMode.merge);
      expect(await snapshot(repo, photos), before);
      await repo.db.close();
    });

    test('un fichier étranger est refusé', () async {
      final repo = await seededRepo();
      final service = BackupService(repo, MemoryPhotos());
      expect(
        () => service.preview(
          Uint8List.fromList(utf8.encode('{"format":"x","version":1}')),
        ),
        throwsFormatException,
      );
      await repo.db.close();
    });

    test('réinitialisation : données utilisateur effacées, recettes fournies gardées', () async {
      final (repo, _) = await filled();
      final provided = (await repo.recipes())
          .where((r) => r.origin == Origin.provided)
          .length;
      await repo.resetAll();
      expect(await repo.isOnboarded(), isFalse);
      expect(await repo.allMenus(), isEmpty);
      expect(await repo.userStates(), isEmpty);
      final recipes = await repo.recipes();
      expect(recipes.every((r) => r.origin == Origin.provided), isTrue);
      expect(recipes.length, provided);
      expect(
        (await repo.ingredients()).where((i) => i.origin == Origin.personal),
        isEmpty,
      );
      await repo.db.close();
    });
  });
}

Future<SeedData> loadSeedForTest() => loadSeed(FileSeedSource());

String bumpedFirstSlug() {
  final manifest = jsonDecode(
    File('assets/recipes/seed.json').readAsStringSync(),
  );
  final lot = (manifest['lots'] as List).first;
  final data = jsonDecode(
    File('assets/recipes/recipes/$lot.json').readAsStringSync(),
  );
  return ((data['recipes'] as List).first as Map)['slug'] as String;
}
