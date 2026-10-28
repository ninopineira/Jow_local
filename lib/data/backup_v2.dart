import 'package:drift/drift.dart';

import 'database.dart';

/// Export/import des données V2 (SPEC-V2 §11) : stock, mouvements, repas
/// faits, journal, banque de repas, nutrition, sport, produits perso et
/// liens produit → ingrédient. La base produits Open Food Facts n'est pas
/// exportée (elle se réimporte).
///
/// Chaque ligne garde son identifiant : un réimport ne crée aucun doublon
/// (les lignes déjà présentes sont ignorées en fusion). Les repas faits sont
/// rattachés au menu par sa date et à la recette par sa référence d'export.
class V2Backup {
  V2Backup(this.db);

  final AppDatabase db;

  List<TableInfo<Table, dynamic>> get tables => [
    db.customProducts,
    db.productLinks,
    db.stockLots,
    db.stockMovements,
    db.mealCompletions,
    db.foodLogEntries,
    db.mealPresets,
    db.mealPresetItems,
    db.nutritionProfiles,
    db.nutritionGoals,
    db.bodyWeights,
    db.dailySteps,
    db.workouts,
    db.strengthSessions,
    db.strengthSets,
  ];

  /// [menuCode] : id de menu → date de début (code d'export) ;
  /// [recipeRef] : id de recette → référence d'export.
  Future<Map<String, dynamic>> export({
    required String? Function(int menuId)? Function() menuCode,
    required String? Function(int recipeId) recipeRef,
  }) async {
    final codeOf = menuCode();
    final out = <String, dynamic>{};
    for (final t in tables) {
      final rows = await db.select(t).get();
      out[t.actualTableName] = [
        for (final r in rows)
          {
            ...(r as DataClass).toJson(serializer: _serializer),
            if (t == db.mealCompletions) ...{
              'menuRef': codeOf?.call((r as MealCompletionRow).menuId),
              'recipeRef': recipeRef((r as MealCompletionRow).recipeId),
            },
            if (t == db.mealPresets && (r as MealPresetRow).recipeId != null)
              'recipeRef': recipeRef(r.recipeId!),
          },
      ];
    }
    return out;
  }

  /// Nombre de lignes par table, pour l'aperçu.
  static Map<String, int> counts(Map<String, dynamic>? data) => {
    for (final e in (data ?? const {}).entries) e.key: (e.value as List).length,
  };

  Future<void> clear() async {
    for (final t in tables.reversed) {
      await db.delete(t).go();
    }
  }

  Future<void> apply(
    Map<String, dynamic> data, {
    required int? Function(String? menuRef) menuId,
    required int? Function(String? recipeRef) recipeId,
  }) async {
    for (final t in tables) {
      final rows = (data[t.actualTableName] as List?) ?? const [];
      for (final raw in rows) {
        final m = Map<String, dynamic>.from(raw as Map);
        if (t == db.mealCompletions) {
          final menu = menuId(m.remove('menuRef') as String?);
          final recipe = recipeId(m.remove('recipeRef') as String?);
          if (menu == null || recipe == null) continue;
          m['menuId'] = menu;
          m['recipeId'] = recipe;
        }
        if (t == db.mealPresets) {
          final ref = m.remove('recipeRef') as String?;
          if (ref != null) m['recipeId'] = recipeId(ref);
        }
        final row = t.map(_toColumns(t, m)) as Insertable<dynamic>;
        await db.into(t).insert(row, mode: InsertMode.insertOrIgnore);
      }
    }
  }

  /// JSON d'export (noms Dart) → ligne SQL (noms de colonnes) pour `map`.
  Map<String, dynamic> _toColumns(
    TableInfo<Table, dynamic> t,
    Map<String, dynamic> json,
  ) {
    final out = <String, dynamic>{};
    for (final c in t.$columns) {
      final key = _camel(c.name);
      if (!json.containsKey(key)) continue;
      final v = json[key];
      out[c.name] = switch (v) {
        null => null,
        bool b => b ? 1 : 0,
        _ when c.type == DriftSqlType.dateTime =>
          DateTime.parse(v as String).millisecondsSinceEpoch ~/ 1000,
        _ => v,
      };
    }
    return out;
  }

  static String _camel(String snake) {
    final parts = snake.split('_');
    return parts.first +
        parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
  }
}

const _serializer = _IsoSerializer();

/// Dates en ISO 8601 dans l'export (lisible et stable).
class _IsoSerializer extends ValueSerializer {
  const _IsoSerializer();

  @override
  T fromJson<T>(dynamic json) =>
      const ValueSerializer.defaults().fromJson<T>(json);

  @override
  dynamic toJson<T>(T value) => value is DateTime
      ? value.toIso8601String()
      : const ValueSerializer.defaults().toJson<T>(value);
}
