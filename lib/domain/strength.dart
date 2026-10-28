// Musculation, reprise à l'identique (docs/INVENTAIRE_NUTRITION.md §3.5) :
// volume → densité → MET interpolé de 3,5 à 6,0 → kcal.

import 'energy.dart';

const bodyweightLoadFraction = 0.65;
const secondsPerRep = 3;
const defaultRestSec = 90;
const lightDensityKgPerMin = 60.0;
const vigorousDensityKgPerMin = 200.0;
const lightStrengthMet = 3.5;
const vigorousStrengthMet = 6.0;

class StrengthSet {
  const StrengthSet({
    this.id,
    required this.exercise,
    this.setIndex = 1,
    required this.reps,
    required this.weightKg,
    this.restSec,
  });

  final int? id;
  final String exercise;
  final int setIndex;
  final int reps;

  /// 0 = poids du corps.
  final double weightKg;
  final int? restSec;
}

class StrengthSession {
  const StrengthSession({
    this.id,
    required this.date,
    this.name,
    this.durationMin,
    this.kcalOverride,
    this.note,
    this.sets = const [],
  });

  final int? id;
  final DateTime date;
  final String? name;

  /// Null : déduite des séries.
  final double? durationMin;
  final double? kcalOverride;
  final String? note;
  final List<StrengthSet> sets;
}

double setLoadKg(StrengthSet s, double? bodyWeightKg) {
  if (s.weightKg > 0) return s.weightKg;
  return bodyWeightKg == null ? 0 : bodyWeightKg * bodyweightLoadFraction;
}

double volumeLoadKg(List<StrengthSet> sets, double? bodyWeightKg) =>
    sets.fold(0, (t, s) => t + s.reps * setLoadKg(s, bodyWeightKg));

int totalReps(List<StrengthSet> sets) => sets.fold(0, (t, s) => t + s.reps);

double estimatedDurationMin(List<StrengthSet> sets) =>
    sets.fold<double>(
      0,
      (t, s) => t + s.reps * secondsPerRep + (s.restSec ?? defaultRestSec),
    ) /
    60;

double sessionDurationMin(List<StrengthSet> sets, double? logged) =>
    (logged != null && logged > 0) ? logged : estimatedDurationMin(sets);

double sessionMet(double volumeKg, double durationMin) {
  if (durationMin <= 0) return lightStrengthMet;
  final density = volumeKg / durationMin;
  final ratio =
      (density - lightDensityKgPerMin) /
      (vigorousDensityKgPerMin - lightDensityKgPerMin);
  final clamped = ratio.clamp(0.0, 1.0);
  return lightStrengthMet + clamped * (vigorousStrengthMet - lightStrengthMet);
}

class StrengthEstimate {
  const StrengthEstimate({
    required this.volumeKg,
    required this.durationMin,
    required this.met,
    required this.kcal,
    required this.setCount,
    required this.repCount,
  });

  final double volumeKg;
  final double durationMin;
  final double met;
  final double kcal;
  final int setCount;
  final int repCount;
}

/// 0 kcal si le poids de corps est inconnu et qu'aucune valeur n'est saisie.
StrengthEstimate estimateStrengthSession(
  StrengthSession s,
  double? bodyWeightKg,
) {
  final volume = volumeLoadKg(s.sets, bodyWeightKg);
  final duration = sessionDurationMin(s.sets, s.durationMin);
  final met = sessionMet(volume, duration);
  final kcal =
      s.kcalOverride ??
      (bodyWeightKg == null
          ? 0.0
          : workoutEnergy(
              met: met,
              weightKg: bodyWeightKg,
              durationMin: duration,
            ));
  return StrengthEstimate(
    volumeKg: volume,
    durationMin: duration,
    met: met,
    kcal: kcal,
    setCount: s.sets.length,
    repCount: totalReps(s.sets),
  );
}

/// 1RM estimé, formule d'Epley.
double estimatedOneRepMax(double weightKg, int reps) {
  if (reps <= 0 || weightKg <= 0) return 0;
  if (reps == 1) return weightKg;
  return weightKg * (1 + reps / 30);
}

/// Meilleure série, jugée sur le 1RM estimé.
StrengthSet? bestSet(Iterable<StrengthSet> sets) {
  StrengthSet? best;
  var bestScore = -1.0;
  for (final s in sets) {
    final score = estimatedOneRepMax(s.weightKg, s.reps);
    if (score > bestScore) {
      bestScore = score;
      best = s;
    }
  }
  return best;
}
