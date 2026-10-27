import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/diet.dart';
import '../domain/models.dart';
import 'providers.dart';
import 'strings.dart';
import 'theme.dart';

/// Vignette : photo pour une recette perso, sinon couleur et icône de la base.
class RecipeThumb extends ConsumerWidget {
  const RecipeThumb({super.key, required this.recipe, this.size = 56});

  final Recipe recipe;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = recipe.photoPath;
    Widget child;
    if (photo != null) {
      final store = ref.watch(photoStoreProvider);
      child = Image.file(
        store.file(photo),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _generated(),
      );
    } else {
      child = _generated();
    }
    return ExcludeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size > 80 ? radius : 12),
        child: SizedBox(width: size, height: size, child: child),
      ),
    );
  }

  Widget _generated() {
    final t = thumbFor(recipe.mainBase);
    return ColoredBox(
      color: t.color,
      child: Center(
        child: Icon(t.icon, size: size * 0.5, color: const Color(0xFF2B2B2B)),
      ),
    );
  }
}

/// Sélecteur +/− accessible (cibles de 48 px).
class CountStepper extends StatelessWidget {
  const CountStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 12,
    required this.label,
    this.format,
  });

  final int value;
  final int min;
  final int max;
  final String label;
  final String Function(int)? format;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final text = format?.call(value) ?? '$value';
    return Semantics(
      label: label,
      value: text,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.outlined(
            tooltip: '${S.decrease} : $label',
            onPressed: value > min ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove_rounded),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 72),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          IconButton.outlined(
            tooltip: '${S.increase} : $label',
            onPressed: value < max ? () => onChanged(value + 1) : null,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
    child: Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(text, style: Theme.of(context).textTheme.titleMedium),
          ),
        ),
        ?trailing,
      ],
    ),
  );
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.text,
    this.action,
  });

  final IconData icon;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    ),
  );
}

/// Affiche un AsyncValue avec chargement et erreur génériques.
class AsyncBody<T> extends StatelessWidget {
  const AsyncBody({super.key, required this.value, required this.builder});

  final AsyncValue<T> value;
  final Widget Function(T) builder;

  @override
  Widget build(BuildContext context) => value.when(
    data: builder,
    loading: () => const Center(
      child: CircularProgressIndicator(semanticsLabel: S.loading),
    ),
    error: (e, _) => Center(child: Text('${S.errorGeneric}\n$e')),
  );
}

/// Raison lisible d'une incompatibilité.
String incompatibilityText(Incompatibility i) => switch (i) {
  DietIncompatibility(:final diet) => S.reasonDiet(diet),
  PorkIncompatibility() => S.reasonPork,
  AllergenIncompatibility(:final allergen) => S.reasonAllergen(allergen),
  AversionIncompatibility(:final ingredient) => S.reasonAversion(
    ingredient.name.toLowerCase(),
  ),
  EquipmentIncompatibility(:final equipment) => S.reasonEquipment(equipment),
};

/// Ligne de recette (catalogue, sélecteurs).
class RecipeTile extends StatelessWidget {
  const RecipeTile({
    super.key,
    required this.recipe,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  final Recipe recipe;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            RecipeThumb(recipe: recipe),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle ??
                        '${S.minutesValue(recipe.totalMin)} · ${S.recipeType(recipe.type)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    ),
  );
}

bool fileExists(String path) => File(path).existsSync();
