# Décisions

Décisions structurantes prises en cours de route, avec leur raison (SPEC §8).

## 2026-10-27 — Android uniquement, `ios/` supprimé

- La mention d'iOS dans le prompt de scaffolding était une erreur. Le dossier `ios/` généré a été supprimé, conformément à SPEC §8 : Android uniquement.
- `cupertino_icons` est retiré des dépendances : le projet utilise uniquement les icônes Material (SPEC §3.8).

## 2026-10-27 — Organisation des données fournies

- `assets/recipes/ingredients.json` (catalogue), `assets/recipes/recipes/<lot>.json` (un fichier par lot), `assets/recipes/seed.json` (version du seed et liste des lots), schémas JSON à côté.
- **Raison** : permettre la rédaction des lots en parallèle sans conflit d'écriture, et l'ajout de nouveaux lots via une nouvelle version du seed (SPEC §5).
