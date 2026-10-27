import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/enums.dart';
import '../domain/models.dart';
import '../domain/quantities.dart';
import 'menu_screen.dart' show slotLabel;
import 'providers.dart';
import 'strings.dart';
import 'widgets.dart';

/// Fiche recette (SPEC §3.2).
class RecipeDetailScreen extends ConsumerStatefulWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});

  final int recipeId;

  @override
  ConsumerState<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen> {
  int? servings;

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(catalogProvider);
    return AsyncBody(
      value: catalog,
      builder: (c) {
        final r = c.byId[widget.recipeId];
        if (r == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const EmptyState(
              icon: Icons.no_food_rounded,
              text: S.noRecipes,
            ),
          );
        }
        final st = c.stateOf(r.id);
        final traits = c.traits[r.id]!;
        final n = servings ?? r.servings;
        final actions = ref.read(actionsProvider);
        return Scaffold(
          appBar: AppBar(
            title: Text(r.title, overflow: TextOverflow.ellipsis),
            actions: [
              IconButton(
                key: const Key('favorite'),
                tooltip: S.favorite,
                isSelected: st.favorite,
                icon: const Icon(Icons.favorite_border_rounded),
                selectedIcon: const Icon(Icons.favorite_rounded),
                onPressed: () => actions.updateState(
                  r.id,
                  (s) => s.copyWith(favorite: !s.favorite),
                ),
              ),
              IconButton(
                key: const Key('to-place'),
                tooltip: S.toPlace,
                isSelected: st.toPlace,
                icon: const Icon(Icons.push_pin_outlined),
                selectedIcon: const Icon(Icons.push_pin_rounded),
                onPressed: () => actions.updateState(
                  r.id,
                  (s) => s.copyWith(toPlace: !s.toPlace),
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (v) => _menuAction(v, r, st),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'duplicate',
                    child: Text(S.duplicate),
                  ),
                  PopupMenuItem(
                    value: 'dislike',
                    child: Text(st.disliked ? S.undislike : S.dislike),
                  ),
                  if (r.origin == Origin.personal) ...[
                    const PopupMenuItem(value: 'edit', child: Text(S.edit)),
                    const PopupMenuItem(value: 'delete', child: Text(S.delete)),
                  ],
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/recipes/${r.id}/cook'),
            icon: const Icon(Icons.soup_kitchen_rounded),
            label: const Text(S.cookMode),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
            children: [
              Center(child: RecipeThumb(recipe: r, size: 160)),
              const SizedBox(height: 12),
              if (r.description.isNotEmpty)
                Text(
                  r.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              if (st.disliked)
                const ListTile(
                  leading: Icon(Icons.thumb_down_rounded),
                  title: Text(S.dislikedBadge),
                ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.timer_outlined),
                    label: Text('${S.prep} ${S.minutesValue(r.prepMin)}'),
                  ),
                  Chip(
                    avatar: const Icon(Icons.local_fire_department_outlined),
                    label: Text('${S.cook} ${S.minutesValue(r.cookMin)}'),
                  ),
                  Chip(label: Text(S.difficulty(r.difficulty))),
                  for (final e in r.equipment)
                    Chip(label: Text(S.equipment(e))),
                ],
              ),
              SectionTitle(S.compatibleDiets),
              Text(
                [
                  for (final d in Diet.values)
                    if (traits.diets.contains(d)) S.diet(d),
                ].join(', '),
              ),
              SectionTitle(S.allergensTitle),
              Text(
                traits.allergens.isEmpty
                    ? S.noAllergen
                    : [
                        for (final a in Allergen.values)
                          if (traits.allergens.contains(a)) S.allergen(a),
                      ].join(', '),
              ),
              SectionTitle(
                S.ingredients,
                trailing: CountStepper(
                  label: S.servings(n),
                  value: n,
                  max: 24,
                  format: S.servings,
                  onChanged: (v) => setState(() => servings = v),
                ),
              ),
              for (final l in r.ingredients)
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    [
                      l.ingredient.name,
                      if (l.note != null && l.note!.isNotEmpty) '(${l.note})',
                      if (l.optional) '— ${S.optionalTag}',
                    ].join(' '),
                  ),
                  trailing: Text(
                    formatRecipeQuantity(l.qty * n / r.servings, l.unit),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              SectionTitle(S.steps),
              for (var i = 0; i < r.steps.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context)
                            .colorScheme
                            .onPrimary,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(r.steps[i])),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                key: const Key('add-to-menu'),
                onPressed: () => _addToMenu(r, n),
                icon: const Icon(Icons.calendar_month_rounded),
                label: const Text(S.addToMenu),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _menuAction(String v, Recipe r, RecipeUserState st) async {
    final actions = ref.read(actionsProvider);
    switch (v) {
      case 'duplicate':
        final id = await actions.duplicate(r, S.duplicateSuffix);
        if (mounted) context.push('/recipes/$id/edit');
      case 'dislike':
        await actions.updateState(
          r.id,
          (s) => s.copyWith(disliked: !s.disliked),
        );
      case 'edit':
        context.push('/recipes/${r.id}/edit');
      case 'delete':
        final ok = await showDialog<bool>(
          context: context,
          builder: (d) => AlertDialog(
            title: const Text(S.deleteRecipe),
            content: const Text(S.deleteRecipeBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(d, false),
                child: const Text(S.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(d, true),
                child: const Text(S.delete),
              ),
            ],
          ),
        );
        if (ok == true) {
          await actions.deleteRecipe(r.id);
          if (mounted) context.pop();
        }
    }
  }

  /// Ajoute la recette à un créneau de la semaine affichée, ou en extra pour
  /// les desserts et petits-déjeuners.
  Future<void> _addToMenu(Recipe r, int n) async {
    final menu = await ref.read(menuProvider.future);
    final actions = ref.read(actionsProvider);
    if (!mounted) return;
    if (r.type != RecipeType.main) {
      await actions.saveMenu(
        menu.copyWith(
          extras: [
            ...menu.extras,
            WeekExtra(recipeId: r.id, servings: n),
          ],
        ),
      );
    } else {
      final slot = await showDialog<MenuSlot>(
        context: context,
        builder: (d) => SimpleDialog(
          title: const Text(S.chooseSlot),
          children: [
            for (final s in menu.slots)
              SimpleDialogOption(
                onPressed: () => Navigator.pop(d, s),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    slotLabel(menu.startDate, s.key) +
                        (s.kind == SlotKind.empty
                            ? ''
                            : ' (${S.replace.toLowerCase()})'),
                  ),
                ),
              ),
          ],
        ),
      );
      if (slot == null) return;
      await actions.saveMenu(
        menu.withSlot(
          slot.copyWith(
            kind: SlotKind.recipe,
            recipeId: r.id,
            servings: n,
            clearLeftovers: true,
          ),
        ),
      );
    }
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(S.addedToMenu)));
    }
  }
}

/// Mode cuisine : une étape par écran, gros texte, écran maintenu allumé.
class CookModeScreen extends ConsumerStatefulWidget {
  const CookModeScreen({super.key, required this.recipeId});

  final int recipeId;

  @override
  ConsumerState<CookModeScreen> createState() => _CookModeScreenState();
}

class _CookModeScreenState extends ConsumerState<CookModeScreen> {
  final controller = PageController();
  var page = 0;
  late final bridge = ref.read(platformProvider);

  @override
  void initState() {
    super.initState();
    bridge.keepScreenOn(true);
  }

  @override
  void dispose() {
    bridge.keepScreenOn(false);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = ref.watch(catalogProvider).value?.byId[widget.recipeId];
    if (r == null) return const Scaffold();
    final total = r.steps.length;
    return Scaffold(
      appBar: AppBar(title: Text(S.stepOf(page + 1, total))),
      body: PageView.builder(
        controller: controller,
        itemCount: total,
        onPageChanged: (p) => setState(() => page = p),
        itemBuilder: (_, i) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Text(
            r.steps[i],
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(height: 1.35),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: page == 0
                      ? null
                      : () => controller.previousPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        ),
                  child: const Text(S.back),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(48, 52),
                  ),
                  onPressed: page == total - 1
                      ? () => context.pop()
                      : () => controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        ),
                  child: Text(page == total - 1 ? S.finish : S.next),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
