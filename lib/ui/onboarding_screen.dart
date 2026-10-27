import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models.dart';
import 'profile_sections.dart';
import 'providers.dart';
import 'strings.dart';
import 'theme.dart';
import 'widgets.dart';

/// Assistant du premier lancement (SPEC §3.1).
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  var profile = HouseholdProfile();
  var step = 0;

  static const titles = [
    S.stepPeople,
    S.stepDiet,
    S.stepAllergies,
    S.stepAversions,
    S.stepEquipment,
    S.stepSlots,
    S.stepTimes,
  ];

  void update(HouseholdProfile p) => setState(() => profile = p);

  Widget section(List<Ingredient> ingredients) => switch (step) {
    0 => PeopleSection(profile: profile, onChanged: update),
    1 => DietSection(profile: profile, onChanged: update),
    2 => AllergySection(profile: profile, onChanged: update),
    3 => AversionSection(
      profile: profile,
      onChanged: update,
      ingredients: ingredients,
    ),
    4 => EquipmentSection(profile: profile, onChanged: update),
    5 => SlotsSection(profile: profile, onChanged: update),
    _ => TimesSection(profile: profile, onChanged: update),
  };

  Future<void> finish() async {
    await ref.read(actionsProvider).saveProfile(profile);
    if (mounted) context.go('/menu');
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(catalogProvider);
    final last = step == titles.length - 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.welcomeTitle),
        leading: step > 0
            ? IconButton(
                tooltip: S.back,
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => setState(() => step--),
              )
            : null,
      ),
      body: SafeArea(
        child: AsyncBody(
          value: catalog,
          builder: (c) => ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (step == 0) ...[
                Text(
                  S.welcomeBody,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
              ],
              LinearProgressIndicator(
                value: (step + 1) / titles.length,
                borderRadius: BorderRadius.circular(4),
                semanticsLabel: titles[step],
              ),
              const SizedBox(height: 20),
              Semantics(
                header: true,
                child: Text(
                  titles[step],
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 16),
              section(c.ingredients),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: last
              ? FilledButton(
                  key: const Key('onboarding-finish'),
                  style: strongAction(context),
                  onPressed: finish,
                  child: const Text(S.start),
                )
              : FilledButton(
                  key: const Key('onboarding-next'),
                  onPressed: () => setState(() => step++),
                  child: const Text(S.next),
                ),
        ),
      ),
    );
  }
}
