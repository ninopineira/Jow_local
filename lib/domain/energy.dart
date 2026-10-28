// Dépense énergétique, reprise à l'identique de l'ancienne app de nutrition
// (docs/INVENTAIRE_NUTRITION.md §3.1 à §3.9). Aucun arrondi ici.

enum Sex {
  male('male'),
  female('female');

  const Sex(this.code);
  final String code;
  static Sex fromCode(String c) => values.firstWhere((v) => v.code == c);
}

/// Niveau d'activité **hors séances** (les séances s'ajoutent à part).
enum ActivityLevel {
  sedentary('sedentary', 1.2),
  light('light', 1.375),
  moderate('moderate', 1.55),
  active('active', 1.725),
  veryActive('very_active', 1.9);

  const ActivityLevel(this.code, this.factor);
  final String code;
  final double factor;
  static ActivityLevel fromCode(String c) =>
      values.firstWhere((v) => v.code == c);
}

/// Intensité d'une activité chronométrée : multiplie le MET « modéré ».
enum Intensity {
  light('light', 0.75),
  moderate('moderate', 1),
  vigorous('vigorous', 1.3);

  const Intensity(this.code, this.factor);
  final String code;
  final double factor;
  static Intensity fromCode(String c) => values.firstWhere((v) => v.code == c);
}

/// Objectif : type et écart quotidien visé de la balance.
enum GoalKind {
  bulk('bulk', 300),
  cut('cut', -400),
  maintain('maintain', 0);

  const GoalKind(this.code, this.defaultDelta);
  final String code;

  /// Écart par défaut (kcal/jour), environ 0,3 kg par semaine.
  final double defaultDelta;
  static GoalKind fromCode(String c) => values.firstWhere((v) => v.code == c);
}

/// Années pleines à [on].
int ageInYears(DateTime birth, DateTime on) {
  var age = on.year - birth.year;
  if (on.month < birth.month ||
      (on.month == birth.month && on.day < birth.day)) {
    age -= 1;
  }
  return age;
}

/// Métabolisme de base, Mifflin-St Jeor (kcal/jour).
double basalMetabolicRate({
  required Sex sex,
  required double weightKg,
  required double heightCm,
  required int ageYears,
}) {
  final base = 10 * weightKg + 6.25 * heightCm - 5 * ageYears;
  return sex == Sex.male ? base + 5 : base - 161;
}

/// Dépense quotidienne hors séances (kcal/jour).
double totalDailyEnergyExpenditure(double bmr, ActivityLevel level) =>
    bmr * level.factor;

/// Dépense brute d'une activité : MET × 3,5 × kg / 200 × minutes.
double workoutEnergy({
  required double met,
  required double weightKg,
  required double durationMin,
}) => met * 3.5 * weightKg / 200 * durationMin;

const strideToHeightRatio = 0.415;
const defaultStrideM = 0.72;
const walkingMet = 3.5;
const walkingSpeedKmh = 4.8;

double strideLengthM(double? heightCm) => (heightCm == null || heightCm <= 0)
    ? defaultStrideM
    : strideToHeightRatio * heightCm / 100;

/// Dépense des pas, **nette** du repos (MET − 1).
double stepsEnergy({
  required int steps,
  required double weightKg,
  double? heightCm,
}) {
  if (steps <= 0) return 0;
  final distanceKm = steps * strideLengthM(heightCm) / 1000;
  final durationMin = distanceKm / walkingSpeedKmh * 60;
  return (walkingMet - 1) * 3.5 * weightKg / 200 * durationMin;
}

double stepsDistanceKm(int steps, double? heightCm) =>
    steps * strideLengthM(heightCm) / 1000;

/// Activité chronométrée saisie.
class Workout {
  const Workout({
    this.id,
    required this.date,
    required this.exerciseName,
    required this.met,
    required this.durationMin,
    this.intensity = Intensity.moderate,
    this.kcalOverride,
    this.note,
  });

  final int? id;
  final DateTime date;
  final String exerciseName;

  /// MET de référence (effort modéré).
  final double met;
  final double durationMin;
  final Intensity intensity;

  /// Valeur saisie (montre), prioritaire sur l'estimation.
  final double? kcalOverride;
  final String? note;

  double get effectiveMet => met * intensity.factor;

  /// 0 si le poids est inconnu et qu'aucune valeur n'est saisie.
  double kcal(double? weightKg) {
    if (kcalOverride != null) return kcalOverride!;
    if (weightKg == null) return 0;
    return workoutEnergy(
      met: effectiveMet,
      weightKg: weightKg,
      durationMin: durationMin,
    );
  }
}

/// Type d'exercice du catalogue (asset `assets/nutrition/exercises.json`).
class Exercise {
  const Exercise({
    required this.name,
    required this.met,
    required this.kind,
    this.muscleGroup,
  });

  final String name;
  final double met;

  /// `cardio` (chronométré) ou `strength` (série par série).
  final String kind;
  final String? muscleGroup;

  bool get isStrength => kind == 'strength';
}

const muscleGroupLabels = {
  'chest': 'Pectoraux',
  'back': 'Dos',
  'legs': 'Jambes',
  'shoulders': 'Épaules',
  'arms': 'Bras',
  'core': 'Gainage',
  'full_body': 'Corps entier',
};
