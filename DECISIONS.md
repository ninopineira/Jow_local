# Décisions

Décisions structurantes prises en cours de route, avec leur raison (SPEC §8).

## 2026-10-27 — Dossier `ios/` généré

- **Décision** : le squelette est créé avec `flutter create --platforms android,ios`, à la demande explicite de l'utilisateur dans le prompt de scaffolding.
- **Écart** : SPEC.md §2 et §8 disent « Android uniquement, ne crée pas de dossier `ios/` ».
- **Conséquence** : la cible principale reste Android (tests sur l'hôte, essais sur téléphone Android). `ios/` est conservé sans travail spécifique, car aucun build n'est possible sous Windows. La règle hors ligne s'applique aussi à la configuration iOS (voir CLAUDE.md), et le sous-agent `relecteur-local` la vérifie.
- À trancher par l'utilisateur : mettre SPEC.md à jour, ou supprimer `ios/`.

## 2026-10-27 — Organisation des données fournies

- `assets/recipes/ingredients.json` (catalogue), `assets/recipes/recipes/<lot>.json` (un fichier par lot), `assets/recipes/seed.json` (version du seed et liste des lots), schémas JSON à côté.
- **Raison** : permettre la rédaction des lots en parallèle sans conflit d'écriture, et l'ajout de nouveaux lots via une nouvelle version du seed (SPEC §5).
