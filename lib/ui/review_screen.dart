import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/enums.dart';
import '../domain/models.dart';
import 'providers.dart';
import 'strings.dart';
import 'widgets.dart';

/// Bilan de la semaine (SPEC §3.4) : aimé → favori, pas aimé → n'est plus
/// proposée automatiquement (réversible), passer.
class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key, required this.week});

  final DateTime week;

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

enum Verdict { liked, disliked, skipped }

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  final verdicts = <int, Verdict>{};
  WeekMenu? menu;

  @override
  void initState() {
    super.initState();
    ref.read(repositoryProvider).menuFor(widget.week).then((m) {
      if (mounted) setState(() => menu = m ?? WeekMenu(startDate: widget.week));
    });
  }

  Future<void> finish() async {
    final actions = ref.read(actionsProvider);
    for (final e in verdicts.entries) {
      switch (e.value) {
        case Verdict.liked:
          await actions.updateState(
            e.key,
            (s) => s.copyWith(favorite: true, disliked: false),
          );
        case Verdict.disliked:
          await actions.updateState(
            e.key,
            (s) => s.copyWith(disliked: true, favorite: false),
          );
        case Verdict.skipped:
          break;
      }
    }
    await actions.markReviewed(widget.week);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text(S.reviewThanks)));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(catalogProvider);
    return Scaffold(
      appBar: AppBar(title: Text('${S.review} · ${S.date(widget.week)}')),
      body: menu == null
          ? const Center(child: CircularProgressIndicator())
          : AsyncBody(
              value: catalog,
              builder: (c) {
                final ids = <int>[];
                for (final s in menu!.slots) {
                  if (s.kind == SlotKind.recipe &&
                      s.recipeId != null &&
                      c.byId[s.recipeId] != null &&
                      !ids.contains(s.recipeId)) {
                    ids.add(s.recipeId!);
                  }
                }
                if (ids.isEmpty) {
                  return const EmptyState(
                    icon: Icons.restaurant_menu_rounded,
                    text: S.reviewNothing,
                  );
                }
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    for (final id in ids)
                      Card(
                        key: Key('review-$id'),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RecipeThumb(recipe: c.byId[id]!, size: 48),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      c.byId[id]!.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SegmentedButton<Verdict>(
                                emptySelectionAllowed: true,
                                segments: const [
                                  ButtonSegment(
                                    value: Verdict.liked,
                                    icon: Icon(Icons.favorite_rounded),
                                    label: Text(S.liked),
                                  ),
                                  ButtonSegment(
                                    value: Verdict.disliked,
                                    icon: Icon(Icons.thumb_down_rounded),
                                    label: Text(S.disliked),
                                  ),
                                  ButtonSegment(
                                    value: Verdict.skipped,
                                    label: Text(S.skip),
                                  ),
                                ],
                                selected: {?verdicts[id]},
                                onSelectionChanged: (s) => setState(() {
                                  if (s.isEmpty) {
                                    verdicts.remove(id);
                                  } else {
                                    verdicts[id] = s.first;
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            key: const Key('review-done'),
            onPressed: menu == null ? null : finish,
            child: const Text(S.reviewDone),
          ),
        ),
      ),
    );
  }
}
