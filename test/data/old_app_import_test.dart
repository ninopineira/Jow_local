// Import de l'ancienne app (SPEC-V2 §10) sur un exemple au format
// docs/EXPORT_FORMAT.md : aperçu, import, réimport sans doublon.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/old_app_import.dart';
import 'package:popote/domain/energy.dart';
import 'package:popote/domain/food_log.dart';

import 'v2_data_test.dart' show setup;

final example = {
  'format': 'app-nutrition-export',
  'version': 1,
  'exportedAt': '2026-10-28T09:00:00',
  'profile': {
    'sex': 'male',
    'birthDate': '1996-11-15',
    'heightCm': 180,
    'activityLevel': 'moderate',
  },
  'goals': [
    {
      'startDate': '2026-09-01',
      'kind': 'cut',
      'dailyKcalDelta': -400,
      'targetWeightKg': null,
    },
  ],
  'foods': [
    {
      'id': 12,
      'barcode': '3250390000001',
      'name': 'Spaghetti',
      'brand': 'Marque X',
      'kcalPer100g': 357,
      'proteinPer100g': 12.5,
      'carbsPer100g': 71,
      'fatPer100g': 1.5,
      'source': 'off',
    },
    {
      'id': 13,
      'barcode': null,
      'name': 'Barre',
      'kcalPer100g': 285,
      'proteinPer100g': 10,
      'proteinMinPer100g': 8,
      'carbsPer100g': 50,
      'carbsMaxPer100g': 55,
      'fatPer100g': 5,
      'fatMaxPer100g': 6,
      'source': 'manual',
    },
  ],
  'meals': [
    {
      'id': 40,
      'date': '2026-10-27',
      'slot': 'lunch',
      'note': null,
      'items': [
        {'foodId': 12, 'quantityG': 120},
        {'foodId': 13, 'quantityG': 150},
      ],
    },
  ],
  'mealPresets': [
    {
      'name': 'Petit-déj classique',
      'defaultSlot': 'breakfast',
      'items': [
        {'foodId': 13, 'quantityG': 60},
      ],
    },
  ],
  'dailySteps': [
    {'date': '2026-10-27', 'steps': 9500},
  ],
  'workouts': [
    {
      'date': '2026-10-27',
      'exerciseName': 'Course (10 km/h)',
      'met': 9.8,
      'durationMin': 30,
      'intensity': 'moderate',
      'kcalOverride': null,
      'note': null,
    },
  ],
  'strengthSessions': [
    {
      'date': '2026-10-26',
      'name': 'Jambes',
      'durationMin': null,
      'kcalOverride': null,
      'note': null,
      'sets': [
        {
          'exerciseName': 'Squat',
          'setIndex': 1,
          'reps': 8,
          'weightKg': 100,
          'restSec': 120,
        },
      ],
    },
  ],
  'bodyMetrics': [
    {'date': '2026-10-20', 'weightKg': 75, 'bodyFatPct': null},
  ],
};

void main() {
  test('aperçu, import puis réimport sans doublon', () async {
    final (_, k) = await setup();
    final imp = OldAppImport(k);
    final data = imp.parse(utf8.encode(jsonEncode(example)));
    final p1 = await imp.preview(data);
    expect(p1.total['meals'], 2);
    expect(p1.fresh['meals'], 2);
    expect(p1.fresh['profile'], 1);
    await imp.apply(data);

    final day = DateTime(2026, 10, 27);
    final log = await k.logEntries(day, day);
    expect(log.length, 2);
    expect(log.every((e) => e.moment == Moment.lunch), isTrue);
    // 120 g de spaghetti : 428,4 kcal ; 150 g de barre lue au pire : 459 kcal.
    expect(log[0].macros.kcal, closeTo(428.4, 1e-6));
    expect(log[1].macros.kcal, closeTo(459, 1e-6));
    expect((await k.nutritionProfile())!.sex, Sex.male);
    expect((await k.product('3250390000001'))!.custom, isTrue);
    expect((await k.presets()).single.items.single.grams, 60);
    expect((await k.steps(day, day))[day], 9500);
    final s = (await k.summaries(day, 1)).single.$2;
    expect(s.workoutKcal, closeTo(385.875, 1e-9));
    expect(s.weightKg, 75);

    // Réimport : rien de nouveau, aucun doublon.
    final p2 = await imp.preview(data);
    expect(p2.fresh.values.every((v) => v == 0), isTrue);
    await imp.apply(data);
    expect((await k.logEntries(day, day)).length, 2);
    expect((await k.workouts(day, day)).length, 1);
    expect((await k.weights()).length, 1);
    expect((await k.goals()).length, 1);
    expect((await k.presets()).length, 1);
    expect((await k.strengthSessions(DateTime(2026, 10, 26), day)).length, 1);
  });

  test('fichier d\'un autre format refusé', () async {
    final (_, k) = await setup();
    expect(
      () => OldAppImport(k).parse(utf8.encode('{"format":"autre"}')),
      throwsFormatException,
    );
  });

  test('données mal formées : erreur et rien d’importé', () async {
    final (_, k) = await setup();
    final imp = OldAppImport(k);
    final bad = Map<String, dynamic>.from(example)
      ..['bodyMetrics'] = [
        {'date': '2026-10-20', 'weightKg': 75},
        {'date': '2026-10-21', 'weightKg': 'lourd'},
      ];
    final data = imp.parse(utf8.encode(jsonEncode(bad)));
    await expectLater(imp.apply(data), throwsA(isA<TypeError>()));
    expect(await k.weights(), isEmpty);
    expect(await k.nutritionProfile(), isNull);
  });
}
