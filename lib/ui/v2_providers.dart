import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/kitchen_repository.dart';
import '../data/product_catalog.dart';
import '../domain/balance.dart';
import '../domain/energy.dart';
import '../domain/food_log.dart';
import '../domain/stock.dart';
import '../domain/strength.dart';
import 'providers.dart';
import 'scanner.dart';

/// Base produits importée (null : aucune).
class ProductDb extends Notifier<ProductCatalog> {
  @override
  ProductCatalog build() {
    final file = ref.watch(productDbFileProvider);
    if (file == null) return const EmptyProductCatalog();
    return SqliteProductCatalog.open(file) ?? const EmptyProductCatalog();
  }

  void reload() => ref.invalidateSelf();
}

/// Emplacement du fichier de la base produits dans le dossier privé.
final productDbFileProvider = Provider<File?>((ref) => null);

final productDbProvider = NotifierProvider<ProductDb, ProductCatalog>(
  ProductDb.new,
);

final kitchenProvider = Provider<KitchenRepository>((ref) {
  final repo = ref.watch(repositoryProvider);
  return KitchenRepository(repo.db, repo, () => ref.read(productDbProvider));
});

final scannerProvider = Provider<BarcodeScannerService>(
  (ref) => const CameraBarcodeScanner(),
);

final exercisesProvider = FutureProvider<List<Exercise>>((ref) async {
  final raw = await rootBundle.loadString('assets/nutrition/exercises.json');
  return [
    for (final e
        in ((jsonDecode(raw) as Map)['exercises'] as List)
            .cast<Map<String, dynamic>>())
      Exercise(
        name: e['name'] as String,
        met: (e['met'] as num).toDouble(),
        kind: e['kind'] as String,
        muscleGroup: e['muscleGroup'] as String?,
      ),
  ];
});

final stockProvider = FutureProvider<List<StockLot>>((ref) {
  ref.watch(revisionProvider);
  return ref.watch(kitchenProvider).stock();
});

/// Repas faits de la semaine affichée, par clé de créneau ou d'extra.
final completionsProvider = FutureProvider<Map<String, MealCompletion>>((
  ref,
) async {
  ref.watch(revisionProvider);
  final menu = await ref.watch(menuProvider.future);
  if (menu.id == null) return const {};
  return ref.watch(kitchenProvider).completions(menu.id!);
});

/// Réservation du stock pour la semaine affichée (liste et indicateurs).
final stockPlanProvider = FutureProvider<(List<PlannedUse>, StockPlan)>((
  ref,
) async {
  ref.watch(revisionProvider);
  final menu = await ref.watch(menuProvider.future);
  final k = ref.watch(kitchenProvider);
  final uses = await k.plannedUses(menu);
  return (uses, planShoppingWithStock(uses, await k.stock()));
});

final packagesProvider = FutureProvider<Map<String, Product>>((ref) {
  ref.watch(revisionProvider);
  return ref.watch(kitchenProvider).packagesByIngredient();
});

/// Jour affiché dans l'onglet Nutrition.
class NutritionDay extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;
  void set(DateTime d) => state = DateTime(d.year, d.month, d.day);
}

final nutritionDaySelectionProvider = NotifierProvider<NutritionDay, DateTime?>(
  NutritionDay.new,
);

final nutritionDayProvider = Provider<DateTime>((ref) {
  final t = ref.watch(todayProvider);
  return ref.watch(nutritionDaySelectionProvider) ??
      DateTime(t.year, t.month, t.day);
});

final nutritionProfileProvider = FutureProvider<NutritionProfile?>((ref) {
  ref.watch(revisionProvider);
  return ref.watch(kitchenProvider).nutritionProfile();
});

final dayLogProvider = FutureProvider<List<FoodLogEntry>>((ref) {
  ref.watch(revisionProvider);
  final d = ref.watch(nutritionDayProvider);
  return ref.watch(kitchenProvider).logEntries(d, d);
});

/// Bilans sur [days] jours se terminant au jour affiché.
final summariesProvider =
    FutureProvider.family<List<(DateTime, DaySummary)>, int>((ref, days) {
      ref.watch(revisionProvider);
      final d = ref.watch(nutritionDayProvider);
      return ref.watch(kitchenProvider).summaries(d, days);
    });

final dayActivityProvider =
    FutureProvider<(List<Workout>, List<StrengthSession>, int?)>((ref) async {
      ref.watch(revisionProvider);
      final d = ref.watch(nutritionDayProvider);
      final k = ref.watch(kitchenProvider);
      final strength = await k.strengthSessions(d, d);
      return (await k.workouts(d, d), strength, (await k.steps(d, d))[d]);
    });

final goalsProvider = FutureProvider<List<Goal>>((ref) {
  ref.watch(revisionProvider);
  return ref.watch(kitchenProvider).goals();
});

final weightsProvider = FutureProvider<List<WeightPoint>>((ref) {
  ref.watch(revisionProvider);
  return ref.watch(kitchenProvider).weights();
});

final presetsProvider = FutureProvider<List<MealPreset>>((ref) {
  ref.watch(revisionProvider);
  return ref.watch(kitchenProvider).presets();
});

/// Écritures V2 + rafraîchissement.
class KitchenActions {
  KitchenActions(this.ref);
  final Ref ref;

  KitchenRepository get k => ref.read(kitchenProvider);

  Future<T> run<T>(Future<T> Function(KitchenRepository k) f) async {
    final out = await f(k);
    ref.read(actionsProvider).refresh();
    return out;
  }
}

final kitchenActionsProvider = Provider<KitchenActions>(KitchenActions.new);
