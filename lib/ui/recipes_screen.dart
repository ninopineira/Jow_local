import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/diet.dart';
import '../domain/enums.dart';
import '../domain/models.dart';
import 'profile_sections.dart';
import 'providers.dart';
import 'stock_screen.dart' show SettingsAction;
import 'strings.dart';
import 'widgets.dart';

class RecipeFilters {
  const RecipeFilters({
    this.query = '',
    this.type,
    this.quick = false,
    this.favorites = false,
    this.toPlace = false,
    this.personal = false,
    this.season = false,
    this.showAll = false,
  });

  final String query;
  final RecipeType? type;
  final bool quick;
  final bool favorites;
  final bool toPlace;
  final bool personal;
  final bool season;
  final bool showAll;

  RecipeFilters copyWith({
    String? query,
    RecipeType? type,
    bool clearType = false,
    bool? quick,
    bool? favorites,
    bool? toPlace,
    bool? personal,
    bool? season,
    bool? showAll,
  }) => RecipeFilters(
    query: query ?? this.query,
    type: clearType ? null : (type ?? this.type),
    quick: quick ?? this.quick,
    favorites: favorites ?? this.favorites,
    toPlace: toPlace ?? this.toPlace,
    personal: personal ?? this.personal,
    season: season ?? this.season,
    showAll: showAll ?? this.showAll,
  );
}

/// Onglet Recettes (SPEC §3.2).
class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});

  @override
  ConsumerState<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends ConsumerState<RecipesScreen> {
  var f = const RecipeFilters();

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(catalogProvider);
    final profile = ref.watch(profileProvider);
    final month = ref.watch(todayProvider).month;
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.recipesTitle),
        actions: const [SettingsAction()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('new-recipe'),
        onPressed: () => context.push('/recipes/new'),
        icon: const Icon(Icons.add_rounded),
        label: const Text(S.newRecipe),
      ),
      body: AsyncBody(
        value: catalog,
        builder: (c) => AsyncBody(
          value: profile,
          builder: (p) {
            final q = normalize(f.query);
            final rows = <(Recipe, List<Incompatibility>)>[];
            for (final r in c.recipes) {
              final st = c.stateOf(r.id);
              if (q.isNotEmpty && !normalize(r.title).contains(q)) continue;
              if (f.type != null && r.type != f.type) continue;
              if (f.quick && r.totalMin > 30) continue;
              if (f.favorites && !st.favorite) continue;
              if (f.toPlace && !st.toPlace) continue;
              if (f.personal && r.origin != Origin.personal) continue;
              if (f.season && !isInSeason(r, month)) continue;
              final reasons = incompatibilities(r, c.traits[r.id]!, p);
              if (reasons.isNotEmpty && !f.showAll) continue;
              rows.add((r, reasons));
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _filtersBar(context)),
                if (rows.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(
                      icon: Icons.search_off_rounded,
                      text: S.noRecipes,
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                    sliver: SliverList.builder(
                      itemCount: rows.length,
                      itemBuilder: (_, i) {
                        final (r, reasons) = rows[i];
                        final st = c.stateOf(r.id);
                        return RecipeTile(
                          recipe: r,
                          subtitle: [
                            S.minutesValue(r.totalMin),
                            S.recipeType(r.type),
                            if (reasons.isNotEmpty)
                              S.incompatible(
                                reasons.map(incompatibilityText).join(', '),
                              ),
                          ].join(' · '),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (st.toPlace)
                                const Icon(
                                  Icons.push_pin_rounded,
                                  semanticLabel: S.toPlace,
                                ),
                              if (st.favorite)
                                const Icon(
                                  Icons.favorite_rounded,
                                  semanticLabel: S.favorite,
                                ),
                            ],
                          ),
                          onTap: () => context.push('/recipes/${r.id}'),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _filtersBar(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            labelText: S.searchRecipes,
          ),
          onChanged: (v) => setState(() => f = f.copyWith(query: v)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final t in RecipeType.values)
              ChoiceChip(
                label: Text(S.recipeType(t)),
                selected: f.type == t,
                onSelected: (on) => setState(
                  () => f = on
                      ? f.copyWith(type: t)
                      : f.copyWith(clearType: true),
                ),
              ),
            FilterChip(
              label: const Text(S.filterQuick),
              selected: f.quick,
              onSelected: (v) => setState(() => f = f.copyWith(quick: v)),
            ),
            FilterChip(
              label: const Text(S.filterFavorites),
              selected: f.favorites,
              onSelected: (v) => setState(() => f = f.copyWith(favorites: v)),
            ),
            FilterChip(
              label: const Text(S.filterToPlace),
              selected: f.toPlace,
              onSelected: (v) => setState(() => f = f.copyWith(toPlace: v)),
            ),
            FilterChip(
              label: const Text(S.filterPersonal),
              selected: f.personal,
              onSelected: (v) => setState(() => f = f.copyWith(personal: v)),
            ),
            FilterChip(
              label: const Text(S.filterSeason),
              selected: f.season,
              onSelected: (v) => setState(() => f = f.copyWith(season: v)),
            ),
          ],
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(S.showAll),
          value: f.showAll,
          onChanged: (v) => setState(() => f = f.copyWith(showAll: v)),
        ),
      ],
    ),
  );
}
