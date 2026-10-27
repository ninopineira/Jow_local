import 'package:flutter/material.dart';

import '../domain/enums.dart';
import '../domain/models.dart';
import 'strings.dart';
import 'widgets.dart';

/// Sections du profil du foyer (SPEC §3.1), partagées entre le premier
/// lancement et les réglages.
typedef ProfileChanged = void Function(HouseholdProfile);

class PeopleSection extends StatelessWidget {
  const PeopleSection({
    super.key,
    required this.profile,
    required this.onChanged,
  });
  final HouseholdProfile profile;
  final ProfileChanged onChanged;

  @override
  Widget build(BuildContext context) => Center(
    child: CountStepper(
      label: S.stepPeople,
      value: profile.people,
      min: 1,
      max: 12,
      format: S.people,
      onChanged: (v) => onChanged(profile.copyWith(people: v)),
    ),
  );
}

class DietSection extends StatelessWidget {
  const DietSection({
    super.key,
    required this.profile,
    required this.onChanged,
  });
  final HouseholdProfile profile;
  final ProfileChanged onChanged;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      RadioGroup<Diet>(
        groupValue: profile.diet,
        onChanged: (d) => onChanged(profile.copyWith(diet: d)),
        child: Column(
          children: [
            for (final d in Diet.values)
              RadioListTile<Diet>(
                value: d,
                title: Text(S.diet(d)),
                subtitle: d == Diet.flexitarian
                    ? const Text(S.flexitarianHint)
                    : null,
              ),
          ],
        ),
      ),
      SwitchListTile(
        title: const Text(S.noPork),
        value: profile.noPork,
        onChanged: (v) => onChanged(profile.copyWith(noPork: v)),
      ),
    ],
  );
}

class AllergySection extends StatelessWidget {
  const AllergySection({
    super.key,
    required this.profile,
    required this.onChanged,
  });
  final HouseholdProfile profile;
  final ProfileChanged onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final a in Allergen.values)
            FilterChip(
              label: Text(S.allergen(a)),
              selected: profile.exclusions.contains(a),
              onSelected: (on) {
                final s = {...profile.exclusions};
                on ? s.add(a) : s.remove(a);
                onChanged(profile.copyWith(exclusions: s));
              },
            ),
        ],
      ),
      const SizedBox(height: 16),
      const LabelWarning(),
    ],
  );
}

class LabelWarning extends StatelessWidget {
  const LabelWarning({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_rounded, color: scheme.onSecondaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              S.allergyWarning,
              style: TextStyle(color: scheme.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class AversionSection extends StatefulWidget {
  const AversionSection({
    super.key,
    required this.profile,
    required this.onChanged,
    required this.ingredients,
  });
  final HouseholdProfile profile;
  final ProfileChanged onChanged;
  final List<Ingredient> ingredients;

  @override
  State<AversionSection> createState() => _AversionSectionState();
}

class _AversionSectionState extends State<AversionSection> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final byId = {for (final i in widget.ingredients) i.id: i};
    final q = normalize(query);
    final matches = q.isEmpty
        ? const <Ingredient>[]
        : widget.ingredients
              .where((i) => normalize(i.name).contains(q))
              .where((i) => !widget.profile.aversions.contains(i.id))
              .take(8)
              .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            labelText: S.aversionHint,
          ),
          onChanged: (v) => setState(() => query = v),
        ),
        for (final i in matches)
          ListTile(
            title: Text(i.name),
            trailing: const Icon(Icons.add_rounded),
            onTap: () {
              widget.onChanged(
                widget.profile.copyWith(
                  aversions: {...widget.profile.aversions, i.id},
                ),
              );
              setState(() => query = '');
            },
          ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final id in widget.profile.aversions)
              InputChip(
                label: Text(byId[id]?.name ?? id),
                onDeleted: () => widget.onChanged(
                  widget.profile.copyWith(
                    aversions: {...widget.profile.aversions}..remove(id),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class EquipmentSection extends StatelessWidget {
  const EquipmentSection({
    super.key,
    required this.profile,
    required this.onChanged,
  });
  final HouseholdProfile profile;
  final ProfileChanged onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final e in Equipment.values)
        FilterChip(
          label: Text(S.equipment(e)),
          selected: profile.equipment.contains(e),
          onSelected: (on) {
            final s = {...profile.equipment};
            on ? s.add(e) : s.remove(e);
            onChanged(profile.copyWith(equipment: s));
          },
        ),
    ],
  );
}

class SlotsSection extends StatelessWidget {
  const SlotsSection({
    super.key,
    required this.profile,
    required this.onChanged,
  });
  final HouseholdProfile profile;
  final ProfileChanged onChanged;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge;
    return Table(
      columnWidths: const {0: FlexColumnWidth(2)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            const SizedBox(),
            Center(child: Text(S.lunch, style: style)),
            Center(child: Text(S.dinner, style: style)),
          ],
        ),
        for (var d = 0; d < 7; d++)
          TableRow(
            children: [
              Text(S.weekdayCap((profile.weekStartDay - 1 + d) % 7 + 1)),
              for (final m in Meal.values)
                Checkbox(
                  semanticLabel:
                      '${S.weekdayCap((profile.weekStartDay - 1 + d) % 7 + 1)} ${S.meal(m)}',
                  value: profile.activeSlots.contains(SlotKey(d, m)),
                  onChanged: (on) {
                    final s = {...profile.activeSlots};
                    on == true ? s.add(SlotKey(d, m)) : s.remove(SlotKey(d, m));
                    onChanged(profile.copyWith(activeSlots: s));
                  },
                ),
            ],
          ),
      ],
    );
  }
}

class TimesSection extends StatelessWidget {
  const TimesSection({
    super.key,
    required this.profile,
    required this.onChanged,
  });
  final HouseholdProfile profile;
  final ProfileChanged onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('${S.maxWeekday} ${S.minutesValue(profile.maxMinWeekday)}'),
      Slider(
        value: profile.maxMinWeekday.toDouble(),
        min: 10,
        max: 120,
        divisions: 22,
        label: S.minutesValue(profile.maxMinWeekday),
        semanticFormatterCallback: (v) => S.minutesValue(v.round()),
        onChanged: (v) => onChanged(profile.copyWith(maxMinWeekday: v.round())),
      ),
      Text('${S.maxWeekend} ${S.minutesValue(profile.maxMinWeekend)}'),
      Slider(
        value: profile.maxMinWeekend.toDouble(),
        min: 10,
        max: 240,
        divisions: 46,
        label: S.minutesValue(profile.maxMinWeekend),
        semanticFormatterCallback: (v) => S.minutesValue(v.round()),
        onChanged: (v) => onChanged(profile.copyWith(maxMinWeekend: v.round())),
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField<int>(
        isExpanded: true,
        initialValue: profile.weekStartDay,
        decoration: const InputDecoration(labelText: S.weekStart),
        items: [
          for (var d = 1; d <= 7; d++)
            DropdownMenuItem(value: d, child: Text(S.weekdayCap(d))),
        ],
        onChanged: (v) => onChanged(profile.copyWith(weekStartDay: v)),
      ),
    ],
  );
}

/// Recherche insensible aux accents et à la casse.
String normalize(String s) {
  const from = 'àâäáãéèêëíìîïóòôöõúùûüçñœ';
  const to = 'aaaaaeeeeiiiiooooouuuucno';
  final b = StringBuffer();
  for (final ch in s.toLowerCase().split('')) {
    final i = from.indexOf(ch);
    b.write(i >= 0 ? to[i] : ch);
  }
  return b.toString().trim();
}
