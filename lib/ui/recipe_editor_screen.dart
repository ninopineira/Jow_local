import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/diet.dart';
import '../domain/enums.dart';
import '../domain/models.dart';
import '../domain/nutrition.dart';
import '../domain/quantities.dart' show formatNumber;

import 'product_flow.dart';
import 'profile_sections.dart';
import 'providers.dart';
import 'scanner.dart';
import 'strings.dart';
import 'v2_providers.dart';
import 'widgets.dart';

/// Ligne d'ingrédient en cours d'édition.
class _Line {
  _Line(
    this.ingredient, {
    this.qty = '',
    Unit? unit,
    this.optional = false,
    this.note = '',
  }) : unit = unit ?? ingredient.defaultUnit;

  Ingredient ingredient;
  String qty;
  Unit unit;
  bool optional;
  String note;
}

/// Éditeur de recette perso (SPEC §3.3). Régime et allergènes sont calculés.
class RecipeEditorScreen extends ConsumerStatefulWidget {
  const RecipeEditorScreen({super.key, this.recipeId});

  final int? recipeId;

  @override
  ConsumerState<RecipeEditorScreen> createState() => _RecipeEditorScreenState();
}

class _RecipeEditorScreenState extends ConsumerState<RecipeEditorScreen> {
  final title = TextEditingController();
  final description = TextEditingController();
  var servings = 4;
  var prep = 15;
  var cook = 15;
  var type = RecipeType.main;
  var difficulty = Difficulty.easy;
  var base = MainBase.vegetables;
  var equipment = <Equipment>{Equipment.hob};
  final lines = <_Line>[];
  final steps = <TextEditingController>[TextEditingController()];
  String? photo;
  Recipe? original;
  var loaded = false;

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    for (final s in steps) {
      s.dispose();
    }
    super.dispose();
  }

  void _load(Catalog c) {
    if (loaded) return;
    loaded = true;
    final r = widget.recipeId == null ? null : c.byId[widget.recipeId];
    if (r == null) return;
    original = r;
    title.text = r.title;
    description.text = r.description;
    servings = r.servings;
    prep = r.prepMin;
    cook = r.cookMin;
    type = r.type;
    difficulty = r.difficulty;
    base = r.mainBase;
    equipment = {...r.equipment};
    photo = r.photoPath;
    lines.addAll([
      for (final l in r.ingredients)
        _Line(
          l.ingredient,
          qty: _fmt(l.qty),
          unit: l.unit,
          optional: l.optional,
          note: l.note ?? '',
        ),
    ]);
    steps
      ..clear()
      ..addAll([for (final s in r.steps) TextEditingController(text: s)]);
  }

  String _fmt(double v) => v == v.roundToDouble()
      ? v.toInt().toString()
      : v.toString().replaceAll('.', ',');

  Recipe _build() => Recipe(
    id: original?.id ?? 0,
    title: title.text.trim(),
    description: description.text.trim(),
    type: type,
    servings: servings,
    prepMin: prep,
    cookMin: cook,
    difficulty: difficulty,
    equipment: equipment,
    mainBase: base,
    origin: Origin.personal,
    photoPath: photo,
    createdAt: original?.createdAt,
    updatedAt: DateTime.now(),
    ingredients: [
      for (final l in lines)
        RecipeIngredient(
          ingredient: l.ingredient,
          qty: double.tryParse(l.qty.replaceAll(',', '.')) ?? 1,
          unit: l.unit,
          optional: l.optional,
          note: l.note.trim().isEmpty ? null : l.note.trim(),
        ),
    ],
    steps: [
      for (final s in steps)
        if (s.text.trim().isNotEmpty) s.text.trim(),
    ],
  );

  Future<void> _save() async {
    final r = _build();
    final error = r.title.isEmpty
        ? S.titleRequired
        : r.ingredients.isEmpty
        ? S.ingredientsRequired
        : r.steps.isEmpty
        ? S.stepsRequired
        : null;
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    final id = await ref.read(actionsProvider).saveRecipe(r);
    if (!mounted) return;
    if (original == null) {
      context.pushReplacement('/recipes/$id');
    } else {
      context.pop();
    }
  }

  Future<void> _pickPhoto(bool camera) async {
    final store = ref.read(photoStoreProvider);
    final name =
        'photo-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(1 << 20)}.jpg';
    await store.dir.create(recursive: true);
    final ok = await ref
        .read(platformProvider)
        .pickImage(camera: camera, destPath: store.file(name).path);
    if (ok && mounted) setState(() => photo = name);
  }

  Future<void> _addIngredient(List<Ingredient> all) async {
    final picked = await showModalBottomSheet<Ingredient>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _IngredientSearch(all: all),
    );
    if (picked != null) setState(() => lines.add(_Line(picked)));
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(catalogProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeId == null ? S.editorNew : S.editorEdit),
        actions: [
          TextButton(
            key: const Key('save-recipe'),
            onPressed: _save,
            child: const Text(S.save),
          ),
        ],
      ),
      body: AsyncBody(
        value: catalog,
        builder: (c) {
          _load(c);
          final traits = computeTraits(lines.map((l) => l.ingredient));
          final store = ref.read(photoStoreProvider);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                key: const Key('recipe-title'),
                controller: title,
                decoration: const InputDecoration(labelText: S.title),
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: description,
                decoration: const InputDecoration(labelText: S.description),
                maxLength: 200,
              ),
              SectionTitle(S.photo),
              if (photo != null && fileExists(store.file(photo!).path))
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    store.file(photo!),
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              Wrap(
                spacing: 8,
                children: [
                  TextButton.icon(
                    onPressed: () => _pickPhoto(true),
                    icon: const Icon(Icons.photo_camera_rounded),
                    label: const Text(S.takePhoto),
                  ),
                  TextButton.icon(
                    onPressed: () => _pickPhoto(false),
                    icon: const Icon(Icons.photo_library_rounded),
                    label: const Text(S.pickPhoto),
                  ),
                  if (photo != null)
                    TextButton.icon(
                      onPressed: () => setState(() => photo = null),
                      icon: const Icon(Icons.hide_image_rounded),
                      label: const Text(S.removePhoto),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(S.baseServings),
                trailing: CountStepper(
                  label: S.baseServings,
                  value: servings,
                  onChanged: (v) => setState(() => servings = v),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(S.prepMin),
                trailing: CountStepper(
                  label: S.prepMin,
                  value: prep,
                  min: 0,
                  max: 240,
                  format: S.minutesValue,
                  onChanged: (v) => setState(() => prep = v),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(S.cookMin),
                trailing: CountStepper(
                  label: S.cookMin,
                  value: cook,
                  min: 0,
                  max: 480,
                  format: S.minutesValue,
                  onChanged: (v) => setState(() => cook = v),
                ),
              ),
              const SizedBox(height: 8),
              _dropdown<RecipeType>(
                S.type,
                type,
                RecipeType.values,
                S.recipeType,
                (v) => type = v,
              ),
              _dropdown<Difficulty>(
                S.difficultyLabel,
                difficulty,
                Difficulty.values,
                S.difficulty,
                (v) => difficulty = v,
              ),
              _dropdown<MainBase>(
                S.mainBaseLabel,
                base,
                MainBase.values,
                S.mainBase,
                (v) => base = v,
              ),
              SectionTitle(S.equipmentTitle),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final e in Equipment.values)
                    FilterChip(
                      label: Text(S.equipment(e)),
                      selected: equipment.contains(e),
                      onSelected: (on) => setState(
                        () => on ? equipment.add(e) : equipment.remove(e),
                      ),
                    ),
                ],
              ),
              SectionTitle(
                S.ingredients,
                trailing: IconButton(
                  key: const Key('add-ingredient'),
                  tooltip: S.addIngredient,
                  icon: const Icon(Icons.add_circle_rounded),
                  onPressed: () => _addIngredient(c.ingredients),
                ),
              ),
              for (var i = 0; i < lines.length; i++) _lineEditor(i),
              Text(
                '${S.computedDiet} : '
                '${[for (final d in Diet.values)
                  if (traits.diets.contains(d)) S.diet(d)].join(', ')}'
                '${traits.allergens.isEmpty ? '' : ' — ${S.allergensTitle.toLowerCase()} : ${traits.allergens.map(S.allergen).join(', ')}'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SectionTitle(
                S.steps,
                trailing: IconButton(
                  tooltip: S.addStep,
                  icon: const Icon(Icons.add_circle_rounded),
                  onPressed: () =>
                      setState(() => steps.add(TextEditingController())),
                ),
              ),
              for (var i = 0; i < steps.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    key: Key('step-$i'),
                    controller: steps[i],
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: S.stepLabel(i + 1),
                      suffixIcon: steps.length > 1
                          ? IconButton(
                              tooltip: S.delete,
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () =>
                                  setState(() => steps.removeAt(i).dispose()),
                            )
                          : null,
                    ),
                  ),
                ),
              const SizedBox(height: 48),
            ],
          );
        },
      ),
    );
  }

  Widget _dropdown<T>(
    String label,
    T value,
    List<T> values,
    String Function(T) text,
    void Function(T) set,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<T>(
      isExpanded: true,
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final v in values)
          DropdownMenuItem(value: v, child: Text(text(v))),
      ],
      onChanged: (v) {
        if (v != null) setState(() => set(v));
      },
    ),
  );

  Widget _lineEditor(int i) {
    final l = lines[i];
    return Card(
      key: ObjectKey(l),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l.ingredient.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  tooltip: S.delete,
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () => setState(() => lines.removeAt(i)),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: Key('qty-$i'),
                    initialValue: l.qty,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(labelText: S.quantity),
                    onChanged: (v) => l.qty = v,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<Unit>(
                    isExpanded: true,
                    initialValue: l.unit,
                    decoration: const InputDecoration(labelText: S.unitLabel),
                    items: [
                      for (final u in Unit.values)
                        DropdownMenuItem(value: u, child: Text(S.unit(u))),
                    ],
                    onChanged: (u) => setState(() => l.unit = u ?? l.unit),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: l.note,
              decoration: const InputDecoration(labelText: S.note),
              onChanged: (v) => l.note = v,
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(S.optional),
              value: l.optional,
              onChanged: (v) => setState(() => l.optional = v ?? false),
            ),
          ],
        ),
      ),
    );
  }
}

/// Autocomplétion sur le catalogue, avec création d'un ingrédient perso.
class _IngredientSearch extends ConsumerStatefulWidget {
  const _IngredientSearch({required this.all});
  final List<Ingredient> all;

  @override
  ConsumerState<_IngredientSearch> createState() => _IngredientSearchState();
}

class _IngredientSearchState extends ConsumerState<_IngredientSearch> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final q = normalize(query);
    final matches = q.isEmpty
        ? const <Ingredient>[]
        : widget.all
              .where((i) => normalize(i.name).contains(q))
              .take(20)
              .toList();
    final exact = widget.all.any((i) => normalize(i.name) == q);
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('ingredient-search'),
            autofocus: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              labelText: S.aversionHint,
            ),
            onChanged: (v) => setState(() => query = v),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 360),
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final i in matches)
                  ListTile(
                    title: Text(i.name),
                    subtitle: Text(S.aisle(i.aisle)),
                    onTap: () => Navigator.pop(context, i),
                  ),
                if (q.isNotEmpty && !exact)
                  ListTile(
                    leading: const Icon(Icons.add_rounded),
                    title: Text(S.createIngredient(query.trim())),
                    onTap: () async {
                      final created = await showDialog<Ingredient>(
                        context: context,
                        builder: (_) => NewIngredientDialog(name: query.trim()),
                      );
                      if (created != null && context.mounted) {
                        Navigator.pop(context, created);
                      }
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Création d'un ingrédient perso avec son rayon et ses marqueurs.
class NewIngredientDialog extends ConsumerStatefulWidget {
  const NewIngredientDialog({super.key, required this.name});
  final String name;

  @override
  ConsumerState<NewIngredientDialog> createState() =>
      _NewIngredientDialogState();
}

class _NewIngredientDialogState extends ConsumerState<NewIngredientDialog> {
  late final name = TextEditingController(text: widget.name);
  final weight = TextEditingController();
  var aisle = Aisle.savory;
  var unit = Unit.g;
  var pantry = false;
  var perishable = false;
  final markers = <Marker>{};
  final allergens = <Allergen>{};
  // V2 (SPEC-V2 §4) : valeurs pour 100 g, saisies ou reprises.
  final kcal = TextEditingController();
  final protein = TextEditingController();
  final carbs = TextEditingController();
  final fat = TextEditingController();
  String? ciqualCode;

  @override
  void dispose() {
    name.dispose();
    weight.dispose();
    for (final c in [kcal, protein, carbs, fat]) {
      c.dispose();
    }
    super.dispose();
  }

  void _fill(Nutrients n, {String? ciqual}) => setState(() {
    kcal.text = formatNumber(n.kcal);
    protein.text = formatNumber(n.protein);
    carbs.text = formatNumber(n.carbs);
    fat.text = formatNumber(n.fat);
    ciqualCode = ciqual;
  });

  double? _n(TextEditingController c) =>
      double.tryParse(c.text.trim().replaceAll(',', '.'));

  Nutrients? get _nutrients => _n(kcal) == null
      ? null
      : Nutrients(
          kcal: _n(kcal)!,
          protein: _n(protein) ?? 0,
          carbs: _n(carbs) ?? 0,
          fat: _n(fat) ?? 0,
        );

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text(S.newIngredient),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: S.name),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<Aisle>(
            isExpanded: true,
            initialValue: aisle,
            decoration: const InputDecoration(labelText: S.aisleLabel),
            items: [
              for (final a in Aisle.values)
                DropdownMenuItem(value: a, child: Text(S.aisle(a))),
            ],
            onChanged: (v) => setState(() => aisle = v ?? aisle),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<Unit>(
            isExpanded: true,
            initialValue: unit,
            decoration: const InputDecoration(labelText: S.unitLabel),
            items: [
              for (final u in Unit.values)
                DropdownMenuItem(value: u, child: Text(S.unit(u))),
            ],
            onChanged: (v) => setState(() => unit = v ?? unit),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: weight,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: S.pieceWeight),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(S.pantry),
            value: pantry,
            onChanged: (v) => setState(() => pantry = v ?? false),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(S.perishable),
            value: perishable,
            onChanged: (v) => setState(() => perishable = v ?? false),
          ),
          SectionTitle(S.productPer100),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton(
                onPressed: () async {
                  final all = (await ref.read(catalogProvider.future))
                      .ingredients
                      .where((i) => i.nutrition != null)
                      .toList();
                  if (!context.mounted) return;
                  final i = await pickIngredient(context, all);
                  if (i != null) _fill(i.nutrition!, ciqual: i.ciqualCode);
                },
                child: const Text(S.nutritionFromCatalogue),
              ),
              OutlinedButton(
                onPressed: () async {
                  final code = await scanOnce(
                    context,
                    ref.read(scannerProvider),
                  );
                  if (code == null || code.isEmpty) return;
                  final pr = await ref.read(kitchenProvider).product(code);
                  if (pr?.nutrients != null) _fill(pr!.nutrients!);
                },
                child: const Text(S.nutritionFromProduct),
              ),
            ],
          ),
          for (final (label, c) in [
            (S.kcal, kcal),
            (S.protein, protein),
            (S.carbs, carbs),
            (S.fat, fat),
          ])
            TextField(
              controller: c,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: label),
            ),
          SectionTitle(S.markers),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final m in Marker.values)
                FilterChip(
                  label: Text(S.marker(m)),
                  selected: markers.contains(m),
                  onSelected: (on) =>
                      setState(() => on ? markers.add(m) : markers.remove(m)),
                ),
            ],
          ),
          SectionTitle(S.allergensTitle),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final a in Allergen.values)
                FilterChip(
                  label: Text(S.allergen(a)),
                  selected: allergens.contains(a),
                  onSelected: (on) => setState(
                    () => on ? allergens.add(a) : allergens.remove(a),
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(S.cancel),
      ),
      FilledButton(
        onPressed: () async {
          if (name.text.trim().isEmpty) return;
          final m = {...markers};
          if (m.contains(Marker.pork) || m.contains(Marker.poultry)) {
            m.add(Marker.meat);
          }
          final created = await ref
              .read(actionsProvider)
              .createIngredient(
                Ingredient(
                  id: '',
                  name: name.text.trim(),
                  aisle: aisle,
                  defaultUnit: unit,
                  avgPieceWeightG: double.tryParse(
                    weight.text.replaceAll(',', '.'),
                  ),
                  pantry: pantry,
                  perishable: perishable,
                  markers: m,
                  allergens: allergens,
                  origin: Origin.personal,
                  nutrition: _nutrients,
                  ciqualCode: ciqualCode,
                ),
              );
          if (context.mounted) Navigator.pop(context, created);
        },
        child: const Text(S.save),
      ),
    ],
  );
}
