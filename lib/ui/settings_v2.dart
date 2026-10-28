import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/old_app_import.dart';
import '../data/product_catalog.dart';
import 'providers.dart';
import 'strings.dart';
import 'v2_providers.dart';

/// Réglages → « Base produits » (SPEC-V2 §3) : import par le sélecteur de
/// fichiers, copie en flux dans le dossier privé, puis vérification.
class ProductDbTile extends ConsumerStatefulWidget {
  const ProductDbTile({super.key});

  @override
  ConsumerState<ProductDbTile> createState() => _ProductDbTileState();
}

class _ProductDbTileState extends ConsumerState<ProductDbTile> {
  var _busy = false;

  Future<void> _import() async {
    final target = ref.read(productDbFileProvider);
    if (target == null) return;
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    final download = File('${target.path}.download');
    try {
      final ok = await ref.read(platformProvider).copyDocument(download.path);
      if (!ok) return;
      final current = ref.read(productDbProvider);
      if (current is SqliteProductCatalog) current.close();
      await importProductDb(download, target);
      ref.read(productDbProvider.notifier).reload();
      ref.read(actionsProvider).refresh();
      messenger.showSnackBar(const SnackBar(content: Text(S.productDbDone)));
    } on FormatException {
      ref.read(productDbProvider.notifier).reload();
      messenger.showSnackBar(const SnackBar(content: Text(S.productDbInvalid)));
    } finally {
      if (download.existsSync()) await download.delete();
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = ref.watch(productDbProvider).info;
    return ListTile(
      leading: const Icon(Icons.inventory_2_rounded),
      title: const Text(S.productDb),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _busy
                ? S.productDbImporting
                : info == null
                ? S.productDbNone
                : S.productDbInfo(info.date, info.count),
          ),
          const SizedBox(height: 8),
          _busy
              ? const LinearProgressIndicator()
              : OutlinedButton(
                  onPressed: _import,
                  child: const Text(S.productDbImport),
                ),
        ],
      ),
    );
  }
}

/// Poids du bonus anti-gaspillage du générateur (SPEC-V2 §8, [H]).
class StockWeightTile extends ConsumerWidget {
  const StockWeightTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(revisionProvider);
    final k = ref.watch(kitchenProvider);
    return FutureBuilder<double>(
      future: k.stockWeight(),
      builder: (context, snap) {
        final w = snap.data ?? 10;
        return ListTile(
          title: const Text(S.stockWeight),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.stockWeightHint),
              Slider(
                value: w.clamp(0, 30),
                max: 30,
                divisions: 6,
                label: w.round().toString(),
                onChanged: (v) => ref
                    .read(kitchenActionsProvider)
                    .run((k) => k.setStockWeight(v)),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Réglages → « Importer depuis l'ancienne app » (SPEC-V2 §10) : fichier au
/// format docs/EXPORT_FORMAT.md, aperçu puis confirmation, idempotent.
class OldAppImportTile extends ConsumerWidget {
  const OldAppImportTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListTile(
    leading: const Icon(Icons.move_down_rounded),
    title: const Text(S.oldAppImport),
    subtitle: const Text(S.oldAppImportHint),
    onTap: () async {
      final messenger = ScaffoldMessenger.of(context);
      final bytes = await ref.read(platformProvider).openDocument();
      if (bytes == null) return;
      final importer = OldAppImport(ref.read(kitchenProvider));
      final OldAppPreview preview;
      try {
        preview = await importer.preview(importer.parse(bytes));
      } on FormatException catch (e) {
        messenger.showSnackBar(SnackBar(content: Text(e.message)));
        return;
      } on TypeError {
        // Bon en-tête mais données mal formées : message générique, sans
        // journaliser le contenu du fichier.
        messenger.showSnackBar(const SnackBar(content: Text(S.oldAppInvalid)));
        return;
      }
      if (!context.mounted) return;
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(S.oldAppImport),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final e in preview.total.entries)
                  if (e.value > 0)
                    Text(
                      S.oldAppLine(
                        S.oldAppCategory(e.key),
                        e.value,
                        preview.fresh[e.key],
                      ),
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
              child: const Text(S.importConfirmAction),
            ),
          ],
        ),
      );
      if (ok != true) return;
      try {
        await ref
            .read(kitchenActionsProvider)
            .run((_) => importer.apply(preview.data));
      } on TypeError {
        // La transaction est annulée : rien n'est importé.
        messenger.showSnackBar(const SnackBar(content: Text(S.oldAppInvalid)));
        return;
      }
      messenger.showSnackBar(const SnackBar(content: Text(S.oldAppDone)));
    },
  );
}
