import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/kitchen_repository.dart';
import '../data/repository.dart';
import '../domain/enums.dart';
import '../domain/food_log.dart';
import '../domain/models.dart';
import '../domain/nutrition.dart';
import '../domain/stock.dart';
import 'product_flow.dart';
import 'providers.dart';
import 'stock_screen.dart';
import 'strings.dart';
import 'v2_providers.dart';

/// Portions cuisinées d'un créneau : ses portions + celles des restes qui en
/// dépendent (on cuisine en double). 0 pour un créneau « restes ».
int cookedServingsFor(WeekMenu menu, MenuSlot slot) {
  if (slot.kind != SlotKind.recipe) return 0;
  var n = slot.servings;
  for (final o in menu.slots) {
    if (o.kind == SlotKind.leftovers && o.leftoversFrom == slot.key) {
      n += o.servings;
    }
  }
  return n;
}

/// Recette mangée sur un créneau (celle du créneau source pour des restes).
Recipe? recipeForSlot(WeekMenu menu, MenuSlot slot, Catalog catalog) {
  if (slot.kind == SlotKind.recipe) return catalog.byId[slot.recipeId];
  if (slot.kind == SlotKind.leftovers && slot.leftoversFrom != null) {
    return catalog.byId[menu.slotAt(slot.leftoversFrom!)?.recipeId];
  }
  return null;
}

/// Bouton « Fait » d'un créneau ou d'un extra (SPEC-V2 §6) : un geste, sans
/// confirmation ; « Ajuster » en option ; « Annuler » une fois fait.
class DoneButton extends ConsumerWidget {
  const DoneButton({
    super.key,
    required this.menu,
    this.slot,
    this.extraIndex,
    required this.catalog,
  });

  final WeekMenu menu;
  final MenuSlot? slot;
  final int? extraIndex;
  final Catalog catalog;

  String get _key => slot != null
      ? 'slot:${slotKeyCode(slot!.key)}'
      : 'extra:${menu.extras[extraIndex!].id}';

  /// Jour du journal : celui du créneau, ramené à aujourd'hui s'il est à
  /// venir ; aujourd'hui pour un extra.
  DateTime _date(DateTime today) => slot != null
      ? mealLogDate(dayDate(menu.startDate, slot!.key.day), today)
      : mealLogDate(today, today);

  Recipe? get _recipe => slot != null
      ? recipeForSlot(menu, slot!, catalog)
      : catalog.byId[menu.extras[extraIndex!].recipeId];

  int get _cooked => slot != null
      ? cookedServingsFor(menu, slot!)
      : menu.extras[extraIndex!].servings;

  Future<WeekMenu> _saved(WidgetRef ref) async =>
      menu.id != null ? menu : ref.read(actionsProvider).saveMenu(menu);

  Future<void> _markDone(
    BuildContext context,
    WidgetRef ref, {
    double portions = 1,
    Set<String> excluded = const {},
    Map<String, String> replacements = const {},
  }) async {
    final recipe = _recipe;
    if (recipe == null) return;
    final today = ref.read(todayProvider);
    final date = _date(today);
    final m = await _saved(ref);
    await ref
        .read(kitchenActionsProvider)
        .run(
          (k) => k.markDone(
            menu: m,
            recipe: recipe,
            date: date,
            slot: slot?.key,
            extraId: slot == null ? m.extras[extraIndex!].id : null,
            cookedServings: _cooked,
            portionsEaten: portions,
            excluded: excluded,
            replacements: replacements,
          ),
        );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.doneSnack(
              recipe.title,
              on: date == mealLogDate(today, today) ? null : date,
            ),
          ),
        ),
      );
    }
  }

  Future<void> _adjust(BuildContext context, WidgetRef ref) async {
    final recipe = _recipe;
    if (recipe == null) return;
    var portions = 1.0;
    final excluded = <String>{};
    final replacements = <String, Ingredient>{};
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, set) {
          final kcal = mealPortionMacros(
            recipe,
            portions: portions,
            excluded: excluded,
            replacements: replacements,
          ).kcal;
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                Text(recipe.title, style: Theme.of(ctx).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(S.portionsEaten),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final p in [0.5, 1.0, 1.5, 2.0])
                      ChoiceChip(
                        label: Text(p.toString().replaceAll('.', ',')),
                        selected: portions == p,
                        onSelected: (_) => set(() => portions = p),
                      ),
                  ],
                ),
                Text('${kcal.round()} ${S.kcal}'),
                const Divider(),
                for (final ri in recipe.ingredients)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      replacements[ri.ingredient.id]?.name ??
                          ri.ingredient.name,
                      style: excluded.contains(ri.ingredient.id)
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            )
                          : null,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: S.replaceIngredient,
                          icon: const Icon(Icons.swap_horiz_rounded),
                          onPressed: () async {
                            final i = await pickIngredient(
                              ctx,
                              catalog.ingredients,
                            );
                            if (i != null) {
                              set(() => replacements[ri.ingredient.id] = i);
                            }
                          },
                        ),
                        IconButton(
                          tooltip: S.removeIngredient,
                          icon: Icon(
                            excluded.contains(ri.ingredient.id)
                                ? Icons.undo_rounded
                                : Icons.remove_circle_outline_rounded,
                          ),
                          onPressed: () => set(
                            () => excluded.contains(ri.ingredient.id)
                                ? excluded.remove(ri.ingredient.id)
                                : excluded.add(ri.ingredient.id),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text(S.done),
                ),
              ],
            ),
          );
        },
      ),
    );
    if (ok != true || !context.mounted) return;
    await _markDone(
      context,
      ref,
      portions: portions,
      excluded: excluded,
      replacements: {for (final e in replacements.entries) e.key: e.value.id},
    );
  }

  /// Repas dehors : rien ne sort du stock, calories saisies à la main.
  Future<void> _outside(BuildContext context, WidgetRef ref) async {
    final kcal = await askNumber(context, S.outsideKcal, suffix: S.kcal);
    if (kcal == null || kcal <= 0) return;
    await ref
        .read(kitchenActionsProvider)
        .run(
          (k) => k.addLogEntry(
            FoodLogEntry(
              date: _date(ref.read(todayProvider)),
              moment: Moment.forMeal(slot!.key.meal),
              label: S.eatingOut,
              source: LogSource.free,
              macros: Macros(kcal: kcal),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (slot?.kind == SlotKind.eatingOut) {
      return IconButton(
        tooltip: S.outsideKcal,
        icon: const Icon(Icons.local_fire_department_outlined),
        onPressed: () => _outside(context, ref),
      );
    }
    if (_recipe == null) return const SizedBox.shrink();
    final done = ref.watch(completionsProvider).value?[_key];
    if (done != null) {
      return TextButton.icon(
        onPressed: () => ref
            .read(kitchenActionsProvider)
            .run((KitchenRepository k) => k.undoDone(done.id!)),
        icon: const Icon(Icons.check_circle_rounded),
        label: const Text(S.undoDone),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: S.adjust,
          icon: const Icon(Icons.tune_rounded),
          onPressed: () => _adjust(context, ref),
        ),
        FilledButton.tonal(
          onPressed: () => _markDone(context, ref),
          child: const Text(S.done),
        ),
      ],
    );
  }
}
