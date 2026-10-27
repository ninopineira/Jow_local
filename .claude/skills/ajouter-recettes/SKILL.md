---
name: ajouter-recettes
description: Procedure to produce or extend Popote's bundled recipe data (SPEC §5) — freeze the ingredient catalogue first, then fan out parallel redacteur-recettes batches, validate with data tests, bump the seed version. Use whenever the user wants the 150 seed recipes written, more recipes added, the ingredient catalogue changed, or §5 distribution gaps fixed.
---

# Produire les recettes fournies

L'ordre compte : des lots parallèles qui inventeraient chacun leurs ingrédients produiraient des doublons et des références cassées. Le catalogue est donc la seule source, écrite et figée avant les lots.

## 1. Préalables

- Les schémas JSON (`assets/recipes/*.schema.json`) et les tests de données (`test/data/`) existent. Sinon, écris-les d'abord : schéma, références d'ingrédients, slugs uniques, bornes par portion et par catégorie justifiées en commentaire, répartition du §5.
- Lis `assets/recipes/seed.json` (version et lots existants).

## 2. Catalogue

Un seul appel `redacteur-recettes`, mission « catalogue ». Ensuite, le testeur valide le schéma. Relis rapidement les marqueurs d'allergènes des produits transformés. Le catalogue est alors figé pour la vague de lots.

## 3. Lots en parallèle

Lance tous les appels `redacteur-recettes` **dans le même message**, un par lot, avec pour chacun le nom du lot, le fichier cible, le thème, le nombre de recettes et les quotas. Découpage indicatif pour la V1 (≥ 150 recettes) :

| lot | contenu | quotas clés |
|---|---|---|
| vegan-1, vegan-2 | 2 × 14 plats véganes | ≥ 8 sans four, ≥ 8 sans gluten, saisons variées |
| vege-1, vege-2 | 2 × 15 plats végétariens (œufs, laitages) | ≥ 6 sans four |
| poisson | 22 plats poisson et fruits de mer | ≥ 8 sans gluten, ≥ 15 en ≤ 30 min |
| volaille | 18 plats volaille | ≥ 6 sans four |
| boeuf | 14 plats bœuf et agneau | |
| porc | 12 plats porc | |
| rapides | 12 plats en ≤ 20 min, toutes bases | sans four |
| sucre | 18 desserts et petits-déjeuners | dont ≥ 6 véganes |

Contraintes transverses à rappeler dans chaque demande : ≥ 70 % des recettes en ≤ 30 min, toutes les saisons, seulement des ingrédients du catalogue, slugs préfixés par le lot.

## 4. Consolidation

1. Si des lots signalent des ingrédients manquants : ajoute-les toi-même au catalogue, puis relance seulement les lots concernés.
2. Ajoute les lots à `seed.json` et **incrémente la version du seed** si des données existaient déjà (le ré-import se fait par slug, sans toucher à l'état utilisateur).
3. Sous-agent `testeur` sur `test/data`. Pour les écarts de répartition (exemple : « 19 plats poisson sur 20 »), lance un petit lot complémentaire plutôt que de réécrire.
4. Clôture avec le skill `fin-de-fonctionnalite` (commit `data(recettes): ...`).
