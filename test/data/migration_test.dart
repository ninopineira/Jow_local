// Migration drift V1 → V2 (SPEC-V2 §11) : depuis le schéma V1 réel
// (fixture figée avant la V2), aucune donnée perdue.
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/database.dart';
import 'package:popote/data/kitchen_repository.dart';
import 'package:popote/data/product_catalog.dart';
import 'package:popote/data/repository.dart';
import 'package:popote/domain/enums.dart';
import 'package:sqlite3/sqlite3.dart';

import '../helpers/seed_files.dart';

void main() {
  test('V1 → V2 : données conservées, nouvelles tables et valeurs', () async {
    final dir = await Directory.systemTemp.createTemp('popote_mig_');
    final file = File('${dir.path}/popote.sqlite');

    // Base V1 : schéma d'origine et données utilisateur.
    final raw = sqlite3.open(file.path);
    raw.execute(File('test/data/fixtures/schema_v1.sql').readAsStringSync());
    raw.execute('''
INSERT INTO ingredients (id, name, aisle, default_unit, origin)
  VALUES ('pates', 'Pâtes', 'savory', 'g', 'provided'),
         ('perso-sauce', 'Sauce maison', 'savory', 'g', 'personal');
INSERT INTO recipes (id, slug, title, type, servings, prep_min, cook_min,
  difficulty, main_base, origin, created_at, updated_at)
  VALUES (1, NULL, 'Mes pâtes', 'main', 2, 5, 10, 'easy', 'pasta',
          'personal', 1700000000, 1700000000);
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, qty, unit, position)
  VALUES (1, 'pates', 200, 'g', 0), (1, 'perso-sauce', 50, 'g', 1);
INSERT INTO recipe_steps (recipe_id, position, body) VALUES (1, 0, 'Cuire.');
INSERT INTO recipe_user_state (recipe_id, favorite) VALUES (1, 1);
INSERT INTO profile (id, onboarded, people) VALUES (1, 1, 3);
INSERT INTO week_menus (id, start_date, status, seed)
  VALUES (1, 1761436800, 'validated', 7);
INSERT INTO menu_slots (menu_id, day, meal, kind, recipe_id, servings)
  VALUES (1, 0, 'dinner', 'recipe', 1, 3);
INSERT INTO shopping_items (menu_id, ingredient_id, quantity, unit, bought)
  VALUES (1, 'pates', 300, 'g', 1);
INSERT INTO app_meta (key, value) VALUES ('seed_version', '1');
''');
    raw.execute('PRAGMA user_version = 1');
    raw.close();

    final db = AppDatabase(NativeDatabase(file));
    final repo = Repository(db);
    // Données V1 intactes.
    final recipes = await repo.recipes();
    final mine = recipes.single;
    expect(mine.title, 'Mes pâtes');
    expect(mine.ingredients.length, 2);
    expect(mine.steps, ['Cuire.']);
    expect((await repo.userStates())[1]!.favorite, isTrue);
    expect((await repo.profile()).people, 3);
    final menu = (await repo.allMenus()).single;
    expect(menu.status, MenuStatus.validated);
    expect(menu.slots.single.servings, 3);
    expect((await repo.shoppingItems(menu.id!)).single.bought, isTrue);
    final cols = await db
        .customSelect("SELECT name FROM pragma_table_info('ingredients')")
        .get();
    expect(
      cols.map((c) => c.read<String>('name')),
      containsAll(['nutrition', 'density', 'ciqual_code']),
    );
    final version = await db.customSelect('PRAGMA user_version').getSingle();
    expect(version.read<int>('user_version'), 2);

    // Les nouvelles tables sont utilisables.
    final k = KitchenRepository(db, repo, () => const EmptyProductCatalog());
    expect(await k.stock(), isEmpty);
    expect(await k.nutritionProfile(), isNull);

    // Le seed V2 ajoute les valeurs sans toucher aux données perso.
    await repo.importSeedIfNeeded(FileSeedSource());
    final perso = (await repo.ingredients()).firstWhere(
      (i) => i.id == 'perso-sauce',
    );
    expect(perso.origin, Origin.personal);
    final after = await repo.recipes();
    expect(
      after.where((r) => r.origin == Origin.personal).single.title,
      'Mes pâtes',
    );
    expect(
      (await repo.ingredients())
          .where((i) => i.origin == Origin.provided && i.id != 'pates')
          .every((i) => i.nutrition != null),
      isTrue,
    );
    await db.close();
    await dir.delete(recursive: true);
  });
}
