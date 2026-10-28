import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/food_log.dart';
import '../domain/models.dart';
import '../domain/nutrition.dart';
import '../domain/stock.dart';
import 'providers.dart';
import 'strings.dart';
import 'v2_providers.dart';

/// Produit scanné, avec son ingrédient lié (s'il y en a un).
class ScanResolution {
  const ScanResolution(this.product, this.ingredient);
  final Product product;
  final Ingredient? ingredient;
}

/// Après un scan (SPEC-V2 §3, §5) : produit perso ou de la base, sinon fiche
/// saisie à la main ; au premier scan, lien vers l'ingrédient le plus
/// probable, confirmé ou changé en un geste. Null si l'utilisateur annule.
Future<ScanResolution?> resolveScan(
  BuildContext context,
  WidgetRef ref,
  String barcode,
) async {
  final k = ref.read(kitchenProvider);
  var product = await k.product(barcode);
  if (product == null) {
    if (!context.mounted) return null;
    product = await Navigator.of(context).push<Product>(
      MaterialPageRoute(builder: (_) => ProductFormScreen(barcode: barcode)),
    );
    if (product == null) return null;
    await k.saveCustomProduct(product);
  }
  final catalog = await ref.read(catalogProvider.future);
  final byId = {for (final i in catalog.ingredients) i.id: i};
  final link = await k.link(barcode);
  if (link != null) {
    return ScanResolution(product, byId[link.$1]);
  }
  if (!context.mounted) return null;
  final choice = await chooseIngredientLink(
    context,
    product,
    catalog.ingredients,
  );
  if (choice == null) return null;
  await k.setLink(barcode, choice.$1?.id);
  ref.read(actionsProvider).refresh();
  return ScanResolution(product, choice.$1);
}

/// Feuille « à quel ingrédient correspond ce produit ? ». Renvoie
/// `(ingrédient,)` — `(null,)` pour « aucun » — ou null si annulé.
Future<(Ingredient?,)?> chooseIngredientLink(
  BuildContext context,
  Product product,
  List<Ingredient> ingredients,
) {
  final suggestion = suggestIngredient(product, ingredients);
  return showModalBottomSheet<(Ingredient?,)>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              product.displayName,
              style: Theme.of(ctx).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(S.productLinkTitle),
            const SizedBox(height: 4),
            Text(S.productLinkHint, style: Theme.of(ctx).textTheme.bodySmall),
            const SizedBox(height: 16),
            if (suggestion != null)
              FilledButton.icon(
                onPressed: () => Navigator.pop(ctx, (suggestion,)),
                icon: const Icon(Icons.check_rounded),
                label: Text('${S.productConfirm} : ${suggestion.name}'),
              ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () async {
                final picked = await pickIngredient(ctx, ingredients);
                if (picked != null && ctx.mounted) {
                  Navigator.pop(ctx, (picked,));
                }
              },
              icon: const Icon(Icons.search_rounded),
              label: const Text(S.productChooseOther),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, (null,)),
              child: const Text(S.productNoLink),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Choix d'un ingrédient du catalogue, avec recherche.
Future<Ingredient?> pickIngredient(
  BuildContext context,
  List<Ingredient> ingredients,
) => Navigator.of(context).push<Ingredient>(
  MaterialPageRoute(builder: (_) => _IngredientPicker(ingredients)),
);

class _IngredientPicker extends StatefulWidget {
  const _IngredientPicker(this.ingredients);
  final List<Ingredient> ingredients;

  @override
  State<_IngredientPicker> createState() => _IngredientPickerState();
}

class _IngredientPickerState extends State<_IngredientPicker> {
  var _q = '';

  @override
  Widget build(BuildContext context) {
    final q = _q.toLowerCase();
    final list = widget.ingredients
        .where((i) => q.isEmpty || i.name.toLowerCase().contains(q))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: S.search,
            border: InputBorder.none,
          ),
          onChanged: (v) => setState(() => _q = v),
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(list[i].name),
          onTap: () => Navigator.pop(context, list[i]),
        ),
      ),
    );
  }
}

/// Fiche produit saisie à la main ou corrigée (devient un produit perso).
class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key, required this.barcode, this.initial});

  final String barcode;
  final Product? initial;

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  late final _name = TextEditingController(text: widget.initial?.name);
  late final _brand = TextEditingController(text: widget.initial?.brand);
  late final _qty = TextEditingController(
    text: _fmt(widget.initial?.packageQty),
  );
  late var _unit = widget.initial?.packageUnit ?? StockUnit.g;
  late final _kcal = TextEditingController(
    text: _fmt(widget.initial?.nutrients?.kcal),
  );
  late final _p = TextEditingController(
    text: _fmt(widget.initial?.nutrients?.protein),
  );
  late final _c = TextEditingController(
    text: _fmt(widget.initial?.nutrients?.carbs),
  );
  late final _f = TextEditingController(
    text: _fmt(widget.initial?.nutrients?.fat),
  );

  static String _fmt(double? v) => v == null ? '' : '$v';
  static double? _num(TextEditingController c) =>
      double.tryParse(c.text.trim().replaceAll(',', '.'));

  Nutrients? get _nutrients {
    final k = _num(_kcal);
    if (k == null) return null;
    return Nutrients(
      kcal: k,
      protein: _num(_p) ?? 0,
      carbs: _num(_c) ?? 0,
      fat: _num(_f) ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final n = _nutrients;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initial == null ? S.productUnknown : S.productEdit),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.initial == null) Text(S.productUnknownBody),
          const SizedBox(height: 12),
          Text('${S.barcode} : ${widget.barcode}'),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: S.productName),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _brand,
            decoration: const InputDecoration(labelText: S.productBrand),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _qty,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: S.productPackage,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<StockUnit>(
                value: _unit,
                items: [
                  for (final u in StockUnit.values)
                    DropdownMenuItem(
                      value: u,
                      child: Text(S.stockUnitLabel(u.code)),
                    ),
                ],
                onChanged: (u) => setState(() => _unit = u ?? _unit),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(S.productPer100, style: Theme.of(context).textTheme.titleSmall),
          for (final (label, c) in [
            (S.kcal, _kcal),
            (S.protein, _p),
            (S.carbs, _c),
            (S.fat, _f),
          ])
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: c,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: label),
                onChanged: (_) => setState(() {}),
              ),
            ),
          if (n != null && n.isEnergyInconsistent())
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                S.energyInconsistent,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _name.text.trim().isEmpty
                ? null
                : () => Navigator.pop(
                    context,
                    Product(
                      barcode: widget.barcode,
                      name: _name.text.trim(),
                      brand: _brand.text.trim().isEmpty
                          ? null
                          : _brand.text.trim(),
                      packageQty: _num(_qty),
                      packageUnit: _unit,
                      nutrients: n,
                      categories: widget.initial?.categories ?? const [],
                      custom: true,
                    ),
                  ),
            child: const Text(S.save),
          ),
        ],
      ),
    );
  }
}
