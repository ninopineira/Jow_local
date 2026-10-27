import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/diet.dart';
import '../domain/enums.dart';
import 'profile_sections.dart';
import 'providers.dart';
import 'strings.dart';
import 'widgets.dart';

/// Ouvre la recherche de recette et renvoie l'id choisi. La planification à
/// la main reste possible pour une recette « pas aimée » (SPEC §3.4).
Future<int?> pickRecipe(
  BuildContext context, {
  bool mainsOnly = false,
  bool sweetsFirst = false,
}) => Navigator.of(context).push<int>(
  MaterialPageRoute(
    builder: (_) =>
        RecipePickerScreen(mainsOnly: mainsOnly, sweetsFirst: sweetsFirst),
  ),
);

class RecipePickerScreen extends ConsumerStatefulWidget {
  const RecipePickerScreen({
    super.key,
    this.mainsOnly = false,
    this.sweetsFirst = false,
  });

  final bool mainsOnly;
  final bool sweetsFirst;

  @override
  ConsumerState<RecipePickerScreen> createState() => _RecipePickerScreenState();
}

class _RecipePickerScreenState extends ConsumerState<RecipePickerScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(catalogProvider);
    final profile = ref.watch(profileProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: S.searchRecipes,
            border: InputBorder.none,
          ),
          onChanged: (v) => setState(() => query = v),
        ),
      ),
      body: AsyncBody(
        value: catalog,
        builder: (c) {
          final q = normalize(query);
          final list = c.recipes.where((r) {
            if (widget.mainsOnly && r.type != RecipeType.main) return false;
            return q.isEmpty || normalize(r.title).contains(q);
          }).toList();
          int rank(r) {
            final compatible =
                profile == null || isCompatible(r, c.traits[r.id]!, profile);
            final sweet = r.type != RecipeType.main;
            return (compatible ? 0 : 2) +
                (widget.sweetsFirst && !sweet ? 1 : 0);
          }

          list.sort((a, b) => rank(a).compareTo(rank(b)));
          if (list.isEmpty) {
            return const EmptyState(
              icon: Icons.search_off_rounded,
              text: S.noRecipes,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (_, i) => RecipeTile(
              recipe: list[i],
              onTap: () => Navigator.pop(context, list[i].id),
            ),
          );
        },
      ),
    );
  }
}
