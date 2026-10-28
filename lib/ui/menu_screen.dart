import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/enums.dart';
import '../domain/generator.dart';
import '../domain/models.dart';
import 'done_button.dart';
import 'stock_screen.dart' show SettingsAction;
import 'providers.dart';
import 'v2_providers.dart';
import 'recipe_picker.dart';
import 'strings.dart';
import 'theme.dart';
import 'widgets.dart';

/// Onglet Menu : grille jours × créneaux de la semaine (SPEC §3.5).
class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = ref.watch(menuProvider);
    final catalog = ref.watch(catalogProvider);
    final profile = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title:
            menu.whenOrNull(data: (m) => _WeekTitle(menu: m)) ??
            const Text(S.tabMenu),
        actions: [
          IconButton(
            tooltip: S.review,
            icon: const Icon(Icons.rate_review_rounded),
            onPressed: () {
              final m = menu.value;
              if (m != null) context.push('/menu/review', extra: m.startDate);
            },
          ),
          const SettingsAction(),
        ],
      ),
      body: AsyncBody(
        value: menu,
        builder: (m) => AsyncBody(
          value: catalog,
          builder: (c) => AsyncBody(
            value: profile,
            builder: (p) => _MenuBody(menu: m, catalog: c, profile: p),
          ),
        ),
      ),
    );
  }
}

class _WeekTitle extends ConsumerWidget {
  const _WeekTitle({required this.menu});
  final WeekMenu menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void shift(int days) {
      final d = menu.startDate;
      ref
          .read(selectedWeekProvider.notifier)
          .set(DateTime(d.year, d.month, d.day + days));
    }

    return Row(
      children: [
        IconButton(
          tooltip: S.previousWeek,
          onPressed: () => shift(-7),
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Expanded(
          child: Text(
            S.weekOf(menu.startDate),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          tooltip: S.nextWeek,
          onPressed: () => shift(7),
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}

class _MenuBody extends ConsumerWidget {
  const _MenuBody({
    required this.menu,
    required this.catalog,
    required this.profile,
  });

  final WeekMenu menu;
  final Catalog catalog;
  final HouseholdProfile profile;

  Future<void> generate(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(actionsProvider).generate(menu);
    if (!context.mounted || result.unfilled.isEmpty) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(shortfallMessage(result, profile))));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final review = ref.watch(pendingReviewProvider).value;
    final dismissed = ref.watch(reviewDismissedProvider);
    final days = <int, List<MenuSlot>>{};
    for (final s in menu.slots) {
      (days[s.key.day] ??= []).add(s);
    }
    final hasRecipes = menu.slots.any((s) => s.kind == SlotKind.recipe);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              if (review != null && !dismissed)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(S.reviewPrompt),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            FilledButton(
                              onPressed: () => context.push(
                                '/menu/review',
                                extra: review.startDate,
                              ),
                              child: const Text(S.reviewOpen),
                            ),
                            TextButton(
                              onPressed: () => ref
                                  .read(reviewDismissedProvider.notifier)
                                  .dismiss(),
                              child: const Text(S.reviewLater),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (menu.status == MenuStatus.validated)
                const ListTile(
                  leading: Icon(Icons.check_circle_rounded),
                  title: Text(S.validated),
                  subtitle: Text(S.validatedHint),
                ),
              if (menu.slots.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(S.noActiveSlots, textAlign: TextAlign.center),
                ),
              for (final day in days.keys.toList()..sort()) ...[
                SectionTitle(_dayLabel(menu.startDate, day)),
                for (final s in days[day]!)
                  SlotCard(
                    menu: menu,
                    slot: s,
                    catalog: catalog,
                    profile: profile,
                  ),
              ],
              _ExtrasSection(menu: menu, catalog: catalog, profile: profile),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    key: const Key('generate'),
                    style: strongAction(context),
                    onPressed: menu.slots.isEmpty
                        ? null
                        : () => generate(context, ref),
                    icon: const Icon(Icons.auto_awesome_rounded),
                    label: const Text(S.generate),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    key: const Key('validate'),
                    style: strongAction(context),
                    onPressed: hasRecipes && menu.status != MenuStatus.validated
                        ? () => ref.read(actionsProvider).validate(menu)
                        : null,
                    icon: const Icon(Icons.check_rounded),
                    label: const Text(S.validate),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _dayLabel(DateTime start, int day) {
  final d = dayDate(start, day);
  return '${S.weekdayCap(d.weekday)} ${S.date(d)}';
}

String slotLabel(DateTime start, SlotKey k) =>
    '${_dayLabel(start, k.day)} · ${S.meal(k.meal)}';

/// Explication des créneaux vides après génération.
String shortfallMessage(GeneratorResult r, HouseholdProfile p) {
  final constraints = <String>[
    if (p.diet != Diet.omnivore) S.dietShort(p.diet),
    if (p.noPork) S.noPork.toLowerCase(),
    for (final a in Allergen.values)
      if (p.exclusions.contains(a)) S.withoutAllergen(a),
    for (final e in [Equipment.oven, Equipment.hob])
      if (!p.equipment.contains(e)) S.withoutEquipment(e),
  ];
  if (r.compatibleCount >= r.slots.length) {
    return S.shortfallTime(r.compatibleCount);
  }
  return S.shortfall(r.compatibleCount, constraints);
}

class SlotCard extends ConsumerWidget {
  const SlotCard({
    super.key,
    required this.menu,
    required this.slot,
    required this.catalog,
    required this.profile,
  });

  final WeekMenu menu;
  final MenuSlot slot;
  final Catalog catalog;
  final HouseholdProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = slot.kind == SlotKind.recipe
        ? catalog.byId[slot.recipeId]
        : null;
    String title;
    Widget leading;
    switch (slot.kind) {
      case SlotKind.recipe when recipe != null:
        title = recipe.title;
        leading = RecipeThumb(recipe: recipe, size: 48);
      case SlotKind.leftovers:
        final src = slot.leftoversFrom == null
            ? null
            : menu.slotAt(slot.leftoversFrom!);
        final srcRecipe = catalog.byId[src?.recipeId];
        title = srcRecipe == null
            ? S.leftovers
            : S.leftoversOf(srcRecipe.title);
        leading = const _SlotIcon(Icons.takeout_dining_rounded);
      case SlotKind.eatingOut:
        title = S.eatingOut;
        leading = const _SlotIcon(Icons.storefront_rounded);
      default:
        title = S.emptySlot;
        leading = const _SlotIcon(Icons.add_rounded);
    }
    // « x/y ingrédients en stock » (SPEC-V2 §8), créneaux pas encore faits.
    String? coverage;
    final plan = ref.watch(stockPlanProvider).value;
    if (plan != null) {
      final i = plan.$1.indexWhere((u) => u.slot == slot.key);
      if (i >= 0) {
        final (ok, total) = plan.$2.coverage[i];
        if (total > 0) coverage = S.inStockCount(ok, total);
      }
    }
    final details = [
      S.meal(slot.key.meal),
      if (slot.kind == SlotKind.recipe || slot.kind == SlotKind.leftovers)
        S.servings(slot.servings),
      if (recipe != null) S.minutesValue(recipe.totalMin),
      ?coverage,
    ].join(' · ');
    final canBeDone =
        slot.kind == SlotKind.recipe ||
        slot.kind == SlotKind.leftovers ||
        slot.kind == SlotKind.eatingOut;
    return Card(
      child: Column(
        children: [
          ListTile(
            key: Key('slot-${slot.key.day}-${slot.key.meal.code}'),
            minVerticalPadding: 12,
            leading: leading,
            title: Text(title),
            subtitle: Text(details),
            trailing: slot.locked
                ? const Icon(Icons.lock_rounded, semanticLabel: S.locked)
                : null,
            onTap: () =>
                showSlotSheet(context, ref, menu, slot, catalog, profile),
          ),
          if (canBeDone)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: DoneButton(menu: menu, slot: slot, catalog: catalog),
              ),
            ),
        ],
      ),
    );
  }
}

class _SlotIcon extends StatelessWidget {
  const _SlotIcon(this.icon);
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon),
  );
}

Future<void> showSlotSheet(
  BuildContext context,
  WidgetRef ref,
  WeekMenu menu,
  MenuSlot slot,
  Catalog catalog,
  HouseholdProfile profile,
) {
  final actions = ref.read(actionsProvider);
  Future<void> save(MenuSlot s) => actions.saveMenu(menu.withSlot(s));
  final recipe = catalog.byId[slot.recipeId];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (sheet) {
      Future<void> setRecipe(int id) async {
        Navigator.pop(sheet);
        await save(
          slot.copyWith(
            kind: SlotKind.recipe,
            recipeId: id,
            clearLeftovers: true,
          ),
        );
      }

      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                slotLabel(menu.startDate, slot.key),
                style: Theme.of(sheet).textTheme.titleMedium,
              ),
              if (recipe != null && slot.kind == SlotKind.recipe) ...[
                const SizedBox(height: 8),
                RecipeTile(
                  recipe: recipe,
                  onTap: () {
                    Navigator.pop(sheet);
                    context.push('/recipes/${recipe.id}');
                  },
                ),
              ],
              if (slot.kind == SlotKind.recipe ||
                  slot.kind == SlotKind.leftovers)
                ListTile(
                  title: const Text(S.slotServings),
                  trailing: CountStepper(
                    label: S.slotServings,
                    value: slot.servings,
                    max: 24,
                    onChanged: (v) async {
                      Navigator.pop(sheet);
                      await save(slot.copyWith(servings: v));
                    },
                  ),
                ),
              _AlternativesTile(menu: menu, slot: slot, onPick: setRecipe),
              ListTile(
                leading: const Icon(Icons.search_rounded),
                title: const Text(S.chooseRecipe),
                onTap: () async {
                  final id = await pickRecipe(context, mainsOnly: true);
                  if (id != null) await setRecipe(id);
                },
              ),
              if (slot.kind == SlotKind.recipe)
                ListTile(
                  leading: Icon(
                    slot.locked ? Icons.lock_open_rounded : Icons.lock_rounded,
                  ),
                  title: Text(slot.locked ? S.unlock : S.lock),
                  onTap: () async {
                    Navigator.pop(sheet);
                    await save(slot.copyWith(locked: !slot.locked));
                  },
                ),
              if (slot.kind == SlotKind.recipe)
                ListTile(
                  leading: const Icon(Icons.copy_all_rounded),
                  title: const Text(S.cookDouble),
                  onTap: () async {
                    final target = await _pickSlot(
                      sheet,
                      menu,
                      catalog,
                      S.doubleTarget,
                      (s) => s.key != slot.key && !s.locked,
                    );
                    if (target == null) return;
                    if (sheet.mounted) Navigator.pop(sheet);
                    await actions.saveMenu(
                      menu.withSlot(
                        target.copyWith(
                          kind: SlotKind.leftovers,
                          clearRecipe: true,
                          leftoversFrom: slot.key,
                        ),
                      ),
                    );
                  },
                ),
              ListTile(
                leading: const Icon(Icons.takeout_dining_rounded),
                title: const Text(S.markLeftovers),
                onTap: () async {
                  final source = await _pickSlot(
                    sheet,
                    menu,
                    catalog,
                    S.leftoversSource,
                    (s) =>
                        s.kind == SlotKind.recipe &&
                        s.key.compareTo(slot.key) < 0,
                  );
                  if (source == null) return;
                  if (sheet.mounted) Navigator.pop(sheet);
                  await save(
                    slot.copyWith(
                      kind: SlotKind.leftovers,
                      clearRecipe: true,
                      leftoversFrom: source.key,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.storefront_rounded),
                title: const Text(S.markEatingOut),
                onTap: () async {
                  Navigator.pop(sheet);
                  await save(
                    slot.copyWith(
                      kind: SlotKind.eatingOut,
                      clearRecipe: true,
                      clearLeftovers: true,
                      locked: false,
                    ),
                  );
                },
              ),
              if (slot.kind != SlotKind.empty)
                ListTile(
                  leading: const Icon(Icons.clear_rounded),
                  title: const Text(S.clearSlot),
                  onTap: () async {
                    Navigator.pop(sheet);
                    // Les restes qui dépendaient de ce créneau sont vidés aussi.
                    var m = menu.withSlot(slot.cleared());
                    for (final s in menu.slots) {
                      if (s.kind == SlotKind.leftovers &&
                          s.leftoversFrom == slot.key) {
                        m = m.withSlot(s.cleared());
                      }
                    }
                    await actions.saveMenu(m);
                  },
                ),
            ],
          ),
        ),
      );
    },
  );
}

Future<MenuSlot?> _pickSlot(
  BuildContext context,
  WeekMenu menu,
  Catalog catalog,
  String title,
  bool Function(MenuSlot) filter,
) {
  final options = menu.slots.where(filter).toList();
  return showDialog<MenuSlot>(
    context: context,
    builder: (d) => SimpleDialog(
      title: Text(title),
      children: [
        if (options.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(S.noSourceSlot),
          ),
        for (final s in options)
          SimpleDialogOption(
            onPressed: () => Navigator.pop(d, s),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                [
                  slotLabel(menu.startDate, s.key),
                  if (catalog.byId[s.recipeId] != null)
                    catalog.byId[s.recipeId]!.title,
                ].join(' — '),
              ),
            ),
          ),
      ],
    ),
  );
}

class _AlternativesTile extends ConsumerStatefulWidget {
  const _AlternativesTile({
    required this.menu,
    required this.slot,
    required this.onPick,
  });

  final WeekMenu menu;
  final MenuSlot slot;
  final ValueChanged<int> onPick;

  @override
  ConsumerState<_AlternativesTile> createState() => _AlternativesTileState();
}

class _AlternativesTileState extends ConsumerState<_AlternativesTile> {
  List<Recipe>? alternatives;

  @override
  Widget build(BuildContext context) {
    if (alternatives == null) {
      return ListTile(
        key: const Key('replace'),
        leading: const Icon(Icons.swap_horiz_rounded),
        title: const Text(S.replace),
        onTap: () async {
          final a = await ref
              .read(actionsProvider)
              .alternatives(widget.menu, widget.slot.key);
          if (mounted) setState(() => alternatives = a);
        },
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(S.alternatives),
        for (final r in alternatives!)
          RecipeTile(recipe: r, onTap: () => widget.onPick(r.id)),
      ],
    );
  }
}

class _ExtrasSection extends ConsumerWidget {
  const _ExtrasSection({
    required this.menu,
    required this.catalog,
    required this.profile,
  });

  final WeekMenu menu;
  final Catalog catalog;
  final HouseholdProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.read(actionsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          S.extras,
          trailing: IconButton(
            tooltip: S.addExtra,
            icon: const Icon(Icons.add_circle_rounded),
            onPressed: () async {
              final id = await pickRecipe(context, sweetsFirst: true);
              if (id == null) return;
              await actions.saveMenu(
                menu.copyWith(
                  extras: [
                    ...menu.extras,
                    WeekExtra(recipeId: id, servings: profile.people),
                  ],
                ),
              );
            },
          ),
        ),
        if (menu.extras.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              S.extrasHint,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        for (var i = 0; i < menu.extras.length; i++)
          if (catalog.byId[menu.extras[i].recipeId] != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RecipeThumb(
                          recipe: catalog.byId[menu.extras[i].recipeId]!,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            catalog.byId[menu.extras[i].recipeId]!.title,
                          ),
                        ),
                        IconButton(
                          tooltip: S.delete,
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => actions.saveMenu(
                            menu.copyWith(
                              extras: [...menu.extras]..removeAt(i),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (menu.extras[i].id != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: DoneButton(
                          menu: menu,
                          extraIndex: i,
                          catalog: catalog,
                        ),
                      ),
                    CountStepper(
                      label: S.slotServings,
                      value: menu.extras[i].servings,
                      max: 24,
                      format: S.servings,
                      onChanged: (v) {
                        final list = [...menu.extras];
                        list[i] = WeekExtra(
                          recipeId: list[i].recipeId,
                          servings: v,
                        );
                        actions.saveMenu(menu.copyWith(extras: list));
                      },
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}
