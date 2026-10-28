import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models.dart';
import '../domain/quantities.dart';
import '../domain/stock.dart';
import 'product_flow.dart';
import 'providers.dart';
import 'strings.dart';
import 'v2_providers.dart';
import 'widgets.dart';

String formatLotQuantity(StockLot l) =>
    '${formatNumber(l.quantity)} ${S.stockUnitLabel(l.unit.code)}';

String formatDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';

/// Bouton « Réglages » de la barre du haut (SPEC-V2 §9).
class SettingsAction extends StatelessWidget {
  const SettingsAction({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: S.openSettings,
    icon: const Icon(Icons.settings_rounded),
    onPressed: () => context.push('/settings'),
  );
}

class StockScreen extends ConsumerStatefulWidget {
  const StockScreen({super.key});

  @override
  ConsumerState<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends ConsumerState<StockScreen> {
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final today = ref.watch(todayProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.stockTitle),
        actions: [
          IconButton(
            tooltip: S.stockHistory,
            icon: const Icon(Icons.history_rounded),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const MovementsScreen())),
          ),
          const SettingsAction(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const StoreGroceriesScreen())),
        icon: const Icon(Icons.qr_code_scanner_rounded),
        label: const Text(S.stockStore),
      ),
      body: AsyncBody(
        value: ref.watch(stockProvider),
        builder: (lots) {
          final q = _query.toLowerCase();
          final shown =
              lots
                  .where((l) => q.isEmpty || l.label.toLowerCase().contains(q))
                  .toList()
                ..sort(compareForWithdrawal);
          final soon = shown.where((l) => l.expiresWithin(today, 3)).toList();
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: S.stockSearch,
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => addWithoutScan(context, ref),
                icon: const Icon(Icons.add_rounded),
                label: const Text(S.stockAddManual),
              ),
              if (lots.isEmpty)
                const EmptyState(
                  icon: Icons.kitchen_rounded,
                  text: S.stockEmpty,
                ),
              if (soon.isNotEmpty) ...[
                const SectionTitle(S.stockSoon),
                for (final l in soon) LotTile(lot: l, highlight: true),
              ],
              for (final loc in StockLocation.values)
                if (shown.any((l) => l.location == loc)) ...[
                  SectionTitle(S.location(loc.code)),
                  for (final l in shown.where((l) => l.location == loc))
                    LotTile(lot: l, highlight: l.expiresWithin(today, 3)),
                ],
            ],
          );
        },
      ),
    );
  }
}

class LotTile extends ConsumerWidget {
  const LotTile({super.key, required this.lot, this.highlight = false});

  final StockLot lot;
  final bool highlight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final sub = [
      formatLotQuantity(lot),
      if (lot.bestBefore != null) S.expiresOn(formatDate(lot.bestBefore!)),
      if (lot.ingredientId == null) S.stockUnlinked,
    ].join(' · ');
    return Card(
      color: highlight ? scheme.errorContainer : null,
      child: ListTile(
        minVerticalPadding: 12,
        title: Text(lot.label),
        subtitle: Text(sub),
        trailing: const Icon(Icons.more_vert_rounded),
        onTap: () => _lotActions(context, ref, lot),
      ),
    );
  }
}

Future<void> _lotActions(
  BuildContext context,
  WidgetRef ref,
  StockLot lot,
) async {
  final actions = ref.read(kitchenActionsProvider);
  final choice = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(lot.label),
            subtitle: Text(formatLotQuantity(lot)),
          ),
          for (final (key, icon, label) in [
            ('adjust', Icons.tune_rounded, S.stockAdjust),
            ('finished', Icons.check_circle_outline_rounded, S.stockFinished),
            ('move', Icons.swap_horiz_rounded, S.stockMove),
            ('dlc', Icons.event_rounded, S.stockBestBefore),
            ('delete', Icons.delete_outline_rounded, S.delete),
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
    case 'adjust':
      final q = await askNumber(
        context,
        S.stockQuantity,
        initial: lot.quantity,
        suffix: S.stockUnitLabel(lot.unit.code),
      );
      if (q != null) await actions.run((k) => k.adjustLot(lot.id!, q));
    case 'finished':
      await actions.run((k) => k.finishLot(lot.id!));
    case 'delete':
      await actions.run((k) => k.deleteLot(lot.id!));
    case 'move':
      final loc = await showDialog<StockLocation>(
        context: context,
        builder: (ctx) => SimpleDialog(
          title: const Text(S.stockMove),
          children: [
            for (final l in StockLocation.values)
              SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, l),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(S.location(l.code)),
                ),
              ),
          ],
        ),
      );
      if (loc != null) {
        await actions.run((k) => k.updateLot(lot.id!, location: loc));
      }
    case 'dlc':
      final now = ref.read(todayProvider);
      final d = await showDatePicker(
        context: context,
        initialDate: lot.bestBefore ?? now,
        firstDate: now.subtract(const Duration(days: 365)),
        lastDate: now.add(const Duration(days: 365 * 3)),
        cancelText: S.stockNoBestBefore,
      );
      await actions.run(
        (k) => d == null
            ? k.updateLot(lot.id!, clearBestBefore: true)
            : k.updateLot(lot.id!, bestBefore: d),
      );
  }
}

/// Demande un nombre (virgule acceptée).
Future<double?> askNumber(
  BuildContext context,
  String title, {
  double? initial,
  String? suffix,
}) {
  final c = TextEditingController(
    text: initial == null ? '' : formatNumber(initial),
  );
  return showDialog<double>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: c,
        autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(suffixText: suffix),
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
    ),
  );
}

/// Ajout sans scan (vrac, fruits et légumes) : ingrédient + quantité.
Future<void> addWithoutScan(
  BuildContext context,
  WidgetRef ref, {
  Ingredient? ingredient,
  double? quantity,
}) async {
  final catalog = await ref.read(catalogProvider.future);
  if (!context.mounted) return;
  final ing = ingredient ?? await pickIngredient(context, catalog.ingredients);
  if (ing == null || !context.mounted) return;
  final unit = StockUnit.forDimension(dimensionOf(ing.defaultUnit));
  final q =
      quantity ??
      await askNumber(
        context,
        ing.name,
        initial: unit == StockUnit.piece ? 1 : null,
        suffix: S.stockUnitLabel(unit.code),
      );
  if (q == null || q <= 0) return;
  await ref
      .read(kitchenActionsProvider)
      .run(
        (k) => k.addLot(
          StockLot(
            ingredientId: ing.id,
            label: ing.name,
            quantity: q,
            unit: unit,
            location: defaultLocation(ing),
            addedAt: DateTime.now(),
          ),
        ),
      );
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(S.stockAdded(ing.name))));
  }
}

/// « Ranger mes courses » : scans en rafale, compteur, « annuler le
/// dernier », quantité modifiable (SPEC-V2 §5).
class StoreGroceriesScreen extends ConsumerStatefulWidget {
  const StoreGroceriesScreen({super.key});

  @override
  ConsumerState<StoreGroceriesScreen> createState() =>
      _StoreGroceriesScreenState();
}

class _Stored {
  _Stored(this.movementId, this.resolution);
  final int movementId;
  final ScanResolution resolution;
}

class _StoreGroceriesScreenState extends ConsumerState<StoreGroceriesScreen> {
  final _stored = <_Stored>[];
  var _busy = false;

  Future<void> _onCode(String code) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final res = await resolveScan(context, ref, code);
      if (res == null) return;
      final id = await ref
          .read(kitchenActionsProvider)
          .run(
            (k) => k.addProduct(
              res.product,
              ingredientId: res.ingredient?.id,
              ingredient: res.ingredient,
            ),
          );
      setState(() => _stored.add(_Stored(id, res)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _undoLast() async {
    if (_stored.isEmpty) return;
    final last = _stored.removeLast();
    await ref
        .read(kitchenActionsProvider)
        .run((k) => k.undoEntry(last.movementId));
    setState(() {});
  }

  Future<void> _changeLast({double? factor}) async {
    if (_stored.isEmpty) return;
    final last = _stored.last;
    final p = last.resolution.product;
    double? qty;
    if (factor != null) {
      qty = (p.packageQty ?? 1) * factor;
    } else {
      qty = await askNumber(
        context,
        S.stockOtherQty,
        initial: p.packageQty,
        suffix: S.stockUnitLabel((p.packageUnit ?? StockUnit.piece).code),
      );
    }
    if (qty == null) return;
    final k = ref.read(kitchenActionsProvider);
    await k.run((k) => k.undoEntry(last.movementId));
    final id = await k.run(
      (k) => k.addProduct(
        p,
        ingredientId: last.resolution.ingredient?.id,
        ingredient: last.resolution.ingredient,
        quantity: qty,
      ),
    );
    setState(() => _stored[_stored.length - 1] = _Stored(id, last.resolution));
  }

  @override
  Widget build(BuildContext context) {
    final scanner = ref.watch(scannerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.stockStore),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(S.stockDone),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 260, child: scanner.preview(_onCode)),
            const SizedBox(height: 12),
            Semantics(
              liveRegion: true,
              child: Text(
                S.stockScanned(_stored.length),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: _stored.isEmpty ? null : _undoLast,
                  icon: const Icon(Icons.undo_rounded),
                  label: const Text(S.stockUndoLast),
                ),
                OutlinedButton(
                  onPressed: _stored.isEmpty
                      ? null
                      : () => _changeLast(factor: 2),
                  child: const Text(S.stockTimes2),
                ),
                OutlinedButton(
                  onPressed: _stored.isEmpty ? null : _changeLast,
                  child: const Text(S.stockOtherQty),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  for (final s in _stored.reversed)
                    ListTile(
                      leading: const Icon(Icons.check_rounded),
                      title: Text(s.resolution.product.displayName),
                      subtitle: Text(
                        s.resolution.ingredient?.name ?? S.stockUnlinked,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovementsScreen extends ConsumerWidget {
  const MovementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(revisionProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(S.stockHistory)),
      body: FutureBuilder<List<StockMovement>>(
        future: ref.read(kitchenProvider).movements(),
        builder: (context, snap) {
          final list = snap.data ?? const <StockMovement>[];
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final m = list[i];
              final sign = m.delta >= 0 ? '+' : '−';
              return ListTile(
                title: Text(m.label ?? ''),
                subtitle: Text(
                  '${S.movementKind(m.kind.code)} · ${formatDate(m.at)}',
                ),
                trailing: Text('$sign${formatNumber(m.delta.abs())}'),
              );
            },
          );
        },
      ),
    );
  }
}
