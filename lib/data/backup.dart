import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart' show Value;

import '../domain/enums.dart';
import '../domain/models.dart';
import 'database.dart';
import 'repository.dart';

/// Format d'export versionné (SPEC §3.9) : `data.json` + `photos/` dans un zip.
const exportFormat = 'popote-export';
const exportVersion = 1;

/// Accès aux photos des recettes perso (dossier privé de l'app).
abstract class PhotoStore {
  Future<Uint8List?> read(String name);
  Future<void> write(String name, Uint8List bytes);
}

enum ImportMode { merge, replace }

class ImportPreview {
  const ImportPreview({
    required this.data,
    required this.photos,
    required this.exportedAt,
    required this.hasProfile,
    required this.personalRecipes,
    required this.favorites,
    required this.menus,
  });

  final Map<String, dynamic> data;
  final Map<String, Uint8List> photos;
  final DateTime? exportedAt;
  final bool hasProfile;
  final int personalRecipes;
  final int favorites;
  final int menus;
}

String _dateCode(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
DateTime _parseDate(String s) {
  final p = s.split('-').map(int.parse).toList();
  return DateTime(p[0], p[1], p[2]);
}

Map<String, dynamic> ingredientToJson(Ingredient i) => {
  'id': i.id,
  'name': i.name,
  'aisle': i.aisle.code,
  'defaultUnit': i.defaultUnit.code,
  if (i.avgPieceWeightG != null) 'avgPieceWeightG': i.avgPieceWeightG,
  'pantry': i.pantry,
  'perishable': i.perishable,
  'markers': [for (final m in i.markers) m.code],
  'allergens': [for (final a in i.allergens) a.code],
  'seasonMonths': i.seasonMonths.toList()..sort(),
};

class BackupService {
  BackupService(this.repo, this.photos);

  final Repository repo;
  final PhotoStore photos;

  AppDatabase get _db => repo.db;

  String _ref(Recipe r) =>
      r.origin == Origin.provided ? 'slug:${r.slug}' : 'perso:${r.id}';

  /// Construit l'archive zip de toutes les données utilisateur.
  Future<Uint8List> exportZip() async {
    final data = await exportData();
    final archive = Archive();
    final json = utf8.encode(const JsonEncoder.withIndent(' ').convert(data));
    archive.addFile(ArchiveFile('data.json', json.length, json));
    for (final r in (data['personalRecipes'] as List)) {
      final name = (r as Map)['photo'] as String?;
      if (name == null) continue;
      final bytes = await photos.read(name);
      if (bytes != null) {
        archive.addFile(ArchiveFile('photos/$name', bytes.length, bytes));
      }
    }
    return Uint8List.fromList(ZipEncoder().encode(archive));
  }

  Future<Map<String, dynamic>> exportData() async {
    final recipes = await repo.recipes();
    final byId = {for (final r in recipes) r.id: r};
    final personal = recipes.where((r) => r.origin == Origin.personal);
    final ingredients = await repo.ingredients();
    final states = await repo.userStates();
    final menus = await repo.allMenus();
    final p = await repo.profile();
    final onboarded = await repo.isOnboarded();

    String? refOf(int? id) =>
        id == null || byId[id] == null ? null : _ref(byId[id]!);

    return {
      'format': exportFormat,
      'version': exportVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'profile': onboarded
          ? {
              'people': p.people,
              'diet': p.diet.code,
              'noPork': p.noPork,
              'exclusions': [for (final a in p.exclusions) a.code],
              'aversions': p.aversions.toList(),
              'equipment': [for (final e in p.equipment) e.code],
              'slots': [for (final s in p.activeSlots) slotKeyCode(s)],
              'maxMinWeekday': p.maxMinWeekday,
              'maxMinWeekend': p.maxMinWeekend,
              'weekStartDay': p.weekStartDay,
              'favoriteShare': p.favoriteShare,
              'antiRepeatWeeks': p.antiRepeatWeeks,
              'aisleOrder': [for (final a in p.aisleOrder) a.code],
              'theme': p.theme.code,
            }
          : null,
      'personalIngredients': [
        for (final i in ingredients.where((i) => i.origin == Origin.personal))
          ingredientToJson(i),
      ],
      'personalRecipes': [
        for (final r in personal)
          {
            'ref': _ref(r),
            'title': r.title,
            'description': r.description,
            'type': r.type.code,
            'servings': r.servings,
            'prepMin': r.prepMin,
            'cookMin': r.cookMin,
            'difficulty': r.difficulty.code,
            'equipment': [for (final e in r.equipment) e.code],
            'mainBase': r.mainBase.code,
            'photo': r.photoPath,
            'createdAt': r.createdAt?.toIso8601String(),
            'updatedAt': r.updatedAt?.toIso8601String(),
            'ingredients': [
              for (final l in r.ingredients)
                {
                  'id': l.ingredient.id,
                  'qty': l.qty,
                  'unit': l.unit.code,
                  'optional': l.optional,
                  'note': ?l.note,
                },
            ],
            'steps': r.steps,
          },
      ],
      'userStates': [
        for (final e in states.entries)
          if (byId[e.key] != null)
            {
              'recipe': _ref(byId[e.key]!),
              'favorite': e.value.favorite,
              'toPlace': e.value.toPlace,
              'disliked': e.value.disliked,
              'lastPlannedAt': e.value.lastPlannedAt?.toIso8601String(),
            },
      ],
      'menus': [
        for (final m in menus)
          {
            'startDate': _dateCode(m.startDate),
            'status': m.status.code,
            'seed': m.seed,
            'slots': [
              for (final s in m.slots)
                {
                  'slot': slotKeyCode(s.key),
                  'kind': s.kind.code,
                  'recipe': refOf(s.recipeId),
                  'servings': s.servings,
                  'locked': s.locked,
                  'leftoversFrom': s.leftoversFrom == null
                      ? null
                      : slotKeyCode(s.leftoversFrom!),
                },
            ],
            'extras': [
              for (final e in m.extras)
                if (refOf(e.recipeId) != null)
                  {'recipe': refOf(e.recipeId), 'servings': e.servings},
            ],
            'shopping': [
              for (final i in await repo.shoppingItems(m.id!))
                {
                  'ingredientId': i.ingredientId,
                  'label': i.label,
                  'quantity': i.quantity,
                  'unit': i.unit?.code,
                  'bought': i.bought,
                  'atHome': i.atHome,
                  'manual': i.manual,
                },
            ],
          },
      ],
      'lastReviewedWeek': await repo.meta(Repository.metaLastReviewedWeek),
    };
  }

  /// Lit une archive (zip) ou un JSON seul et prépare l'aperçu.
  ImportPreview preview(Uint8List bytes) {
    Map<String, dynamic> data;
    final photosOut = <String, Uint8List>{};
    final isZip = bytes.length > 3 && bytes[0] == 0x50 && bytes[1] == 0x4B;
    if (isZip) {
      final archive = ZipDecoder().decodeBytes(bytes);
      final json = archive.findFile('data.json');
      if (json == null) throw const FormatException('data.json absent');
      data = jsonDecode(utf8.decode(json.content)) as Map<String, dynamic>;
      for (final f in archive.files) {
        if (!f.isFile || !f.name.startsWith('photos/')) continue;
        final name = f.name.substring('photos/'.length);
        if (isSafePhotoName(name)) {
          photosOut[name] = Uint8List.fromList(f.content);
        }
      }
    } else {
      data = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    }
    if (data['format'] != exportFormat) {
      throw const FormatException('Ce fichier n’est pas un export Popote');
    }
    if ((data['version'] as int) > exportVersion) {
      throw const FormatException('Export d’une version plus récente');
    }
    return ImportPreview(
      data: data,
      photos: photosOut,
      exportedAt: DateTime.tryParse(data['exportedAt'] as String? ?? ''),
      hasProfile: data['profile'] != null,
      personalRecipes: (data['personalRecipes'] as List).length,
      favorites: (data['userStates'] as List)
          .where((s) => (s as Map)['favorite'] == true)
          .length,
      menus: (data['menus'] as List).length,
    );
  }

  Future<void> apply(ImportPreview preview, ImportMode mode) async {
    final data = preview.data;
    await _db.transaction(() async {
      if (mode == ImportMode.replace) await repo.resetAll();

      for (final i in (data['personalIngredients'] as List)) {
        final m = i as Map<String, dynamic>;
        await repo.upsertIngredient(_ingredientFromJson(m));
      }

      // Profil : remplacé, ou importé en fusion si aucun profil n'existe.
      final p = data['profile'] as Map<String, dynamic>?;
      if (p != null &&
          (mode == ImportMode.replace || !await repo.isOnboarded())) {
        await repo.saveProfile(_profileFromJson(p));
      }

      // Recettes perso : nouvelles lignes, sauf doublon (même titre et date).
      final existing = await repo.recipes();
      final refs = <String, int>{
        for (final r in existing)
          if (r.origin == Origin.provided && r.slug != null)
            'slug:${r.slug}': r.id,
      };
      final ingredientsById = {
        for (final i in await repo.ingredients()) i.id: i,
      };
      for (final raw in (data['personalRecipes'] as List)) {
        final m = raw as Map<String, dynamic>;
        final createdAt = DateTime.tryParse(m['createdAt'] as String? ?? '');
        final dup = existing.where(
          (r) =>
              r.origin == Origin.personal &&
              r.title == m['title'] &&
              r.createdAt == createdAt,
        );
        if (dup.isNotEmpty) {
          refs[m['ref'] as String] = dup.first.id;
          continue;
        }
        final rawPhoto = m['photo'] as String?;
        final photo = rawPhoto != null && isSafePhotoName(rawPhoto)
            ? rawPhoto
            : null;
        if (photo != null && preview.photos[photo] != null) {
          await photos.write(photo, preview.photos[photo]!);
        }
        final recipe = Recipe(
          id: 0,
          title: m['title'] as String,
          description: m['description'] as String? ?? '',
          type: RecipeType.fromCode(m['type'] as String),
          servings: m['servings'] as int,
          prepMin: m['prepMin'] as int,
          cookMin: m['cookMin'] as int,
          difficulty: Difficulty.fromCode(m['difficulty'] as String),
          equipment: {
            for (final e in (m['equipment'] as List))
              Equipment.fromCode(e as String),
          },
          mainBase: MainBase.fromCode(m['mainBase'] as String),
          origin: Origin.personal,
          photoPath: photo,
          createdAt: createdAt,
          updatedAt: DateTime.tryParse(m['updatedAt'] as String? ?? ''),
          ingredients: [
            for (final l
                in (m['ingredients'] as List).cast<Map<String, dynamic>>())
              if (ingredientsById[l['id']] != null)
                RecipeIngredient(
                  ingredient: ingredientsById[l['id']]!,
                  qty: (l['qty'] as num).toDouble(),
                  unit: Unit.fromCode(l['unit'] as String),
                  optional: l['optional'] as bool? ?? false,
                  note: l['note'] as String?,
                ),
          ],
          steps: (m['steps'] as List).cast<String>(),
        );
        refs[m['ref'] as String] = await repo.savePersonalRecipe(recipe);
      }

      final states = await repo.userStates();
      for (final raw in (data['userStates'] as List)) {
        final m = raw as Map<String, dynamic>;
        final id = refs[m['recipe']];
        if (id == null) continue;
        final cur = states[id] ?? RecipeUserState.none;
        final last = DateTime.tryParse(m['lastPlannedAt'] as String? ?? '');
        await repo.setUserState(
          id,
          RecipeUserState(
            favorite: cur.favorite || m['favorite'] == true,
            toPlace: cur.toPlace || m['toPlace'] == true,
            disliked: cur.disliked || m['disliked'] == true,
            lastPlannedAt: _latest(cur.lastPlannedAt, last),
          ),
        );
      }

      for (final raw in (data['menus'] as List)) {
        final m = raw as Map<String, dynamic>;
        final start = _parseDate(m['startDate'] as String);
        if (await repo.menuFor(start) != null) continue; // fusion : on garde
        final menuId = await _db
            .into(_db.weekMenus)
            .insert(
              WeekMenusCompanion.insert(
                startDate: start,
                status: Value(m['status'] as String),
                seed: Value(m['seed'] as int),
              ),
            );
        for (final s in (m['slots'] as List).cast<Map<String, dynamic>>()) {
          final key = slotKeyFromCode(s['slot'] as String);
          final recipeId = s['recipe'] == null ? null : refs[s['recipe']];
          var kind = s['kind'] as String;
          if (kind == SlotKind.recipe.code && recipeId == null) {
            kind = SlotKind.empty.code;
          }
          await _db
              .into(_db.menuSlots)
              .insert(
                MenuSlotsCompanion.insert(
                  menuId: menuId,
                  day: key.day,
                  meal: key.meal.code,
                  kind: kind,
                  recipeId: Value(recipeId),
                  servings: s['servings'] as int,
                  locked: Value(s['locked'] as bool),
                  leftoversFrom: Value(s['leftoversFrom'] as String?),
                ),
              );
        }
        for (final e in (m['extras'] as List).cast<Map<String, dynamic>>()) {
          final id = refs[e['recipe']];
          if (id == null) continue;
          await _db
              .into(_db.weekExtras)
              .insert(
                WeekExtrasCompanion.insert(
                  menuId: menuId,
                  recipeId: id,
                  servings: e['servings'] as int,
                ),
              );
        }
        for (final i in (m['shopping'] as List).cast<Map<String, dynamic>>()) {
          final ingId = i['ingredientId'] as String?;
          if (ingId != null && ingredientsById[ingId] == null) continue;
          await _db
              .into(_db.shoppingItems)
              .insert(
                ShoppingItemsCompanion.insert(
                  menuId: menuId,
                  ingredientId: Value(ingId),
                  label: Value(i['label'] as String?),
                  quantity: Value((i['quantity'] as num?)?.toDouble()),
                  unit: Value(i['unit'] as String?),
                  bought: Value(i['bought'] as bool),
                  atHome: Value(i['atHome'] as bool),
                  manual: Value(i['manual'] as bool),
                ),
              );
        }
      }

      final reviewed = data['lastReviewedWeek'] as String?;
      if (reviewed != null) {
        final cur = await repo.meta(Repository.metaLastReviewedWeek);
        if (cur == null || reviewed.compareTo(cur) > 0) {
          await repo.setMeta(Repository.metaLastReviewedWeek, reviewed);
        }
      }
    });
  }

  DateTime? _latest(DateTime? a, DateTime? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.isAfter(b) ? a : b;
  }

  HouseholdProfile _profileFromJson(Map<String, dynamic> p) => HouseholdProfile(
    people: p['people'] as int,
    diet: Diet.fromCode(p['diet'] as String),
    noPork: p['noPork'] as bool,
    exclusions: {
      for (final a in (p['exclusions'] as List)) Allergen.fromCode(a as String),
    },
    aversions: (p['aversions'] as List).cast<String>().toSet(),
    equipment: {
      for (final e in (p['equipment'] as List)) Equipment.fromCode(e as String),
    },
    activeSlots: {
      for (final s in (p['slots'] as List)) slotKeyFromCode(s as String),
    },
    maxMinWeekday: p['maxMinWeekday'] as int,
    maxMinWeekend: p['maxMinWeekend'] as int,
    weekStartDay: p['weekStartDay'] as int,
    favoriteShare: (p['favoriteShare'] as num).toDouble(),
    antiRepeatWeeks: p['antiRepeatWeeks'] as int,
    aisleOrder: [
      for (final a in (p['aisleOrder'] as List)) Aisle.fromCode(a as String),
    ],
    theme: ThemePreference.fromCode(p['theme'] as String),
  );

  Ingredient _ingredientFromJson(Map<String, dynamic> m) => Ingredient(
    id: m['id'] as String,
    name: m['name'] as String,
    aisle: Aisle.fromCode(m['aisle'] as String),
    defaultUnit: Unit.fromCode(m['defaultUnit'] as String),
    avgPieceWeightG: (m['avgPieceWeightG'] as num?)?.toDouble(),
    pantry: m['pantry'] as bool,
    perishable: m['perishable'] as bool,
    markers: {
      for (final c in (m['markers'] as List)) Marker.fromCode(c as String),
    },
    allergens: {
      for (final c in (m['allergens'] as List)) Allergen.fromCode(c as String),
    },
    seasonMonths: {for (final c in (m['seasonMonths'] as List)) c as int},
    origin: Origin.personal,
  );
}

String weekCode(DateTime d) => _dateCode(d);

/// Nom de photo sans chemin : refuse « ../ » et les séparateurs (zip slip).
bool isSafePhotoName(String name) =>
    RegExp(r'^[A-Za-z0-9_-][A-Za-z0-9._-]*$').hasMatch(name) &&
    !name.contains('..');
