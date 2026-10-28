import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/backup.dart';
import '../domain/enums.dart';
import '../domain/models.dart';
import 'profile_sections.dart';
import 'settings_v2.dart';
import 'providers.dart';
import 'strings.dart';
import 'widgets.dart';

/// Onglet Réglages (SPEC §3.9).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(S.settingsTitle)),
      body: AsyncBody(
        value: profile,
        builder: (p) {
          final actions = ref.read(actionsProvider);
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              ListTile(
                leading: const Icon(Icons.groups_rounded),
                title: const Text(S.householdProfile),
                subtitle: Text('${S.people(p.people)} · ${S.diet(p.diet)}'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.push('/settings/profile'),
              ),
              ListTile(
                title: const Text(S.favoriteShare),
                subtitle: Slider(
                  value: p.favoriteShare,
                  divisions: 10,
                  label: '${(p.favoriteShare * 100).round()} %',
                  semanticFormatterCallback: (v) => '${(v * 100).round()} %',
                  onChanged: (v) =>
                      actions.saveProfile(p.copyWith(favoriteShare: v)),
                ),
              ),
              ListTile(
                title: const Text(S.antiRepeat),
                subtitle: Text(S.weeks(p.antiRepeatWeeks)),
                trailing: SizedBox(
                  width: 200,
                  child: Slider(
                    value: p.antiRepeatWeeks.toDouble(),
                    max: 6,
                    divisions: 6,
                    label: S.weeks(p.antiRepeatWeeks),
                    semanticFormatterCallback: (v) => S.weeks(v.round()),
                    onChanged: (v) => actions.saveProfile(
                      p.copyWith(antiRepeatWeeks: v.round()),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.storefront_rounded),
                title: const Text(S.aisleOrder),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.push('/settings/aisles'),
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_rounded),
                title: const Text(S.themeLabel),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SegmentedButton<ThemePreference>(
                    segments: [
                      for (final t in ThemePreference.values)
                        ButtonSegment(value: t, label: Text(S.theme(t))),
                    ],
                    selected: {p.theme},
                    onSelectionChanged: (s) =>
                        actions.saveProfile(p.copyWith(theme: s.first)),
                  ),
                ),
              ),
              const SectionTitle(S.data),
              ListTile(
                leading: const Icon(Icons.upload_file_rounded),
                title: const Text(S.export),
                subtitle: const Text(S.exportHint),
                onTap: () => _export(context, ref),
              ),
              ListTile(
                leading: const Icon(Icons.download_rounded),
                title: const Text(S.import),
                onTap: () => _import(context, ref),
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever_rounded),
                title: const Text(S.reset),
                onTap: () => _reset(context, ref),
              ),
              const Divider(),
              const ProductDbTile(),
              const StockWeightTile(),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text(S.about),
                onTap: () => context.push('/settings/about'),
              ),
            ],
          );
        },
      ),
    );
  }

  BackupService _backup(WidgetRef ref) =>
      BackupService(ref.read(repositoryProvider), ref.read(photoStoreProvider));

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final bytes = await _backup(ref).exportZip();
    final now = DateTime.now();
    final name = 'popote-${weekCode(now)}.zip';
    final ok = await ref
        .read(platformProvider)
        .saveDocument(name, 'application/zip', bytes);
    if (ok && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(S.exportDone)));
    }
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final bytes = await ref.read(platformProvider).openDocument();
    if (bytes == null || !context.mounted) return;
    final service = _backup(ref);
    ImportPreview preview;
    try {
      preview = service.preview(bytes);
    } on Object {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(S.importError)));
      }
      return;
    }
    final mode = await showDialog<ImportMode>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text(S.importPreview),
        content: Text(
          S.importSummary(
            preview.personalRecipes,
            preview.favorites,
            preview.menus,
            preview.hasProfile,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(d),
            child: const Text(S.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(d, ImportMode.replace),
            child: const Text(S.replaceAll),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(d, ImportMode.merge),
            child: const Text(S.merge),
          ),
        ],
      ),
    );
    if (mode == null) return;
    await service.apply(preview, mode);
    ref.read(actionsProvider).refresh();
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(S.importDone)));
    }
  }

  Future<void> _reset(BuildContext context, WidgetRef ref) async {
    Future<bool> confirm(String title, String body) async =>
        await showDialog<bool>(
          context: context,
          builder: (d) => AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(d, false),
                child: const Text(S.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(d, true),
                child: const Text(S.delete),
              ),
            ],
          ),
        ) ??
        false;
    if (!await confirm(S.resetConfirm1, S.resetConfirm1Body)) return;
    if (!context.mounted ||
        !await confirm(S.resetConfirm2, S.resetConfirm2Body)) {
      return;
    }
    await ref.read(actionsProvider).resetAll();
    if (context.mounted) context.go('/onboarding');
  }
}

/// Modification du profil du foyer.
class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  HouseholdProfile? profile;

  @override
  Widget build(BuildContext context) {
    final stored = ref.watch(profileProvider).value;
    final catalog = ref.watch(catalogProvider).value;
    final p = profile ?? stored;
    void update(HouseholdProfile v) => setState(() => profile = v);
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.householdProfile),
        actions: [
          TextButton(
            onPressed: profile == null
                ? null
                : () async {
                    await ref.read(actionsProvider).saveProfile(profile!);
                    if (context.mounted) context.pop();
                  },
            child: const Text(S.save),
          ),
        ],
      ),
      body: p == null || catalog == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SectionTitle(S.stepPeople),
                PeopleSection(profile: p, onChanged: update),
                const SectionTitle(S.stepDiet),
                DietSection(profile: p, onChanged: update),
                const SectionTitle(S.stepAllergies),
                AllergySection(profile: p, onChanged: update),
                const SectionTitle(S.stepAversions),
                AversionSection(
                  profile: p,
                  onChanged: update,
                  ingredients: catalog.ingredients,
                ),
                const SectionTitle(S.stepEquipment),
                EquipmentSection(profile: p, onChanged: update),
                const SectionTitle(S.stepSlots),
                SlotsSection(profile: p, onChanged: update),
                const SectionTitle(S.stepTimes),
                TimesSection(profile: p, onChanged: update),
              ],
            ),
    );
  }
}

/// Ordre des rayons de la liste.
class AisleOrderScreen extends ConsumerWidget {
  const AisleOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = ref.watch(profileProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text(S.aisleOrder)),
      body: p == null
          ? const SizedBox()
          : ReorderableListView(
              padding: const EdgeInsets.all(16),
              onReorderItem: (from, to) {
                final list = [...p.aisleOrder];
                final a = list.removeAt(from);
                list.insert(to, a);
                ref
                    .read(actionsProvider)
                    .saveProfile(p.copyWith(aisleOrder: list));
              },
              children: [
                for (final a in p.aisleOrder)
                  ListTile(
                    key: ValueKey(a),
                    title: Text(S.aisle(a)),
                    trailing: const Icon(Icons.drag_handle_rounded),
                  ),
              ],
            ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text(S.about)),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Icon(
          Icons.wifi_off_rounded,
          size: 56,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(S.appName, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        Text(S.aboutBody, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 16),
        const Text(S.aboutData),
        const SizedBox(height: 16),
        const Text(S.aboutCamera),
        const SizedBox(height: 16),
        Text(S.aboutCredits, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 24),
        Text(S.aboutFont, style: Theme.of(context).textTheme.bodySmall),
        Text(S.version, style: Theme.of(context).textTheme.bodySmall),
      ],
    ),
  );
}
