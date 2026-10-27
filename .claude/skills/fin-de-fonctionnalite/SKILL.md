---
name: fin-de-fonctionnalite
description: Checklist to close a finished Popote feature — format, analyze, test, offline review when relevant, DECISIONS.md, then git commit. Use it every time a feature or sub-feature from SPEC.md is done, before saying "c'est terminé", or when the user asks to commit, even if they don't name the checklist.
---

# Clôturer une fonctionnalité

SPEC §8 demande un commit après chaque fonctionnalité terminée **et testée**, pour pouvoir reprendre proprement si une session s'interrompt. Ne commite pas un état rouge : la session suivante partirait d'une base cassée.

1. **Tests présents** : la fonctionnalité a des tests correspondant à SPEC §6 (domaine, données ou widgets). S'ils manquent, écris-les d'abord.
2. `dart format .`
3. Délègue au sous-agent **`testeur`** (analyze et test). Corrige tant que le résultat n'est pas « 0 problème, 0 échec ».
4. Si le diff touche `pubspec.*`, un manifeste, Gradle, la sauvegarde, l'export/import ou des E/S : délègue au sous-agent **`relecteur-local`**. Un verdict BLOQUANT doit être corrigé avant le commit.
5. Si une décision structurante a été prise (choix de paquet, format, écart à SPEC), ajoute une entrée datée dans `DECISIONS.md`.
6. Commit : `git add` des fichiers concernés (jamais de `build/`, `.dart_tool/` ni de clé de signature), puis un message en français au format `feat(<zone>): <résumé>`, `fix(...)`, `test(...)`, `data(...)` ou `chore(...)`, suivi de la ligne d'attribution demandée par l'environnement.
7. Termine par un récapitulatif en une ligne : fonctionnalité, commit, ce qui reste dans SPEC.
