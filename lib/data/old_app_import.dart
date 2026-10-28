import 'dart:convert';

import '../domain/balance.dart';
import '../domain/energy.dart';
import '../domain/food_log.dart';
import '../domain/nutrition.dart';
import '../domain/stock.dart';
import '../domain/strength.dart';
import 'kitchen_repository.dart';

/// Import des données de l'ancienne app de nutrition (SPEC-V2 §10), au
/// format décrit dans `docs/EXPORT_FORMAT.md`.
const oldAppFormat = 'app-nutrition-export';
const oldAppVersion = 1;

/// Aperçu avant confirmation : éléments du fichier et éléments nouveaux.
class OldAppPreview {
  const OldAppPreview(this.data, this.total, this.fresh);

  final Map<String, dynamic> data;

  /// Par catégorie : nombre d'éléments dans le fichier.
  final Map<String, int> total;

  /// Par catégorie : nombre d'éléments qui seraient ajoutés.
  final Map<String, int> fresh;
}

DateTime _date(Object? s) => DateTime.parse(s as String);
double? _d(Object? v) => (v as num?)?.toDouble();
DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

Nutrients _food(Map<String, dynamic> f) => Nutrients(
  kcal: _d(f['kcalPer100g']) ?? 0,
  protein: _d(f['proteinPer100g']) ?? 0,
  carbs: _d(f['carbsPer100g']) ?? 0,
  fat: _d(f['fatPer100g']) ?? 0,
  kcalMin: _d(f['kcalMinPer100g']),
  kcalMax: _d(f['kcalMaxPer100g']),
  proteinMin: _d(f['proteinMinPer100g']),
  proteinMax: _d(f['proteinMaxPer100g']),
  carbsMin: _d(f['carbsMinPer100g']),
  carbsMax: _d(f['carbsMaxPer100g']),
  fatMin: _d(f['fatMinPer100g']),
  fatMax: _d(f['fatMaxPer100g']),
);

class OldAppImport {
  OldAppImport(this.k);

  final KitchenRepository k;

  /// Lit le fichier ; [FormatException] s'il n'est pas au bon format.
  Map<String, dynamic> parse(List<int> bytes) {
    final data = jsonDecode(utf8.decode(bytes));
    if (data is! Map<String, dynamic> || data['format'] != oldAppFormat) {
      throw const FormatException(
        'Ce fichier n’est pas un export de l’ancienne app.',
      );
    }
    if ((data['version'] as int? ?? 0) > oldAppVersion) {
      throw const FormatException('Export d’une version plus récente.');
    }
    return data;
  }

  List<Map<String, dynamic>> _list(Map<String, dynamic> d, String key) =>
      ((d[key] as List?) ?? const []).cast<Map<String, dynamic>>();

  /// Clés déjà présentes dans Popote, pour l'idempotence.
  Future<_Existing> _existing() async {
    final far = DateTime(1900), end = DateTime(2200);
    return _Existing(
      logRefs: {
        for (final e in await k.logEntries(far, end))
          if (e.ref != null) e.ref!,
      },
      workouts: {
        for (final w in await k.workouts(far, end))
          '${_day(w.date)}|${w.exerciseName}|${w.durationMin}',
      },
      strength: {
        for (final s in await k.strengthSessions(far, end))
          '${_day(s.date)}|${s.name}|${s.sets.length}',
      },
      weights: {
        for (final w in await k.weights()) '${_day(w.date)}|${w.weightKg}',
      },
      goals: {
        for (final g in await k.goals()) '${_day(g.startDate)}|${g.kind.code}',
      },
      presets: {for (final p in await k.presets()) p.name},
      hasProfile: await k.nutritionProfile() != null,
    );
  }

  static String _mealRef(Object? id, int i) => 'oldapp:meal:$id:$i';

  Future<OldAppPreview> preview(Map<String, dynamic> d) async {
    final ex = await _existing();
    final meals = _list(d, 'meals');
    var mealLines = 0, freshLines = 0;
    for (final m in meals) {
      final items = ((m['items'] as List?) ?? const []);
      for (var i = 0; i < items.length; i++) {
        mealLines++;
        if (!ex.logRefs.contains(_mealRef(m['id'], i))) freshLines++;
      }
    }
    int count(String key, bool Function(Map<String, dynamic>) isNew) =>
        _list(d, key).where(isNew).length;
    return OldAppPreview(
      d,
      {
        'profile': d['profile'] == null ? 0 : 1,
        'goals': _list(d, 'goals').length,
        'foods': _list(d, 'foods').length,
        'meals': mealLines,
        'mealPresets': _list(d, 'mealPresets').length,
        'dailySteps': _list(d, 'dailySteps').length,
        'workouts': _list(d, 'workouts').length,
        'strengthSessions': _list(d, 'strengthSessions').length,
        'bodyMetrics': _list(d, 'bodyMetrics').length,
      },
      {
        'profile': d['profile'] != null && !ex.hasProfile ? 1 : 0,
        'goals': count(
          'goals',
          (g) => !ex.goals.contains('${_date(g['startDate'])}|${g['kind']}'),
        ),
        'meals': freshLines,
        'mealPresets': count(
          'mealPresets',
          (p) => !ex.presets.contains(p['name']),
        ),
        'workouts': count(
          'workouts',
          (w) => !ex.workouts.contains(
            '${_date(w['date'])}|${w['exerciseName']}|${_d(w['durationMin'])}',
          ),
        ),
        'strengthSessions': count(
          'strengthSessions',
          (s) => !ex.strength.contains(
            '${_date(s['date'])}|${s['name']}|${(s['sets'] as List).length}',
          ),
        ),
        'bodyMetrics': count(
          'bodyMetrics',
          (w) =>
              !ex.weights.contains('${_date(w['date'])}|${_d(w['weightKg'])}'),
        ),
      },
    );
  }

  /// Applique l'import (après confirmation). Idempotent.
  Future<void> apply(Map<String, dynamic> d) => k.db.transaction(() async {
    final ex = await _existing();
    final foods = {for (final f in _list(d, 'foods')) f['id']: f};

    final p = d['profile'] as Map<String, dynamic>?;
    if (p != null && !ex.hasProfile) {
      await k.saveNutritionProfile(
        NutritionProfile(
          sex: Sex.fromCode(p['sex'] as String),
          birthDate: _date(p['birthDate']),
          heightCm: _d(p['heightCm'])!,
          activity: ActivityLevel.fromCode(p['activityLevel'] as String),
        ),
      );
    }
    for (final g in _list(d, 'goals')) {
      final start = _date(g['startDate']);
      if (ex.goals.contains('$start|${g['kind']}')) continue;
      await k.addGoal(
        Goal(
          startDate: start,
          kind: GoalKind.fromCode(g['kind'] as String),
          dailyKcalDelta: _d(g['dailyKcalDelta'])!,
          targetWeightKg: _d(g['targetWeightKg']),
        ),
      );
    }
    for (final f in foods.values) {
      final code = f['barcode'] as String?;
      if (code == null || code.isEmpty) continue;
      final existing = await k.product(code);
      if (existing?.custom ?? false) continue;
      await k.saveCustomProduct(
        Product(
          barcode: code,
          name: f['name'] as String,
          brand: f['brand'] as String?,
          packageUnit: StockUnit.g,
          nutrients: _food(f),
          custom: true,
        ),
      );
    }
    for (final m in _list(d, 'meals')) {
      final items = ((m['items'] as List?) ?? const []).cast<Map>();
      for (var i = 0; i < items.length; i++) {
        final ref = _mealRef(m['id'], i);
        if (ex.logRefs.contains(ref)) continue;
        final f = foods[items[i]['foodId']];
        final g = _d(items[i]['quantityG']) ?? 0;
        await k.addLogEntry(
          FoodLogEntry(
            date: _date(m['date']),
            moment: Moment.fromCode(m['slot'] as String),
            label: f?['name'] as String? ?? '?',
            source: LogSource.free,
            ref: ref,
            grams: g,
            macros: f == null ? Macros.zero : _food(f).forGrams(g),
          ),
        );
      }
    }
    for (final pr in _list(d, 'mealPresets')) {
      if (ex.presets.contains(pr['name'])) continue;
      await k.savePreset(
        MealPreset(
          name: pr['name'] as String,
          defaultMoment: pr['defaultSlot'] == null
              ? null
              : Moment.fromCode(pr['defaultSlot'] as String),
          items: [
            for (final it in ((pr['items'] as List?) ?? const []).cast<Map>())
              if (foods[it['foodId']] != null)
                PresetItem(
                  label: foods[it['foodId']]!['name'] as String,
                  grams: _d(it['quantityG']) ?? 0,
                  nutrients: _food(foods[it['foodId']]!),
                  barcode: foods[it['foodId']]!['barcode'] as String?,
                ),
          ],
        ),
      );
    }
    for (final s in _list(d, 'dailySteps')) {
      await k.setSteps(_date(s['date']), s['steps'] as int);
    }
    for (final w in _list(d, 'workouts')) {
      final key =
          '${_date(w['date'])}|${w['exerciseName']}|${_d(w['durationMin'])}';
      if (ex.workouts.contains(key)) continue;
      await k.addWorkout(
        Workout(
          date: _date(w['date']),
          exerciseName: w['exerciseName'] as String,
          met: _d(w['met'])!,
          durationMin: _d(w['durationMin'])!,
          intensity: Intensity.fromCode(
            w['intensity'] as String? ?? 'moderate',
          ),
          kcalOverride: _d(w['kcalOverride']),
          note: w['note'] as String?,
        ),
      );
    }
    for (final s in _list(d, 'strengthSessions')) {
      final sets = ((s['sets'] as List?) ?? const []).cast<Map>();
      final key = '${_date(s['date'])}|${s['name']}|${sets.length}';
      if (ex.strength.contains(key)) continue;
      await k.addStrengthSession(
        StrengthSession(
          date: _date(s['date']),
          name: s['name'] as String?,
          durationMin: _d(s['durationMin']),
          kcalOverride: _d(s['kcalOverride']),
          note: s['note'] as String?,
          sets: [
            for (final x in sets)
              StrengthSet(
                exercise: x['exerciseName'] as String,
                setIndex: x['setIndex'] as int? ?? 1,
                reps: x['reps'] as int,
                weightKg: _d(x['weightKg']) ?? 0,
                restSec: x['restSec'] as int?,
              ),
          ],
        ),
      );
    }
    for (final w in _list(d, 'bodyMetrics')) {
      final key = '${_date(w['date'])}|${_d(w['weightKg'])}';
      if (ex.weights.contains(key)) continue;
      await k.addWeight(
        WeightPoint(
          date: _date(w['date']),
          weightKg: _d(w['weightKg'])!,
          bodyFatPct: _d(w['bodyFatPct']),
        ),
      );
    }
  });
}

class _Existing {
  _Existing({
    required this.logRefs,
    required this.workouts,
    required this.strength,
    required this.weights,
    required this.goals,
    required this.presets,
    required this.hasProfile,
  });

  final Set<String> logRefs;
  final Set<String> workouts;
  final Set<String> strength;
  final Set<String> weights;
  final Set<String> goals;
  final Set<String> presets;
  final bool hasProfile;
}
