// Exemples chiffrés de docs/INVENTAIRE_NUTRITION.md §3 : mêmes résultats que
// l'ancienne app de nutrition.
import 'package:flutter_test/flutter_test.dart';
import 'package:popote/domain/balance.dart';
import 'package:popote/domain/energy.dart';
import 'package:popote/domain/nutrition.dart';
import 'package:popote/domain/strength.dart';

void main() {
  final birth = DateTime(1996, 11, 15);
  final day = DateTime(2026, 10, 28);
  final profile = NutritionProfile(
    sex: Sex.male,
    birthDate: birth,
    heightCm: 180,
  );

  group('3.1 âge', () {
    test('anniversaire pas encore passé', () {
      expect(ageInYears(birth, day), 29);
      expect(ageInYears(birth, DateTime(2026, 11, 15)), 30);
    });
  });

  group('3.2-3.3 BMR et TDEE', () {
    test('homme', () {
      final bmr = basalMetabolicRate(
        sex: Sex.male,
        weightKg: 75,
        heightCm: 180,
        ageYears: 29,
      );
      expect(bmr, closeTo(1735, 1e-9));
      expect(
        totalDailyEnergyExpenditure(bmr, ActivityLevel.moderate),
        closeTo(2689.25, 1e-9),
      );
    });
    test('femme', () {
      final bmr = basalMetabolicRate(
        sex: Sex.female,
        weightKg: 60,
        heightCm: 165,
        ageYears: 28,
      );
      expect(bmr, closeTo(1330.25, 1e-9));
      expect(
        totalDailyEnergyExpenditure(bmr, ActivityLevel.light),
        closeTo(1829.09375, 1e-9),
      );
    });
  });

  group('3.4 activités (MET)', () {
    Workout run(Intensity i, [double? override]) => Workout(
      date: day,
      exerciseName: 'Course (10 km/h)',
      met: 9.8,
      durationMin: 30,
      intensity: i,
      kcalOverride: override,
    );
    test('modérée, intense, valeur saisie, poids inconnu', () {
      expect(run(Intensity.moderate).kcal(75), closeTo(385.875, 1e-9));
      expect(run(Intensity.vigorous).kcal(75), closeTo(501.6375, 1e-9));
      expect(run(Intensity.moderate, 420).kcal(75), 420);
      expect(run(Intensity.moderate).kcal(null), 0);
      expect(run(Intensity.light).effectiveMet, closeTo(7.35, 1e-9));
    });
  });

  group('3.5 musculation', () {
    test('séance chronométrée', () {
      final s = StrengthSession(
        date: day,
        durationMin: 45,
        sets: const [StrengthSet(exercise: 'Squat', reps: 50, weightKg: 100)],
      );
      final e = estimateStrengthSession(s, 75);
      expect(e.volumeKg, 5000);
      expect(e.met, closeTo(4.412698, 1e-6));
      expect(e.kcal, closeTo(260.625, 1e-6));
    });
    test('durée déduite et MET plafonné', () {
      final s = StrengthSession(
        date: day,
        sets: [
          for (var i = 0; i < 4; i++)
            const StrengthSet(
              exercise: 'Squat',
              reps: 8,
              weightKg: 100,
              restSec: 120,
            ),
        ],
      );
      final e = estimateStrengthSession(s, 75);
      expect(e.volumeKg, 3200);
      expect(e.durationMin, closeTo(9.6, 1e-9));
      expect(e.met, 6.0);
      expect(e.kcal, closeTo(75.6, 1e-9));
    });
    test('poids du corps', () {
      final s = StrengthSession(
        date: day,
        sets: [
          for (var i = 0; i < 3; i++)
            const StrengthSet(exercise: 'Tractions', reps: 10, weightKg: 0),
        ],
      );
      final e = estimateStrengthSession(s, 75);
      expect(e.volumeKg, closeTo(1462.5, 1e-9));
      expect(e.durationMin, closeTo(6, 1e-9));
      expect(e.kcal, closeTo(47.25, 1e-9));
      expect(estimateStrengthSession(s, null).kcal, 0);
    });
    test('séance peu dense : MET plancher', () {
      final s = StrengthSession(
        date: day,
        durationMin: 60,
        sets: const [StrengthSet(exercise: 'Curl', reps: 100, weightKg: 20)],
      );
      expect(estimateStrengthSession(s, 75).kcal, closeTo(275.625, 1e-9));
    });
    test('1RM Epley et meilleure série', () {
      expect(estimatedOneRepMax(100, 8), closeTo(126.6667, 1e-4));
      expect(estimatedOneRepMax(100, 1), 100);
      expect(estimatedOneRepMax(0, 5), 0);
      final best = bestSet(const [
        StrengthSet(exercise: 'DC', reps: 8, weightKg: 100),
        StrengthSet(exercise: 'DC', reps: 3, weightKg: 110),
      ]);
      expect(best!.weightKg, 100);
    });
  });

  group('3.6 pas', () {
    test('avec et sans taille', () {
      expect(
        stepsEnergy(steps: 10000, weightKg: 75, heightCm: 180),
        closeTo(306.38671875, 1e-9),
      );
      expect(stepsEnergy(steps: 8000, weightKg: 75), closeTo(236.25, 1e-9));
      expect(stepsEnergy(steps: 0, weightKg: 75), 0);
    });
  });

  group('3.7-3.9 bilan, objectif, projection', () {
    test('exemple du jour', () {
      final s = summarizeDay(
        day: day,
        profile: profile,
        weightKg: 75,
        goalDailyKcalDelta: GoalKind.cut.defaultDelta,
        intake: const Macros(kcal: 2500),
        workouts: [
          Workout(date: day, exerciseName: 'Course', met: 9.8, durationMin: 30),
        ],
        steps: 10000,
      );
      expect(s.tdeeKcal, closeTo(2689.25, 1e-9));
      expect(s.balance!.expenditureKcal, closeTo(3381.51171875, 1e-6));
      expect(s.balance!.netKcal, closeTo(-881.51171875, 1e-6));
      expect(s.balance!.status, BalanceStatus.deficit);
      expect(s.goalDeviationKcal, closeTo(-481.51171875, 1e-6));
      expect(
        projectedWeightChangeKg(7 * s.balance!.netKcal),
        closeTo(-0.8014, 1e-4),
      );
    });
    test('maintien à ±50 et bilan impossible sans poids', () {
      expect(
        dailyBalance(intakeKcal: 2040, tdeeKcal: 2000, workoutKcal: 0).status,
        BalanceStatus.maintenance,
      );
      final s = summarizeDay(
        day: day,
        profile: profile,
        weightKg: null,
        goalDailyKcalDelta: null,
        intake: const Macros(kcal: 2000),
      );
      expect(s.balance, isNull);
      expect(cumulativeNetKcal([s]), isNull);
    });
    test('poids du jour et objectif actif', () {
      final points = [
        WeightPoint(date: DateTime(2026, 10, 1), weightKg: 76),
        WeightPoint(date: DateTime(2026, 10, 20), weightKg: 75),
        WeightPoint(date: DateTime(2026, 11, 1), weightKg: 74),
      ];
      expect(weightOnDay(points, day), 75);
      expect(weightOnDay(points, DateTime(2026, 9, 1)), isNull);
      final goals = [
        Goal(
          startDate: DateTime(2026, 1, 1),
          kind: GoalKind.bulk,
          dailyKcalDelta: 300,
        ),
        Goal(
          startDate: DateTime(2026, 10, 1),
          kind: GoalKind.cut,
          dailyKcalDelta: -400,
        ),
      ];
      expect(goalOnDay(goals, day)!.kind, GoalKind.cut);
    });
  });

  group('3.10 fourchettes : règle prudente', () {
    const n = Nutrients(
      kcal: 285,
      protein: 10,
      proteinMin: 8,
      proteinMax: 12,
      carbs: 50,
      carbsMin: 45,
      carbsMax: 55,
      fat: 5,
      fatMin: 4,
      fatMax: 6,
    );
    test('glucides et lipides hauts, protéines basses, énergie décalée', () {
      final r = n.resolved();
      expect(r.protein, 8);
      expect(r.carbs, 55);
      expect(r.fat, 6);
      expect(r.kcal, closeTo(306, 1e-9));
      final p = n.forGrams(150);
      expect(p.kcal, closeTo(459, 1e-9));
      expect(p.protein, closeTo(12, 1e-9));
      expect(p.carbs, closeTo(82.5, 1e-9));
      expect(p.fat, closeTo(9, 1e-9));
    });
    test('borne kcal max prioritaire ; sans fourchette inchangé', () {
      const k = Nutrients(
        kcal: 100,
        kcalMax: 120,
        protein: 1,
        carbs: 1,
        fat: 1,
      );
      expect(k.resolved().kcal, 120);
      const plain = Nutrients(kcal: 100, protein: 1, carbs: 2, fat: 3);
      expect(identical(plain.resolved(), plain), isTrue);
    });
    test('cohérence 4/4/9', () {
      const bad = Nutrients(kcal: 100, protein: 10, carbs: 20, fat: 5);
      expect(bad.isEnergyInconsistent(), isTrue);
      const ok = Nutrients(kcal: 165, protein: 10, carbs: 20, fat: 5);
      expect(ok.isEnergyInconsistent(), isFalse);
    });
  });
}
