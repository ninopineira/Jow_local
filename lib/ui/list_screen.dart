import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/enums.dart';
import '../domain/models.dart';
import '../domain/quantities.dart';
import '../domain/shopping.dart';
import '../domain/stock.dart';
import 'providers.dart';
import 'stock_screen.dart';
import 'strings.dart';
import 'v2_providers.dart';
import 'widgets.dart';

class ListData {
  ListData(this.menu, this.lines, this.items);

  final WeekMenu menu;
  final List<ShoppingLine> lines;
  final List<ShoppingItem> items;

  Map<String, ShoppingItem> get byKey => {
    for (final i in items)
      if (!i.manual && i.key != null) i.key!: i,
  };
  List<ShoppingItem> get manual => items.where((i) => i.manual).toList();
}

final listDataProvider = FutureProvider<ListData?>((ref) async {
  final menu = await ref.watch(menuProvider.future);
  if (menu.id == null || menu.status != MenuStatus.validated) return null;
  final repo = ref.watch(repositoryProvider);
  // V2 : la liste déduit le stock (le dépôt V2 branche ce calcul).
  ref.watch(kitchenProvider);
  ref.watch(stockProvider);
  // Recalcul en gardant les cases cochées des lignes inchangées (V1).
  await repo.refreshShopping(menu);
  return ListData(
    menu,
    await repo.computeLines(menu),
    await repo.shoppingItems(menu.id!),
  );
});

/// Onglet Liste (SPEC §3.7).
class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(listDataProvider);
    final profile = ref.watch(profileProvider).value;
    String text(ListData d) => shoppingText(
      lines: d.lines,
      manualItems: d.manual,
      stateByKey: d.byKey,
      aisleOrder: profile?.aisleOrder ?? Aisle.values,
      aisleLabel: S.aisle,
      title: S.shareTitle(d.menu.startDate),
      pantryTitle: S.pantrySection,
      manualTitle: S.manualSection,
    );
    final d = data.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.listTitle),
        actions: [
          IconButton(
            tooltip: S.scan,
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const StoreGroceriesScreen()),
            ),
          ),
          const SettingsAction(),
          if (d != null) ...[
            IconButton(
              tooltip: S.copy,
              icon: const Icon(Icons.content_copy_rounded),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: text(d)));
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text(S.copied)));
                }
              },
            ),
            IconButton(
              tooltip: S.share,
              icon: const Icon(Icons.share_rounded),
              onPressed: () => ref
                  .read(platformProvider)
                  .shareText(text(d), S.shareTitle(d.menu.startDate)),
            ),
          ],
        ],
      ),
      body: AsyncBody(
        value: data,
        builder: (d) => d == null
            ? const EmptyState(
                icon: Icons.shopping_basket_rounded,
                text: S.listEmpty,
              )
            : _ListBody(data: d, order: profile?.aisleOrder ?? Aisle.values),
      ),
    );
  }
}

class _ListBody extends ConsumerWidget {
  const _ListBody({required this.data, required this.order});

  final ListData data;
  final List<Aisle> order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final byKey = data.byKey;
    final pantry = data.lines.where((l) => l.pantry).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        Text(
          S.weekOf(data.menu.startDate),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SectionTitle(S.toBuy),
        for (final aisle in order)
          if (data.lines.any(
            (l) => !l.pantry && l.ingredient.aisle == aisle,
          )) ...[
            SectionTitle(S.aisle(aisle)),
            for (final l in data.lines.where(
              (l) => !l.pantry && l.ingredient.aisle == aisle,
            ))
              ShoppingLineTile(line: l, item: byKey[l.key]),
          ],
        if (pantry.isNotEmpty)
          Card(
            child: ExpansionTile(
              key: const Key('pantry'),
              shape: const Border(),
              title: Text(
                S.pantrySection,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              children: [
                for (final l in pantry)
                  ShoppingLineTile(line: l, item: byKey[l.key]),
              ],
            ),
          ),
        const _InStockSection(),
        SectionTitle(S.manualSection),
        for (final m in data.manual)
          Card(
            child: CheckboxListTile(
              value: m.bought,
              title: Text(
                m.label ?? '',
                style: m.bought
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
              secondary: IconButton(
                tooltip: S.delete,
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: () => ref.read(actionsProvider).deleteItem(m.id!),
              ),
              onChanged: (v) =>
                  ref.read(actionsProvider).setChecks(m.id!, bought: v),
            ),
          ),
        _AddItemField(menuId: data.menu.id!),
      ],
    );
  }
}

class ShoppingLineTile extends ConsumerWidget {
  const ShoppingLineTile({super.key, required this.line, required this.item});

  final ShoppingLine line;
  final ShoppingItem? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bought = item?.bought ?? false;
    final atHome = item?.atHome ?? false;
    final done = bought || atHome;
    final qty = formatAmount(line.amount);
    final name = line.ingredient.name;
    final label = line.amount.dimension == Dimension.count
        ? '$qty × $name'
        : '$name — $qty';
    final actions = ref.read(actionsProvider);
    final pack = ref.watch(packagesProvider).value?[line.ingredient.id];
    final packs = pack == null
        ? null
        : packagesFor(
            line.ingredient,
            line.amount,
            pack.packageQty!,
            pack.packageUnit!,
          );
    return Card(
      key: Key('line-${line.key}'),
      child: Row(
        children: [
          Checkbox(
            value: bought,
            semanticLabel: '${S.bought} : $name',
            onChanged: item?.id == null
                ? null
                : (v) => actions.setChecks(item!.id!, bought: v),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label + (line.optional ? ' (${S.optionalTag})' : ''),
                    style: TextStyle(
                      decoration: done ? TextDecoration.lineThrough : null,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (packs != null)
                    Text(
                      S.packages(
                        packs,
                        '${formatNumber(pack!.packageQty!)} '
                        '${S.stockUnitLabel(pack.packageUnit!.code)}',
                      ),
                    ),
                  Text(
                    S.forRecipes(line.recipeTitles),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            tooltip: S.haveIt,
            icon: const Icon(Icons.home_outlined),
            // V2 : « j'en ai déjà » ajoute la quantité au stock réel.
            onPressed: () => addWithoutScan(
              context,
              ref,
              ingredient: line.ingredient,
              quantity: line.amount.dimension == Dimension.pinch
                  ? line.amount.value * 0.5
                  : line.amount.value,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddItemField extends ConsumerStatefulWidget {
  const _AddItemField({required this.menuId});
  final int menuId;

  @override
  ConsumerState<_AddItemField> createState() => _AddItemFieldState();
}

class _AddItemFieldState extends ConsumerState<_AddItemField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> add() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    controller.clear();
    await ref.read(actionsProvider).addManualItem(widget.menuId, text);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: S.addItem,
        suffixIcon: IconButton(
          tooltip: S.addItem,
          icon: const Icon(Icons.add_rounded),
          onPressed: add,
        ),
      ),
      onSubmitted: (_) => add(),
    ),
  );
}

/// « Déjà en stock » (repliée) : ce que le stock couvre (SPEC-V2 §7).
class _InStockSection extends ConsumerWidget {
  const _InStockSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(stockPlanProvider).value?.$2;
    if (plan == null || plan.inStock.isEmpty) return const SizedBox.shrink();
    return Card(
      child: ExpansionTile(
        key: const Key('in-stock'),
        shape: const Border(),
        title: Text(
          '${S.alreadyInStock} (${plan.inStock.length})',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        children: [
          for (final l in plan.inStock)
            ListTile(
              leading: const Icon(Icons.check_rounded),
              title: Text(l.ingredient.name),
              trailing: Text(formatAmount(l.amount)),
            ),
        ],
      ),
    );
  }
}
