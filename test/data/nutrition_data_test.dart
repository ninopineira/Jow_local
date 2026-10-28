// Données nutritionnelles fournies (SPEC-V2 §4, §12).
import 'package:flutter_test/flutter_test.dart';
import 'package:popote/data/seed.dart';

import '../helpers/seed_files.dart';

void main() {
  test(
    'tout ingrédient hors placard a un code Ciqual et des valeurs',
    () async {
      final src = FileSeedSource();
      final ingredients = parseIngredients(await src.read('ingredients.json'));
      final nutrition = parseNutrition(await src.read('nutrition.json'));
      for (final i in ingredients) {
        final n = nutrition[i.id];
        expect(n, isNotNull, reason: '${i.id} sans valeurs');
        if (!i.pantry) {
          expect(n!.ciqualCode, isNotNull, reason: '${i.id} sans code Ciqual');
        }
        final v = n!.nutrients;
        expect(v.kcal, inInclusiveRange(0, 950), reason: i.id);
        for (final g in [v.protein, v.carbs, v.fat]) {
          expect(g, inInclusiveRange(0, 100), reason: i.id);
        }
      }
    },
  );

  test('densités plausibles (huiles < 1, miel > 1)', () async {
    final nutrition = parseNutrition(
      await FileSeedSource().read('nutrition.json'),
    );
    for (final e in nutrition.entries) {
      final d = e.value.density;
      if (d != null) expect(d, inInclusiveRange(0.05, 2), reason: e.key);
    }
    expect(nutrition['miel']?.density, greaterThan(1));
  });

  test('table MET reprise : 38 activités et 30 mouvements', () {
    final data = readJson('../nutrition/exercises.json')! as Map;
    final list = (data['exercises'] as List).cast<Map>();
    expect(list.where((e) => e['kind'] == 'cardio').length, 38);
    expect(list.where((e) => e['kind'] == 'strength').length, 30);
    final run = list.firstWhere((e) => e['name'] == 'Course (10 km/h)');
    expect(run['met'], 9.8);
  });
}
