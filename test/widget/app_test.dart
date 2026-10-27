import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/repository.dart';
import 'package:popote/domain/enums.dart';
import 'package:popote/domain/models.dart';
import 'package:popote/ui/strings.dart';
import 'package:popote/ui/widgets.dart';

import 'harness.dart';

void main() {
  testWidgets('premier lancement : assistant puis menu', (tester) async {
    final h = await pumpApp(tester);
    expect(find.text(S.welcomeTitle), findsOneWidget);

    // 1. Personnes : 2 → 3
    await tapAndSettle(
      tester,
      find.byTooltip('${S.increase} : ${S.stepPeople}'),
    );
    expect(find.text(S.people(3)), findsOneWidget);
    await tapAndSettle(tester, find.byKey(const Key('onboarding-next')));
    // 2. Régime : végétarien
    await tapAndSettle(tester, find.text(S.diet(Diet.vegetarian)));
    await tapAndSettle(tester, find.byKey(const Key('onboarding-next')));
    // 3. Allergies : arachides, avec l'avertissement étiquette
    expect(find.text(S.allergyWarning), findsOneWidget);
    await tapAndSettle(tester, find.text(S.allergen(Allergen.peanuts)));
    await tapAndSettle(tester, find.byKey(const Key('onboarding-next')));
    // 4. Aversions : recherche dans le catalogue
    await tester.enterText(find.byType(TextField), 'betterave');
    await settle(tester);
    await tapAndSettle(tester, find.text('Betterave cuite'));
    expect(find.widgetWithText(InputChip, 'Betterave cuite'), findsOneWidget);
    await tapAndSettle(tester, find.byKey(const Key('onboarding-next')));
    // 5 à 7 : valeurs par défaut
    for (var i = 0; i < 2; i++) {
      await tapAndSettle(tester, find.byKey(const Key('onboarding-next')));
    }
    await tapAndSettle(tester, find.byKey(const Key('onboarding-finish')));

    expect(find.text(S.generate), findsOneWidget);
    late HouseholdProfile p;
    await tester.runAsync(() async => p = await h.repo.profile());
    expect(p.people, 3);
    expect(p.diet, Diet.vegetarian);
    expect(p.exclusions, {Allergen.peanuts});
    expect(p.aversions, {'betterave-cuite'});
    expect(p.activeSlots, HouseholdProfile.defaultSlots);
  });

  testWidgets('générer puis valider le menu : la liste apparaît', (
    tester,
  ) async {
    final h = await pumpApp(tester, profile: HouseholdProfile());
    expect(find.text(S.emptySlot), findsWidgets);

    await tapAndSettle(tester, find.byKey(const Key('generate')));
    expect(find.text(S.emptySlot), findsNothing);

    await tapAndSettle(tester, find.byKey(const Key('validate')));
    expect(find.text(S.validated), findsOneWidget);

    late WeekMenu? m;
    await tester.runAsync(
      () async => m = await h.repo.menuFor(DateTime(2026, 3, 2)),
    );
    expect(m!.status, MenuStatus.validated);
    expect(m!.slots.where((s) => s.kind == SlotKind.recipe), hasLength(7));

    await tapAndSettle(tester, find.text(S.tabList));
    expect(find.text(S.listEmpty), findsNothing);
    expect(find.textContaining('pour : '), findsWidgets);
  });

  testWidgets('remplacer un créneau par une alternative', (tester) async {
    final h = await pumpApp(tester, profile: HouseholdProfile());
    await tapAndSettle(tester, find.byKey(const Key('generate')));
    late int before;
    await tester.runAsync(() async {
      before = (await h.repo.menuFor(DateTime(2026, 3, 2)))!
          .slotAt(const SlotKey(0, Meal.dinner))!
          .recipeId!;
    });

    await tapAndSettle(tester, find.byKey(const Key('slot-0-dinner')));
    await tapAndSettle(tester, find.byKey(const Key('replace')));
    expect(find.text(S.alternatives), findsOneWidget);
    final alt = find.descendant(
      of: find.byType(BottomSheet),
      matching: find.byType(RecipeTile),
    );
    // Première alternative (après la fiche de la recette actuelle).
    await tapAndSettle(tester, alt.at(1));

    late int after;
    await tester.runAsync(() async {
      after = (await h.repo.menuFor(DateTime(2026, 3, 2)))!
          .slotAt(const SlotKey(0, Meal.dinner))!
          .recipeId!;
    });
    expect(after, isNot(before));
  });

  testWidgets('cocher une ligne de la liste', (tester) async {
    final h = await pumpApp(
      tester,
      profile: HouseholdProfile(),
      setup: (repo) async {
        final r = (await repo.recipes()).firstWhere(
          (r) => r.type == RecipeType.main,
        );
        await repo.saveMenu(
          WeekMenu(
            startDate: DateTime(2026, 3, 2),
            status: MenuStatus.validated,
            slots: [
              MenuSlot(
                key: const SlotKey(0, Meal.dinner),
                kind: SlotKind.recipe,
                recipeId: r.id,
              ),
            ],
          ),
        );
      },
    );
    await tapAndSettle(tester, find.text(S.tabList));
    final box = find.byType(Checkbox).first;
    await tapAndSettle(tester, box);
    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, isTrue);

    late List<bool> bought;
    await tester.runAsync(() async {
      final m = await h.repo.menuFor(DateTime(2026, 3, 2));
      bought = [for (final i in await h.repo.shoppingItems(m!.id!)) i.bought];
    });
    expect(bought.where((b) => b), hasLength(1));

    // Partage en texte via la feuille de partage du système.
    await tapAndSettle(tester, find.byTooltip(S.share));
    expect(h.platform.shared.single, contains('Courses'));
  });

  testWidgets('créer une recette perso', (tester) async {
    final h = await pumpApp(tester, profile: HouseholdProfile());
    await tapAndSettle(tester, find.text(S.tabRecipes));
    await tapAndSettle(tester, find.byKey(const Key('new-recipe')));

    await tester.enterText(
      find.byKey(const Key('recipe-title')),
      'Soupe de Mamie',
    );
    await scrollTo(tester, find.byKey(const Key('add-ingredient')));
    await tapAndSettle(tester, find.byKey(const Key('add-ingredient')));
    await tester.enterText(
      find.byKey(const Key('ingredient-search')),
      'poireau',
    );
    await settle(tester);
    await tapAndSettle(tester, find.text('Poireau').last);
    await tester.enterText(find.byKey(const Key('qty-0')), '3');
    await scrollTo(tester, find.byKey(const Key('step-0')));
    await tester.enterText(
      find.byKey(const Key('step-0')),
      'Émincer et cuire 20 minutes.',
    );
    await settle(tester);
    // Régime calculé depuis les ingrédients.
    await scrollTo(tester, find.textContaining(S.computedDiet));
    expect(find.textContaining(S.computedDiet), findsOneWidget);
    await tapAndSettle(tester, find.byKey(const Key('save-recipe')));

    expect(find.text('Soupe de Mamie'), findsWidgets);
    late List<Recipe> perso;
    await tester.runAsync(() async {
      perso = (await h.repo.recipes())
          .where((r) => r.origin == Origin.personal)
          .toList();
    });
    expect(perso.single.title, 'Soupe de Mamie');
    expect(perso.single.ingredients.single.qty, 3);
    expect(perso.single.steps, ['Émincer et cuire 20 minutes.']);
  });

  testWidgets('bilan de la semaine : aimé devient favori, pas aimé exclu', (
    tester,
  ) async {
    late List<Recipe> mains;
    final h = await pumpApp(
      tester,
      profile: HouseholdProfile(),
      setup: (repo) async {
        mains = (await repo.recipes())
            .where((r) => r.type == RecipeType.main)
            .toList();
        await repo.saveMenu(
          WeekMenu(
            startDate: DateTime(2026, 2, 23),
            status: MenuStatus.validated,
            slots: [
              MenuSlot(
                key: const SlotKey(0, Meal.dinner),
                kind: SlotKind.recipe,
                recipeId: mains[0].id,
              ),
              MenuSlot(
                key: const SlotKey(1, Meal.dinner),
                kind: SlotKind.recipe,
                recipeId: mains[1].id,
              ),
            ],
          ),
        );
      },
    );
    // La semaine passée n'a pas eu de bilan : invitation sur l'onglet Menu.
    expect(find.text(S.reviewPrompt), findsOneWidget);
    await tapAndSettle(tester, find.text(S.reviewOpen));

    await tapAndSettle(
      tester,
      find.descendant(
        of: find.byKey(Key('review-${mains[0].id}')),
        matching: find.text(S.liked),
      ),
    );
    await tapAndSettle(
      tester,
      find.descendant(
        of: find.byKey(Key('review-${mains[1].id}')),
        matching: find.text(S.disliked),
      ),
    );
    await tapAndSettle(tester, find.byKey(const Key('review-done')));

    late Map<int, RecipeUserState> states;
    late String? reviewed;
    await tester.runAsync(() async {
      states = await h.repo.userStates();
      reviewed = await h.repo.meta(Repository.metaLastReviewedWeek);
    });
    expect(states[mains[0].id]!.favorite, isTrue);
    expect(states[mains[1].id]!.disliked, isTrue);
    expect(reviewed, '2026-02-23');
    expect(find.text(S.reviewPrompt), findsNothing);
  });

  testWidgets('écran À propos : hors ligne expliqué', (tester) async {
    await pumpApp(tester, profile: HouseholdProfile());
    await tapAndSettle(tester, find.text(S.tabSettings));
    await tapAndSettle(tester, find.text(S.about));
    expect(find.text(S.aboutBody), findsOneWidget);
  });

  testWidgets('mode cuisine : écran maintenu allumé', (tester) async {
    final h = await pumpApp(tester, profile: HouseholdProfile());
    await tapAndSettle(tester, find.text(S.tabRecipes));
    await tapAndSettle(tester, find.byType(RecipeTile).first);
    await tapAndSettle(tester, find.text(S.cookMode));
    expect(find.textContaining('Étape 1 sur'), findsOneWidget);
    expect(h.platform.screenOn, [true]);
  });
}
