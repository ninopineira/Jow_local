import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/backup.dart';
import '../data/repository.dart';
import '../domain/diet.dart';
import '../domain/enums.dart';
import '../domain/generator.dart';
import '../domain/models.dart';
import '../domain/stock.dart';
import 'platform.dart';
import 'v2_providers.dart';

/// Fournis par `main.dart` (ou les tests) via des overrides.
final repositoryProvider = Provider<Repository>(
  (ref) => throw UnimplementedError('repositoryProvider non fourni'),
);
final photoStoreProvider = Provider<FilePhotoStore>(
  (ref) => throw UnimplementedError('photoStoreProvider non fourni'),
);
final platformProvider = Provider<PlatformBridge>(
  (ref) => ChannelPlatformBridge(),
);

/// Date du jour, remplaçable dans les tests.
final todayProvider = Provider<DateTime>((ref) => DateTime.now());

/// Incrémenté après chaque écriture : les lectures se recalculent.
class Revision extends Notifier<int> {
  @override
  int build() => 0;
  void bump() => state++;
}

final revisionProvider = NotifierProvider<Revision, int>(Revision.new);

final onboardedProvider = FutureProvider<bool>((ref) {
  ref.watch(revisionProvider);
  return ref.watch(repositoryProvider).isOnboarded();
});

final profileProvider = FutureProvider<HouseholdProfile>((ref) {
  ref.watch(revisionProvider);
  return ref.watch(repositoryProvider).profile();
});

class Catalog {
  Catalog(this.recipes, this.states, this.ingredients)
    : byId = {for (final r in recipes) r.id: r},
      traits = {for (final r in recipes) r.id: traitsOf(r)};

  final List<Recipe> recipes;
  final Map<int, RecipeUserState> states;
  final List<Ingredient> ingredients;
  final Map<int, Recipe> byId;
  final Map<int, RecipeTraits> traits;

  RecipeUserState stateOf(int id) => states[id] ?? RecipeUserState.none;
}

final catalogProvider = FutureProvider<Catalog>((ref) async {
  ref.watch(revisionProvider);
  final repo = ref.watch(repositoryProvider);
  return Catalog(
    await repo.recipes(),
    await repo.userStates(),
    await repo.ingredients(),
  );
});

/// Semaine affichée (Menu et Liste).
class SelectedWeek extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;
  void set(DateTime d) => state = d;
  void clear() => state = null;
}

final selectedWeekProvider = NotifierProvider<SelectedWeek, DateTime?>(
  SelectedWeek.new,
);

final weekStartProvider = FutureProvider<DateTime>((ref) async {
  final selected = ref.watch(selectedWeekProvider);
  if (selected != null) return selected;
  final p = await ref.watch(profileProvider.future);
  return weekStartOf(ref.watch(todayProvider), p.weekStartDay);
});

/// Menu de la semaine affichée ; créneaux actifs complétés à vide.
final menuProvider = FutureProvider<WeekMenu>((ref) async {
  ref.watch(revisionProvider);
  final start = await ref.watch(weekStartProvider.future);
  final p = await ref.watch(profileProvider.future);
  final stored = await ref.watch(repositoryProvider).menuFor(start);
  final menu = stored ?? WeekMenu(startDate: start);
  return withActiveSlots(menu, p);
});

WeekMenu withActiveSlots(WeekMenu m, HouseholdProfile p) {
  var out = m;
  for (final k in p.activeSlots) {
    if (out.slotAt(k) == null) {
      out = out.withSlot(MenuSlot(key: k, servings: p.people));
    }
  }
  return out;
}

/// Écritures + rafraîchissement.
class AppActions {
  AppActions(this.ref);

  final Ref ref;

  Repository get repo => ref.read(repositoryProvider);
  void _bump() => ref.read(revisionProvider.notifier).bump();

  Future<void> saveProfile(HouseholdProfile p) async {
    await repo.saveProfile(p);
    _bump();
  }

  Future<void> updateState(
    int recipeId,
    RecipeUserState Function(RecipeUserState) f,
  ) async {
    await repo.updateUserState(recipeId, f);
    _bump();
  }

  Future<WeekMenu> saveMenu(WeekMenu m) async {
    final saved = await repo.saveMenu(m);
    _bump();
    return saved;
  }

  /// Génère le menu de la semaine affichée.
  Future<GeneratorResult> generate(WeekMenu menu) async {
    final p = await ref.read(profileProvider.future);
    final catalog = await ref.read(catalogProvider.future);
    final recent = await repo.recentRecipeIds(
      menu.startDate,
      p.antiRepeatWeeks,
    );
    final seed = Random().nextInt(1 << 31);
    // V2 : bonus pour les recettes qui utilisent le stock (SPEC-V2 §8).
    final kitchen = ref.read(kitchenProvider);
    final lots = await kitchen.stock();
    final today = ref.read(todayProvider);
    final result = generateMenu(
      GeneratorInput(
        recipes: catalog.recipes,
        states: catalog.states,
        profile: p,
        weekStart: menu.startDate,
        slots: menu.slots,
        recentRecipeIds: recent,
        seed: seed,
        stockAffinity: {
          for (final r in catalog.recipes) r.id: stockAffinity(r, lots, today),
        },
        stockWeight: await kitchen.stockWeight(),
      ),
    );
    final kept = menu.slots.where(
      (s) => !result.slots.any((r) => r.key == s.key),
    );
    await saveMenu(
      menu.copyWith(seed: seed, slots: [...result.slots, ...kept]),
    );
    return result;
  }

  Future<List<Recipe>> alternatives(WeekMenu menu, SlotKey key) async {
    final p = await ref.read(profileProvider.future);
    final catalog = await ref.read(catalogProvider.future);
    final recent = await repo.recentRecipeIds(
      menu.startDate,
      p.antiRepeatWeeks,
    );
    return alternativesFor(
      input: GeneratorInput(
        recipes: catalog.recipes,
        states: catalog.states,
        profile: p,
        weekStart: menu.startDate,
        slots: menu.slots,
        recentRecipeIds: recent,
        seed: Random().nextInt(1 << 31),
      ),
      key: key,
    );
  }

  Future<void> validate(WeekMenu menu) =>
      saveMenu(menu.copyWith(status: MenuStatus.validated));

  Future<void> setChecks(int itemId, {bool? bought, bool? atHome}) async {
    await repo.setItemChecks(itemId, bought: bought, atHome: atHome);
    _bump();
  }

  Future<void> addManualItem(int menuId, String label) async {
    await repo.addManualItem(menuId, label);
    _bump();
  }

  Future<void> deleteItem(int itemId) async {
    await repo.deleteItem(itemId);
    _bump();
  }

  Future<int> saveRecipe(Recipe r) async {
    final id = await repo.savePersonalRecipe(r);
    // La liste d'un menu validé suit les modifications de recette.
    await _refreshValidatedLists();
    _bump();
    return id;
  }

  Future<int> duplicate(Recipe r, String suffix) async {
    final id = await repo.duplicateRecipe(r, suffix);
    _bump();
    return id;
  }

  Future<void> deleteRecipe(int id) async {
    await repo.deleteRecipe(id);
    await _refreshValidatedLists();
    _bump();
  }

  Future<Ingredient> createIngredient(Ingredient i) async {
    final created = await repo.createIngredient(i);
    _bump();
    return created;
  }

  Future<void> _refreshValidatedLists() async {
    for (final m in await repo.allMenus()) {
      if (m.status == MenuStatus.validated) await repo.refreshShopping(m);
    }
  }

  Future<void> markReviewed(DateTime week) async {
    await repo.setMeta(Repository.metaLastReviewedWeek, weekCode(week));
    _bump();
  }

  Future<void> resetAll() async {
    await repo.resetAll();
    ref.read(selectedWeekProvider.notifier).clear();
    _bump();
  }

  void refresh() => _bump();
}

final actionsProvider = Provider<AppActions>(AppActions.new);

/// Semaine précédente à passer en bilan, s'il y en a une.
final pendingReviewProvider = FutureProvider<WeekMenu?>((ref) async {
  ref.watch(revisionProvider);
  final repo = ref.watch(repositoryProvider);
  final p = await ref.watch(profileProvider.future);
  final current = weekStartOf(ref.watch(todayProvider), p.weekStartDay);
  final prev = DateTime(current.year, current.month, current.day - 7);
  final menu = await repo.menuFor(prev);
  if (menu == null || menu.status != MenuStatus.validated) return null;
  if (!menu.slots.any((s) => s.kind == SlotKind.recipe)) return null;
  final last = await repo.meta(Repository.metaLastReviewedWeek);
  if (last != null && last.compareTo(weekCode(prev)) >= 0) return null;
  return menu;
});

class ReviewDismissed extends Notifier<bool> {
  @override
  bool build() => false;
  void dismiss() => state = true;
}

final reviewDismissedProvider = NotifierProvider<ReviewDismissed, bool>(
  ReviewDismissed.new,
);
