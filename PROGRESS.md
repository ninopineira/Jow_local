# Avancement V2

À relire au début de chaque session, à mettre à jour après chaque fonctionnalité (SPEC-V2 §13).

## Phase 0 — Inventaire de l'app de nutrition (2026-10-28)

- [x] Lecture seule de `C:\Projets\App_nutrition` (commit `8e94ebf`).
- [x] `docs/INVENTAIRE_NUTRITION.md` : stack, écrans, formules avec exemples chiffrés, modèle de données, appels réseau, plan de portage, choix à valider (C1 à C12).
- [x] `CLAUDE.md` renvoie à SPEC-V2.md ; exception CAMERA dans la règle hors ligne ; sous-agent `redacteur-nutrition` créé ; `relecteur-local` mis à jour.
- [x] Choix C1 à C12 appliqués avec les propositions par défaut (objectif /goal du 2026-10-28).

## Notes

- **SPEC-V2 §10** : l'ancienne app n'avait aucun export. `docs/EXPORT_FORMAT.md` a donc été **proposé côté Popote** à partir du schéma réel de l'ancienne app, et l'import est écrit (`lib/data/old_app_import.dart`, Réglages → « Importer depuis l'ancienne app », aperçu + confirmation, idempotent, testé sur un exemple). Reste à lancer dans l'ancienne app le prompt séparé qui produit ce fichier.

## Implémentation V2 (2026-10-28) — arrêt à la limite de 80 tours

Fait et testé (domaine 69 tests, données 56, widgets 13 au dernier passage) :
- Ciqual 2025 (Etalab 2.0) : `tool/prepare_ciqual.dart` → `tool/data/ciqual/ciqual_2025.tsv` ; 6 lots `redacteur-nutrition` ; `tool/build_nutrition.dart` → `assets/recipes/nutrition.json` (377/377, règle prudente, énergie déduite signalée pour 8 ingrédients) ; seed v2.
- `tool/build_product_db.dart` : base OFF produite (`build/product_db/produits-fr-20261028.db.gz`, 661 626 produits, 31,7 Mo, rapport à côté) ; testé sans réseau sur fixture.
- Domaine : nutrition (péjoratif), énergie, musculation, bilan, stock (min, DLC puis ancienneté, réservation chronologique, paquets, bonus anti-gaspillage), produits, journal, banque.
- Données : schéma drift v2 + migration testée depuis le schéma V1 réel ; dépôt V2 ; import base produits ; export/import V2 (version 2) idempotent.
- UI : 5 onglets, Réglages dans la barre du haut, Stock + rangement par scan, lien produit → ingrédient, Fait/Ajuster/Annuler, x/y en stock, fiche recette (kcal, macros, banque), liste À acheter / Déjà en stock, Nutrition complète, base produits et bonus dans Réglages, crédits dans À propos.
- Hors ligne : CAMERA ajoutée, INTERNET/ACCESS_NETWORK_STATE retirées du manifeste fusionné (tools:node=remove), `tool/check_offline.dart` mis à jour (openfoodfacts, permissions attendues).

Validation finale (2026-10-28) :
- [x] `testeur` : `flutter analyze` → « No issues found! » ; `flutter test` → « +144: All tests passed! ».
- [x] `flutter build apk --release` → « Built build\app\outputs\flutter-apk\app-release.apk (79.2MB) » (GRADLE_USER_HOME temporaire, voir DECISIONS.md).
- [x] `dart run tool/check_offline.dart` → OK ; permissions de l'APK : CAMERA et la permission interne AndroidX.
- [x] `relecteur-local` : VERDICT OK, aucun point bloquant ; points à surveiller traités (note DECISIONS.md, garde-fou `useUnbundled` dans check_offline).
- [x] Valeurs nutritionnelles des ingrédients perso (saisie, reprise d'un ingrédient Ciqual ou d'un produit scanné) dans l'éditeur de recette.
- [x] DECISIONS.md et README à jour.

Après l'import de l'ancienne app (même jour) : `testeur` → « No issues found! », « +146: All tests passed! » ; build release 79,4 Mo ; `check_offline` OK (CAMERA seule) ; `relecteur-local` OK.

- [x] Fichier d'import mal formé : message générique, transaction annulée (test ajouté) ; texte d'aide sans chemin de dépôt. Revalidé : `testeur` « +147: All tests passed! », « No issues found! » ; build release ; `check_offline` OK ; `relecteur-local` OK.

À reprendre (non bloquant) :
- [ ] Valider les types dans `OldAppImport` et lever une `FormatException` plutôt que de compter sur la `TypeError` (remarque de testeur).
- [ ] Fermer les bases créées par `setup()` dans les tests (avertissement drift).

Nécessite ton intervention :
- [ ] Dans l'ancienne app, lancer le prompt séparé qui produit l'export au format `docs/EXPORT_FORMAT.md` (l'ancienne app est en lecture seule pour Popote).
- [x] Sur le téléphone (24117RN76E, Android 16, 2026-10-28) : APK V2 installé par-dessus la V1 (`adb install -r`), migration réelle sans erreur (profil V1 conservé, pas d'assistant) ; base produits copiée dans Téléchargements puis importée depuis Réglages ; scan caméra d'un produit et rangement dans le stock : confirmés par l'utilisateur, aucune erreur dans logcat.
- [ ] Mineur : `pubspec.yaml` est encore en `version: 1.0.0+1` alors que « À propos » affiche 2.0.0 ; passer à `2.0.0+2` au prochain build.

Pistes : tester le scan et l'import de la base produits sur le téléphone ; import de l'ancienne app si `docs/EXPORT_FORMAT.md` est produit.
