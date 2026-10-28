import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/food_log.dart';
import '../domain/models.dart';
import '../domain/nutrition.dart';
import '../domain/stock.dart';
import 'strings.dart';
import 'v2_providers.dart';
import 'widgets.dart';

/// Fiche recette : kcal et macros par portion (SPEC-V2 §4), ingrédients en
/// stock (§8) et ajout à la banque de repas (§9 [H]).
class RecipeNutritionSection extends ConsumerWidget {
  const RecipeNutritionSection({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = recipeMacrosPerServing(recipe);
    final lots = ref.watch(stockProvider).value ?? const <StockLot>[];
    final plan = planShoppingWithStock([
      PlannedUse(recipe: recipe, servings: recipe.servings),
    ], lots);
    final (ok, total) = plan.coverage.single;
    final theme = Theme.of(context);
    Widget metric(String label, String value) => Expanded(
      child: Column(
        children: [
          Text(value, style: theme.textTheme.titleMedium),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          '${S.portion} · ${m.kcal.round()} ${S.kcal}',
          trailing: total == 0 ? null : Text(S.inStockCount(ok, total)),
        ),
        Row(
          children: [
            metric(S.protein, '${m.protein.round()} g'),
            metric(S.carbs, '${m.carbs.round()} g'),
            metric(S.fat, '${m.fat.round()} g'),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () async {
              await ref
                  .read(kitchenActionsProvider)
                  .run(
                    (k) => k.savePreset(
                      MealPreset(
                        name: recipe.title,
                        recipeId: recipe.id,
                        recipePortions: 1,
                      ),
                    ),
                  );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.addedToBank(recipe.title))),
                );
              }
            },
            icon: const Icon(Icons.bookmark_add_outlined),
            label: const Text(S.addToBank),
          ),
        ),
      ],
    );
  }
}
