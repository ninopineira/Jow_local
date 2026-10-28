import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/balance.dart';
import '../domain/energy.dart';
import '../domain/food_log.dart';
import '../domain/models.dart';
import '../domain/nutrition.dart';
import '../domain/quantities.dart';
import '../domain/strength.dart';
import 'product_flow.dart';
import 'providers.dart';
import 'scanner.dart';
import 'stock_screen.dart';
import 'strings.dart';
import 'v2_providers.dart';
import 'widgets.dart';

String kcalText(double v) => '${v.round()} ${S.kcal}';
String signedKcal(double v) {
  final r = v.round();
  return '${r > 0 ? '+' : (r < 0 ? '−' : '')}${r.abs()} ${S.kcal}';
}

String gramsText(double v) => '${formatNumber(v)} g';

Moment defaultMoment(DateTime now) => now.hour < 10
    ? Moment.breakfast
    : now.hour < 15
    ? Moment.lunch
    : now.hour < 18
    ? Moment.snack
    : Moment.dinner;

class NutritionScreen extends ConsumerWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(nutritionDayProvider);
    final today = ref.watch(todayProvider);
    final t = DateTime(today.year, today.month, today.day);
    final label = day == t
        ? S.today
        : day == t.subtract(const Duration(days: 1))
        ? S.yesterday
        : formatDate(day);
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.nutritionTitle),
        actions: [
          IconButton(
            tooltip: S.scan,
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () => eatScanned(context, ref),
          ),
          const SettingsAction(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showIAte(context, ref),
        icon: const Icon(Icons.restaurant_rounded),
        label: const Text(S.iAte),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          Row(
            children: [
              IconButton(
                tooltip: S.back,
                icon: const Icon(Icons.chevron_left_rounded),
                onPressed: () => ref
                    .read(nutritionDaySelectionProvider.notifier)
                    .set(day.subtract(const Duration(days: 1))),
              ),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                tooltip: S.next,
                icon: const Icon(Icons.chevron_right_rounded),
                onPressed: day == t
                    ? null
                    : () => ref
                          .read(nutritionDaySelectionProvider.notifier)
                          .set(day.add(const Duration(days: 1))),
              ),
            ],
          ),
          const _BalanceCard(),
          const _Journal(),
          const _Activity(),
          const _Weights(),
          const _History(),
          const SizedBox(height: 16),
          Text(S.estimateNote, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _BalanceCard extends ConsumerWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(nutritionProfileProvider).value;
    final sums = ref.watch(summariesProvider(1)).value;
    if (sums == null) return const SizedBox(height: 120);
    final s = sums.single.$2;
    final theme = Theme.of(context);
    Widget metric(String l, String v) => Expanded(
      child: Column(
        children: [
          Text(v, style: theme.textTheme.titleMedium),
          Text(l, style: theme.textTheme.bodySmall),
        ],
      ),
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (profile == null) ...[
              Text(S.nutritionProfileMissing),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => editNutritionProfile(context, ref),
                child: const Text(S.nutritionProfile),
              ),
              const SizedBox(height: 12),
            ],
            Row(
              children: [
                metric(S.intake, kcalText(s.intake.kcal)),
                metric(
                  S.expenditure,
                  s.balance == null
                      ? '—'
                      : kcalText(s.balance!.expenditureKcal),
                ),
                metric(
                  s.balance == null
                      ? S.balance
                      : S.balanceStatus(s.balance!.status.name),
                  s.balance == null ? '—' : signedKcal(s.balance!.netKcal),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                metric(S.protein, gramsText(s.intake.protein)),
                metric(S.carbs, gramsText(s.intake.carbs)),
                metric(S.fat, gramsText(s.intake.fat)),
              ],
            ),
            if (s.tdeeKcal != null) ...[
              const Divider(height: 24),
              Row(
                children: [
                  metric(S.bmrLife, kcalText(s.tdeeKcal!)),
                  metric(S.sessions, kcalText(s.sessionKcal)),
                  metric(S.stepsShort, kcalText(s.stepsKcal)),
                ],
              ),
            ],
            if (s.goalDeviationKcal != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(S.goalGap(signedKcal(s.goalDeviationKcal!))),
              ),
            if (profile != null)
              TextButton(
                onPressed: () => editNutritionProfile(context, ref),
                child: const Text(S.nutritionProfile),
              ),
          ],
        ),
      ),
    );
  }
}

class _Journal extends ConsumerWidget {
  const _Journal();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(dayLogProvider).value ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(S.journal),
        if (entries.isEmpty) Text(S.journalEmpty),
        for (final m in Moment.values)
          if (entries.any((e) => e.moment == m)) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                S.moment(m.code),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            for (final e in entries.where((e) => e.moment == m))
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(e.label),
                subtitle: Text(
                  'P ${gramsText(e.macros.protein)} · G '
                  '${gramsText(e.macros.carbs)} · L ${gramsText(e.macros.fat)}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(kcalText(e.macros.kcal)),
                    IconButton(
                      tooltip: S.delete,
                      icon: const Icon(Icons.delete_outline_rounded),
                      onPressed: () => ref
                          .read(kitchenActionsProvider)
                          .run((k) => k.deleteLogEntry(e.id!)),
                    ),
                  ],
                ),
              ),
          ],
      ],
    );
  }
}

// ------------------------------------------------------------ j'ai mangé

Future<void> showIAte(BuildContext context, WidgetRef ref) async {
  final choice = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (key, icon, label) in [
            ('scan', Icons.qr_code_scanner_rounded, S.scan),
            ('product', Icons.inventory_2_outlined, S.fromProduct),
            ('ingredient', Icons.eco_outlined, S.fromIngredient),
            ('bank', Icons.bookmark_outline_rounded, S.fromBank),
            ('free', Icons.edit_outlined, S.freeEntry),
          ])
            ListTile(
              leading: Icon(icon),
              title: Text(label),
              onTap: () => Navigator.pop(ctx, key),
            ),
        ],
      ),
    ),
  );
  if (!context.mounted || choice == null) return;
  switch (choice) {
    case 'scan':
      await eatScanned(context, ref);
    case 'product':
      final p = await Navigator.of(context).push<Product>(
        MaterialPageRoute(builder: (_) => const ProductSearchScreen()),
      );
      if (p != null && context.mounted) {
        final link = await ref.read(kitchenProvider).link(p.barcode);
        final catalog = await ref.read(catalogProvider.future);
        final ing = link?.$1 == null
            ? null
            : catalog.ingredients.where((i) => i.id == link!.$1).firstOrNull;
        if (context.mounted) await eatProduct(context, ref, p, ing);
      }
    case 'ingredient':
      final catalog = await ref.read(catalogProvider.future);
      if (!context.mounted) return;
      final ing = await pickIngredient(context, catalog.ingredients);
      if (ing == null || !context.mounted) return;
      final g = await askNumber(context, ing.name, suffix: 'g');
      if (g == null || g <= 0) return;
      await ref
          .read(kitchenActionsProvider)
          .run(
            (k) => k.eat(
              FoodLogEntry(
                date: ref.read(nutritionDayProvider),
                moment: defaultMoment(ref.read(todayProvider)),
                label: ing.name,
                source: LogSource.ingredient,
                ref: ing.id,
                grams: g,
                macros: ing.nutrition?.forGrams(g) ?? Macros.zero,
              ),
              ingredient: ing,
              grams: g,
            ),
          );
    case 'bank':
      await _eatPreset(context, ref);
    case 'free':
      await _freeEntry(context, ref);
  }
}

Future<void> eatScanned(BuildContext context, WidgetRef ref) async {
  final code = await scanOnce(context, ref.read(scannerProvider));
  if (code == null || code.isEmpty || !context.mounted) return;
  final res = await resolveScan(context, ref, code);
  if (res == null || !context.mounted) return;
  await eatProduct(context, ref, res.product, res.ingredient);
}

/// Quantité mangée d'un produit : grammes, portion ou paquet entier.
Future<void> eatProduct(
  BuildContext context,
  WidgetRef ref,
  Product p,
  Ingredient? ingredient,
) async {
  final grams = await showDialog<double>(
    context: context,
    builder: (ctx) {
      final c = TextEditingController();
      return AlertDialog(
        title: Text(p.displayName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: c,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: S.quantityG),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                if (p.servingG != null)
                  ActionChip(
                    label: Text('${S.portion} (${gramsText(p.servingG!)})'),
                    onPressed: () => Navigator.pop(ctx, p.servingG),
                  ),
                if (p.packageQty != null)
                  ActionChip(
                    label: Text(S.wholePackage),
                    onPressed: () => Navigator.pop(ctx, p.packageQty),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(S.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(
              ctx,
              double.tryParse(c.text.trim().replaceAll(',', '.')),
            ),
            child: const Text(S.ok),
          ),
        ],
      );
    },
  );
  if (grams == null || grams <= 0) return;
  await ref
      .read(kitchenActionsProvider)
      .run(
        (k) => k.eat(
          FoodLogEntry(
            date: ref.read(nutritionDayProvider),
            moment: defaultMoment(ref.read(todayProvider)),
            label: p.displayName,
            source: LogSource.product,
            ref: p.barcode,
            grams: grams,
            macros: p.nutrients?.forGrams(grams) ?? Macros.zero,
          ),
          ingredient: ingredient,
          barcode: ingredient == null ? p.barcode : null,
          grams: grams,
        ),
      );
}

Future<void> _eatPreset(BuildContext context, WidgetRef ref) async {
  final presets = await ref.read(presetsProvider.future);
  if (!context.mounted) return;
  final preset = await showModalBottomSheet<MealPreset>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: presets.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(24),
              child: Text(S.mealBankEmpty),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                for (final p in presets)
                  ListTile(
                    title: Text(p.name),
                    onTap: () => Navigator.pop(ctx, p),
                  ),
              ],
            ),
    ),
  );
  if (preset == null) return;
  final catalog = await ref.read(catalogProvider.future);
  final byId = {for (final i in catalog.ingredients) i.id: i};
  await ref
      .read(kitchenActionsProvider)
      .run(
        (k) => k.eat(
          FoodLogEntry(
            date: ref.read(nutritionDayProvider),
            moment:
                preset.defaultMoment ?? defaultMoment(ref.read(todayProvider)),
            label: preset.name,
            source: LogSource.preset,
            ref: '${preset.id}',
            macros: preset.macros(catalog.byId),
          ),
          items: [
            for (final i in preset.items)
              if (byId[i.ingredientId] != null)
                (byId[i.ingredientId]!, i.grams),
          ],
        ),
      );
}

/// Saisie libre ou repas dehors : rien ne sort du stock.
Future<void> _freeEntry(BuildContext context, WidgetRef ref) async {
  final label = TextEditingController();
  final kcal = TextEditingController();
  final p = TextEditingController();
  final c = TextEditingController();
  final f = TextEditingController();
  var moment = defaultMoment(ref.read(todayProvider));
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, set) => AlertDialog(
        title: const Text(S.freeEntry),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Moment>(
                value: moment,
                isExpanded: true,
                items: [
                  for (final m in Moment.values)
                    DropdownMenuItem(value: m, child: Text(S.moment(m.code))),
                ],
                onChanged: (m) => set(() => moment = m ?? moment),
              ),
              TextField(
                controller: label,
                decoration: const InputDecoration(labelText: S.label),
              ),
              for (final (l, ctrl) in [
                (S.kcal, kcal),
                (S.protein, p),
                (S.carbs, c),
                (S.fat, f),
              ])
                TextField(
                  controller: ctrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(labelText: l),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(S.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(S.save),
          ),
        ],
      ),
    ),
  );
  double n(TextEditingController t) =>
      double.tryParse(t.text.trim().replaceAll(',', '.')) ?? 0;
  if (ok != true || n(kcal) <= 0) return;
  await ref
      .read(kitchenActionsProvider)
      .run(
        (k) => k.addLogEntry(
          FoodLogEntry(
            date: ref.read(nutritionDayProvider),
            moment: moment,
            label: label.text.trim().isEmpty ? S.freeEntry : label.text.trim(),
            source: LogSource.free,
            macros: Macros(
              kcal: n(kcal),
              protein: n(p),
              carbs: n(c),
              fat: n(f),
            ),
          ),
        ),
      );
}

class ProductSearchScreen extends ConsumerStatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  ConsumerState<ProductSearchScreen> createState() =>
      _ProductSearchScreenState();
}

class _ProductSearchScreenState extends ConsumerState<ProductSearchScreen> {
  var _results = const <Product>[];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: TextField(
        autofocus: true,
        decoration: const InputDecoration(
          hintText: S.productSearch,
          border: InputBorder.none,
        ),
        onChanged: (v) async {
          final r = await ref.read(kitchenProvider).searchProducts(v);
          if (mounted) setState(() => _results = r);
        },
      ),
    ),
    body: ListView.builder(
      itemCount: _results.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(_results[i].displayName),
        subtitle: Text(
          _results[i].nutrients == null
              ? ''
              : '${kcalText(_results[i].nutrients!.kcal)} / 100 g',
        ),
        onTap: () => Navigator.pop(context, _results[i]),
      ),
    ),
  );
}

// -------------------------------------------------------- activité et pas

class _Activity extends ConsumerWidget {
  const _Activity();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dayActivityProvider).value;
    final sums = ref.watch(summariesProvider(1)).value;
    final weight = sums?.single.$2.weightKg;
    final (workouts, strength, steps) = data ?? (const [], const [], null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(S.sport),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.directions_walk_rounded),
          title: Text(S.stepsTitle),
          subtitle: Text(
            steps == null
                ? '—'
                : '$steps ${S.stepsShort} · '
                      '${kcalText(sums?.single.$2.stepsKcal ?? 0)}',
          ),
          trailing: const Icon(Icons.edit_outlined),
          onTap: () async {
            final v = await askNumber(
              context,
              S.stepsTitle,
              initial: steps?.toDouble(),
            );
            if (v == null) return;
            await ref
                .read(kitchenActionsProvider)
                .run(
                  (k) => k.setSteps(ref.read(nutritionDayProvider), v.round()),
                );
          },
        ),
        Text(S.stepsHint, style: Theme.of(context).textTheme.bodySmall),
        for (final w in workouts)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.fitness_center_rounded),
            title: Text(w.exerciseName),
            subtitle: Text(
              '${formatNumber(w.durationMin)} min · '
              '${S.intensityLabel(w.intensity.code)} · '
              '${kcalText(w.kcal(weight))}',
            ),
            trailing: IconButton(
              tooltip: S.delete,
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => ref
                  .read(kitchenActionsProvider)
                  .run((k) => k.deleteWorkout(w.id!)),
            ),
          ),
        for (final s in strength)
          () {
            final e = estimateStrengthSession(s, weight);
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.sports_gymnastics_rounded),
              title: Text(s.name ?? S.addStrength),
              subtitle: Text(
                '${e.setCount} séries · ${formatNumber(e.volumeKg)} kg · '
                '${formatNumber(e.durationMin)} min · ${kcalText(e.kcal)}',
              ),
              trailing: IconButton(
                tooltip: S.delete,
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: () => ref
                    .read(kitchenActionsProvider)
                    .run((k) => k.deleteStrengthSession(s.id!)),
              ),
            );
          }(),
        Wrap(
          spacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () => _addWorkout(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: const Text(S.addActivity),
            ),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StrengthSessionScreen(),
                ),
              ),
              icon: const Icon(Icons.add_rounded),
              label: const Text(S.addStrength),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProgressionScreen()),
              ),
              child: const Text(S.progression),
            ),
          ],
        ),
      ],
    );
  }
}

Future<void> _addWorkout(BuildContext context, WidgetRef ref) async {
  final all = await ref.read(exercisesProvider.future);
  final cardio = all.where((e) => !e.isStrength).toList();
  if (!context.mounted) return;
  var ex = cardio.first;
  var intensity = Intensity.moderate;
  final dur = TextEditingController(text: '30');
  final kcal = TextEditingController();
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, set) => AlertDialog(
        title: const Text(S.addActivity),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Exercise>(
                value: ex,
                isExpanded: true,
                items: [
                  for (final e in cardio)
                    DropdownMenuItem(value: e, child: Text(e.name)),
                ],
                onChanged: (e) => set(() => ex = e ?? ex),
              ),
              TextField(
                controller: dur,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: S.duration),
              ),
              DropdownButton<Intensity>(
                value: intensity,
                isExpanded: true,
                items: [
                  for (final i in Intensity.values)
                    DropdownMenuItem(
                      value: i,
                      child: Text(S.intensityLabel(i.code)),
                    ),
                ],
                onChanged: (i) => set(() => intensity = i ?? intensity),
              ),
              TextField(
                controller: kcal,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: S.measuredKcal),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(S.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(S.save),
          ),
        ],
      ),
    ),
  );
  final minutes = double.tryParse(dur.text.replaceAll(',', '.'));
  if (ok != true || minutes == null || minutes <= 0) return;
  await ref
      .read(kitchenActionsProvider)
      .run(
        (k) => k.addWorkout(
          Workout(
            date: ref.read(nutritionDayProvider),
            exerciseName: ex.name,
            met: ex.met,
            durationMin: minutes,
            intensity: intensity,
            kcalOverride: double.tryParse(kcal.text.replaceAll(',', '.')),
          ),
        ),
      );
}

class StrengthSessionScreen extends ConsumerStatefulWidget {
  const StrengthSessionScreen({super.key});

  @override
  ConsumerState<StrengthSessionScreen> createState() =>
      _StrengthSessionScreenState();
}

class _StrengthSessionScreenState extends ConsumerState<StrengthSessionScreen> {
  final _sets = <StrengthSet>[];
  final _name = TextEditingController();
  final _duration = TextEditingController();
  final _reps = TextEditingController(text: '10');
  final _load = TextEditingController(text: '0');
  final _rest = TextEditingController(text: '90');
  Exercise? _ex;

  @override
  Widget build(BuildContext context) {
    final exercises = (ref.watch(exercisesProvider).value ?? const [])
        .where((e) => e.isStrength)
        .toList();
    _ex ??= exercises.firstOrNull;
    final weight = ref.watch(summariesProvider(1)).value?.single.$2.weightKg;
    final est = estimateStrengthSession(
      StrengthSession(
        date: DateTime.now(),
        sets: _sets,
        durationMin: double.tryParse(_duration.text.replaceAll(',', '.')),
      ),
      weight,
    );
    return Scaffold(
      appBar: AppBar(title: const Text(S.addStrength)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: S.sessionName),
          ),
          TextField(
            controller: _duration,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: S.duration),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          if (_ex != null)
            DropdownButton<Exercise>(
              value: _ex,
              isExpanded: true,
              items: [
                for (final e in exercises)
                  DropdownMenuItem(
                    value: e,
                    child: Text(
                      '${e.name} · ${muscleGroupLabels[e.muscleGroup] ?? ''}',
                    ),
                  ),
              ],
              onChanged: (e) => setState(() => _ex = e),
            ),
          Row(
            children: [
              for (final (l, c) in [
                (S.reps, _reps),
                (S.load, _load),
                (S.rest, _rest),
              ])
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextField(
                      controller: c,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: l),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _ex == null
                ? null
                : () {
                    final reps = int.tryParse(_reps.text) ?? 0;
                    if (reps <= 0) return;
                    setState(
                      () => _sets.add(
                        StrengthSet(
                          exercise: _ex!.name,
                          setIndex:
                              _sets
                                  .where((s) => s.exercise == _ex!.name)
                                  .length +
                              1,
                          reps: reps,
                          weightKg:
                              double.tryParse(
                                _load.text.replaceAll(',', '.'),
                              ) ??
                              0,
                          restSec: int.tryParse(_rest.text),
                        ),
                      ),
                    );
                  },
            icon: const Icon(Icons.add_rounded),
            label: const Text(S.addSet),
          ),
          for (final s in _sets)
            ListTile(
              title: Text('${s.exercise} · série ${s.setIndex}'),
              subtitle: Text(
                '${s.reps} × ${formatNumber(s.weightKg)} kg · '
                'repos ${s.restSec ?? defaultRestSec} s',
              ),
            ),
          const SizedBox(height: 8),
          Text(
            '${formatNumber(est.volumeKg)} kg · ${formatNumber(est.durationMin)} '
            'min · MET ${formatNumber(est.met)} · ${kcalText(est.kcal)}',
          ),
          const SizedBox(height: 8),
          Text(S.doubleCountHint, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _sets.isEmpty
                ? null
                : () async {
                    await ref
                        .read(kitchenActionsProvider)
                        .run(
                          (k) => k.addStrengthSession(
                            StrengthSession(
                              date: ref.read(nutritionDayProvider),
                              name: _name.text.trim().isEmpty
                                  ? null
                                  : _name.text.trim(),
                              durationMin: double.tryParse(
                                _duration.text.replaceAll(',', '.'),
                              ),
                              sets: _sets,
                            ),
                          ),
                        );
                    if (context.mounted) Navigator.pop(context);
                  },
            child: const Text(S.save),
          ),
        ],
      ),
    );
  }
}

/// Progression par exercice : meilleure série (1RM) et historique.
class ProgressionScreen extends ConsumerWidget {
  const ProgressionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(title: const Text(S.progression)),
    body: FutureBuilder<List<StrengthSession>>(
      future: ref
          .read(kitchenProvider)
          .strengthSessions(DateTime(2000), DateTime(2100)),
      builder: (context, snap) {
        final sessions = snap.data ?? const <StrengthSession>[];
        final byExercise = <String, List<(DateTime, StrengthSet)>>{};
        for (final s in sessions) {
          for (final set in s.sets) {
            (byExercise[set.exercise] ??= []).add((s.date, set));
          }
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final e in byExercise.entries)
              () {
                final best = bestSet(e.value.map((x) => x.$2))!;
                return ExpansionTile(
                  title: Text(e.key),
                  subtitle: Text(
                    S.oneRm(
                      '${formatNumber(estimatedOneRepMax(best.weightKg, best.reps))} kg',
                    ),
                  ),
                  children: [
                    for (final (d, s) in e.value.reversed)
                      ListTile(
                        title: Text(formatDate(d)),
                        subtitle: Text(
                          '${s.reps} × ${formatNumber(s.weightKg)} kg',
                        ),
                      ),
                  ],
                );
              }(),
          ],
        );
      },
    ),
  );
}

// ---------------------------------------------------------------- pesées

class _Weights extends ConsumerWidget {
  const _Weights();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weights = ref.watch(weightsProvider).value ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          S.weights,
          trailing: TextButton(
            onPressed: () async {
              final w = await askNumber(context, S.weighIn, suffix: 'kg');
              if (w == null || w < 30 || w > 300) return;
              await ref
                  .read(kitchenActionsProvider)
                  .run(
                    (k) => k.addWeight(
                      WeightPoint(
                        date: ref.read(nutritionDayProvider),
                        weightKg: w,
                      ),
                    ),
                  );
            },
            child: const Text(S.weighIn),
          ),
        ),
        for (final w in weights.reversed.take(5))
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('${formatNumber(w.weightKg)} kg'),
            subtitle: Text(formatDate(w.date)),
            trailing: IconButton(
              tooltip: S.delete,
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => ref
                  .read(kitchenActionsProvider)
                  .run((k) => k.deleteWeight(w.id!)),
            ),
          ),
      ],
    );
  }
}

// ------------------------------------------------------ bilan 7 / 30 jours

class _History extends ConsumerStatefulWidget {
  const _History();

  @override
  ConsumerState<_History> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<_History> {
  var _days = 7;

  @override
  Widget build(BuildContext context) {
    final sums = ref.watch(summariesProvider(_days)).value ?? const [];
    final scheme = Theme.of(context).colorScheme;
    final nets = [for (final s in sums) s.$2.balance?.netKcal];
    final maxAbs = nets.whereType<double>().fold<double>(
      100,
      (m, v) => max(m, v.abs()),
    );
    final cumul = cumulativeNetKcal(sums.map((s) => s.$2));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          S.balance,
          trailing: SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 7, label: Text(S.chart7)),
              ButtonSegment(value: 30, label: Text(S.chart30)),
            ],
            selected: {_days},
            onSelectionChanged: (s) => setState(() => _days = s.first),
          ),
        ),
        Semantics(
          label: cumul == null ? S.balance : S.cumulative(signedKcal(cumul)),
          child: SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final v in nets)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: v != null && v > 0
                                    ? v / maxAbs
                                    : 0,
                                child: Container(color: scheme.tertiary),
                              ),
                            ),
                          ),
                          Container(height: 1, color: scheme.outline),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: FractionallySizedBox(
                                heightFactor: v != null && v < 0
                                    ? -v / maxAbs
                                    : 0,
                                child: Container(color: scheme.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (cumul != null) ...[
          const SizedBox(height: 8),
          Text(S.cumulative(signedKcal(cumul))),
          Text(
            S.projection('${formatNumber(projectedWeightChangeKg(cumul))} kg'),
          ),
        ],
      ],
    );
  }
}

// --------------------------------------------------------- profil nutrition

Future<void> editNutritionProfile(BuildContext context, WidgetRef ref) async {
  final k = ref.read(kitchenProvider);
  final p = await k.nutritionProfile();
  final goals = await k.goals();
  final current = goalOnDay(goals, ref.read(todayProvider));
  if (!context.mounted) return;
  var sex = p?.sex ?? Sex.male;
  var activity = p?.activity ?? ActivityLevel.moderate;
  var goal = current?.kind ?? GoalKind.maintain;
  final birth = TextEditingController(
    text: p == null
        ? ''
        : '${p.birthDate.year}-${p.birthDate.month.toString().padLeft(2, '0')}'
              '-${p.birthDate.day.toString().padLeft(2, '0')}',
  );
  final height = TextEditingController(
    text: p == null ? '' : formatNumber(p.heightCm),
  );
  final weight = TextEditingController();
  final delta = TextEditingController(
    text: formatNumber(current?.dailyKcalDelta ?? goal.defaultDelta),
  );
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, set) => AlertDialog(
        title: const Text(S.nutritionProfile),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SegmentedButton<Sex>(
                segments: const [
                  ButtonSegment(value: Sex.male, label: Text(S.male)),
                  ButtonSegment(value: Sex.female, label: Text(S.female)),
                ],
                selected: {sex},
                onSelectionChanged: (s) => set(() => sex = s.first),
              ),
              TextField(
                controller: birth,
                decoration: const InputDecoration(labelText: S.birthDate),
              ),
              TextField(
                controller: height,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: S.heightCm),
              ),
              if (p == null)
                TextField(
                  controller: weight,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: S.weightKg),
                ),
              const SizedBox(height: 8),
              Text(S.activity),
              DropdownButton<ActivityLevel>(
                value: activity,
                isExpanded: true,
                items: [
                  for (final a in ActivityLevel.values)
                    DropdownMenuItem(
                      value: a,
                      child: Text(S.activityLabel(a.code)),
                    ),
                ],
                onChanged: (a) => set(() => activity = a ?? activity),
              ),
              Text(S.goal),
              DropdownButton<GoalKind>(
                value: goal,
                isExpanded: true,
                items: [
                  for (final g in GoalKind.values)
                    DropdownMenuItem(
                      value: g,
                      child: Text(S.goalLabel(g.code)),
                    ),
                ],
                onChanged: (g) => set(() {
                  goal = g ?? goal;
                  delta.text = formatNumber(goal.defaultDelta);
                }),
              ),
              TextField(
                controller: delta,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                decoration: const InputDecoration(labelText: S.goalDelta),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(S.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(S.save),
          ),
        ],
      ),
    ),
  );
  if (ok != true) return;
  final b = DateTime.tryParse(birth.text.trim());
  final h = double.tryParse(height.text.replaceAll(',', '.'));
  if (b == null || h == null || h < 100 || h > 250) return;
  final today = ref.read(todayProvider);
  await ref.read(kitchenActionsProvider).run((k) async {
    await k.saveNutritionProfile(
      NutritionProfile(sex: sex, birthDate: b, heightCm: h, activity: activity),
    );
    final w = double.tryParse(weight.text.replaceAll(',', '.'));
    if (w != null && w >= 30 && w <= 300) {
      await k.addWeight(WeightPoint(date: today, weightKg: w));
    }
    final d =
        double.tryParse(delta.text.replaceAll(',', '.').replaceAll('−', '-')) ??
        goal.defaultDelta;
    if (current == null ||
        current.kind != goal ||
        current.dailyKcalDelta != d) {
      await k.addGoal(Goal(startDate: today, kind: goal, dailyKcalDelta: d));
    }
  });
}
