// Bilan du jour : apport − dépense, comparé à l'objectif
// (docs/INVENTAIRE_NUTRITION.md §3.7 à §3.9).

import 'energy.dart';
import 'nutrition.dart';
import 'strength.dart';

const maintenanceToleranceKcal = 50.0;
const kcalPerKgBodyMass = 7700.0;

enum BalanceStatus { deficit, surplus, maintenance }

class DailyBalance {
  const DailyBalance({
    required this.netKcal,
    required this.expenditureKcal,
    required this.status,
  });

  /// Positif = surplus, négatif = déficit.
  final double netKcal;
  final double expenditureKcal;
  final BalanceStatus status;
}

DailyBalance dailyBalance({
  required double intakeKcal,
  required double tdeeKcal,
  required double workoutKcal,
  double stepsKcal = 0,
}) {
  final expenditure = tdeeKcal + workoutKcal + stepsKcal;
  final net = intakeKcal - expenditure;
  final status = net.abs() <= maintenanceToleranceKcal
      ? BalanceStatus.maintenance
      : (net > 0 ? BalanceStatus.surplus : BalanceStatus.deficit);
  return DailyBalance(
    netKcal: net,
    expenditureKcal: expenditure,
    status: status,
  );
}

double deviationFromGoal(double netKcal, double dailyKcalDelta) =>
    netKcal - dailyKcalDelta;

double projectedWeightChangeKg(double cumulativeNetKcal) =>
    cumulativeNetKcal / kcalPerKgBodyMass;

/// Profil nutrition (une seule personne, SPEC-V2 §0).
class NutritionProfile {
  const NutritionProfile({
    required this.sex,
    required this.birthDate,
    required this.heightCm,
    this.activity = ActivityLevel.moderate,
  });

  final Sex sex;
  final DateTime birthDate;
  final double heightCm;
  final ActivityLevel activity;
}

class Goal {
  const Goal({
    this.id,
    required this.startDate,
    required this.kind,
    required this.dailyKcalDelta,
    this.targetWeightKg,
  });

  final int? id;
  final DateTime startDate;
  final GoalKind kind;
  final double dailyKcalDelta;
  final double? targetWeightKg;
}

class WeightPoint {
  const WeightPoint({
    this.id,
    required this.date,
    required this.weightKg,
    this.bodyFatPct,
  });

  final int? id;
  final DateTime date;
  final double weightKg;
  final double? bodyFatPct;
}

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

/// Pesée la plus récente antérieure ou égale à [day].
double? weightOnDay(Iterable<WeightPoint> points, DateTime day) {
  final d = _day(day);
  WeightPoint? best;
  for (final p in points) {
    if (_day(p.date).isAfter(d)) continue;
    if (best == null || p.date.isAfter(best.date)) best = p;
  }
  return best?.weightKg;
}

/// Objectif actif : le plus récent déjà commencé.
Goal? goalOnDay(Iterable<Goal> goals, DateTime day) {
  final d = _day(day);
  Goal? best;
  for (final g in goals) {
    if (_day(g.startDate).isAfter(d)) continue;
    if (best == null || !g.startDate.isBefore(best.startDate)) best = g;
  }
  return best;
}

class DaySummary {
  const DaySummary({
    required this.intake,
    required this.workoutKcal,
    required this.strengthKcal,
    required this.stepsKcal,
    required this.steps,
    required this.tdeeKcal,
    required this.balance,
    required this.goalDeviationKcal,
    this.weightKg,
  });

  final Macros intake;
  final double workoutKcal;
  final double strengthKcal;
  final double stepsKcal;
  final int? steps;
  final double? weightKg;

  /// Null tant que le profil ou le poids manque.
  final double? tdeeKcal;
  final DailyBalance? balance;
  final double? goalDeviationKcal;

  double get sessionKcal => workoutKcal + strengthKcal;
}

DaySummary summarizeDay({
  required DateTime day,
  required NutritionProfile? profile,
  required double? weightKg,
  required double? goalDailyKcalDelta,
  required Macros intake,
  List<Workout> workouts = const [],
  List<StrengthSession> strength = const [],
  int? steps,
}) {
  final burned = workouts.fold<double>(0, (t, w) => t + w.kcal(weightKg));
  final lifted = strength.fold<double>(
    0,
    (t, s) => t + estimateStrengthSession(s, weightKg).kcal,
  );
  final stepsKcal = (steps == null || weightKg == null)
      ? 0.0
      : stepsEnergy(
          steps: steps,
          weightKg: weightKg,
          heightCm: profile?.heightCm,
        );
  if (profile == null || weightKg == null) {
    return DaySummary(
      intake: intake,
      workoutKcal: burned,
      strengthKcal: lifted,
      stepsKcal: stepsKcal,
      steps: steps,
      weightKg: weightKg,
      tdeeKcal: null,
      balance: null,
      goalDeviationKcal: null,
    );
  }
  final bmr = basalMetabolicRate(
    sex: profile.sex,
    weightKg: weightKg,
    heightCm: profile.heightCm,
    ageYears: ageInYears(profile.birthDate, day),
  );
  final tdee = totalDailyEnergyExpenditure(bmr, profile.activity);
  final balance = dailyBalance(
    intakeKcal: intake.kcal,
    tdeeKcal: tdee,
    workoutKcal: burned + lifted,
    stepsKcal: stepsKcal,
  );
  return DaySummary(
    intake: intake,
    workoutKcal: burned,
    strengthKcal: lifted,
    stepsKcal: stepsKcal,
    steps: steps,
    weightKg: weightKg,
    tdeeKcal: tdee,
    balance: balance,
    goalDeviationKcal: goalDailyKcalDelta == null
        ? null
        : deviationFromGoal(balance.netKcal, goalDailyKcalDelta),
  );
}

/// Cumul de la période ; null dès qu'un jour n'est pas calculable.
double? cumulativeNetKcal(Iterable<DaySummary> days) {
  var total = 0.0;
  for (final d in days) {
    if (d.balance == null) return null;
    total += d.balance!.netKcal;
  }
  return total;
}
