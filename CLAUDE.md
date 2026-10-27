# CLAUDE.md — Popote

Planificateur de menus Flutter **100 % hors ligne** : profil du foyer → recettes → menu de la semaine → liste des ingrédients.

**Référence : [SPEC.md](SPEC.md).** C'est la source de vérité pour les fonctionnalités, le modèle de données (§4), les recettes fournies (§5) et les critères de qualité (§6). Lis la section concernée avant de toucher à une fonctionnalité. En cas de doute, SPEC.md prime sur ce fichier, sauf les écarts notés dans [DECISIONS.md](DECISIONS.md).

## Règle absolue : aucun accès réseau à l'exécution (SPEC §1)

Internet est autorisé **pendant le développement** (installer Flutter, récupérer les paquets pub.dev, Gradle). Il est interdit **dans l'app**.

1. **Android** : l'APK release ne déclare ni `android.permission.INTERNET` ni `android.permission.ACCESS_NETWORK_STATE`, y compris dans le manifeste fusionné (les plugins peuvent en ajouter : il faut vérifier l'APK final, pas seulement `src/main/AndroidManifest.xml`). Les manifestes `debug` et `profile` générés par Flutter gardent INTERNET pour le hot reload : c'est normal, ils ne partent pas dans la release.
2. **Dépendances** : aucun paquet réseau. Liste noire minimale : `http`, `dio`, `chopper`, `retrofit`, `web_socket_channel`, `grpc`, `google_fonts`, `cached_network_image`, `url_launcher`, `firebase_*`, `sentry*`, `supabase*`, tout SDK d'analytics, de crash reporting ou de publicité. Dans `lib/`, aucun `HttpClient`, `Image.network`, `NetworkImage`, `Uri.http`/`Uri.https`, `Socket`.
3. **Ressources** : polices et images embarquées dans `assets/` (aucun téléchargement de police au lancement).
4. **Pas de sauvegarde cloud automatique** : `android:allowBackup="false"` et `dataExtractionRules` qui excluent tout (sauvegarde cloud et transfert d'appareil). Contrepartie : export/import manuel des données (SPEC §3.9).
5. **Script de contrôle** `tool/check_offline.dart`, qui échoue si : les permissions de l'APK release contiennent INTERNET ou ACCESS_NETWORK_STATE (`apkanalyzer` ou `aapt2`) ; `pubspec.lock` contient un paquet de la liste noire ; `lib/` contient un motif interdit du point 2.
6. **Écran « À propos »** : explique en deux phrases que l'app ne se connecte jamais à internet et que les données restent sur le téléphone.

Autorisé (déclenché par l'utilisateur, sans émission réseau de l'app) : copier dans le presse-papiers, partager du texte via la feuille de partage du système, choisir un fichier via le sélecteur du système.

Avant d'ajouter une dépendance, vérifie qu'elle n'est pas réseau et regarde ses dépendances transitives dans `pubspec.lock`. En cas de doute, demande au sous-agent `relecteur-local`.

## Commandes

```sh
flutter pub get                     # dépendances
dart run build_runner build -d      # code généré drift/riverpod (une fois drift ajouté)
dart format .                       # formatage (obligatoire)
flutter analyze                     # doit afficher « No issues found! »
flutter test                        # tous les tests (sur l'hôte Windows, sans émulateur)
flutter test test/domain            # un sous-ensemble
flutter build apk --release         # APK release
dart run tool/check_offline.dart    # contrôle hors ligne (après le build release)
flutter run                         # essai sur le téléphone Android branché en USB
```

## Architecture (SPEC §2)

- `lib/domain/` : **Dart pur** (aucun import `package:flutter` ni drift). Modèles, générateur de menu, agrégation de la liste, conversions d'unités, calcul du régime et des allergènes. C'est la partie la plus testée.
- `lib/data/` : base drift, DAO, migrations, import du seed, export/import JSON/zip. Convertit les lignes drift en modèles du domaine.
- `lib/ui/` : écrans, widgets, thème, routes go_router, providers Riverpod. Textes de l'interface centralisés dans un seul fichier pour une future traduction.
- `assets/recipes/` : `ingredients.json`, `recipes/<lot>.json` (un fichier par lot), `seed.json` (version du seed), schémas JSON. `assets/fonts/` : Nunito (OFL).
- `test/domain`, `test/data`, `test/widget` : miroir de `lib/`.
- `tool/` : scripts de dev (`check_offline.dart`).

Stack : Flutter stable, drift + `sqlite3_flutter_libs`, Riverpod, go_router, Material 3, `flutter_lints`.

## Conventions

- Code et identifiants en anglais ; textes de l'interface, commentaires métier et docs en français.
- Le régime et les allergènes d'une recette sont **toujours calculés** depuis les marqueurs des ingrédients, jamais stockés comme saisie.
- Le générateur de menu est une fonction pure et déterministe pour une graine donnée.
- Migrations drift versionnées, chacune avec un test.
- Thème : SPEC §3.8 (basilic `#2F7D4F`, tomate `#E2553A` réservé à « générer » et « valider », fond `#FFFFFF`/`#121614`, coins 16 px, Nunito, icônes Material arrondies). À éviter : fond crème, italique dans les titres, étiquettes « 01/02 », police monospace.
- Accessibilité : tailles de texte système, contrastes AA, cibles tactiles ≥ 48 px, `Semantics`.

## Façon de travailler (SPEC §8)

- Applique les hypothèses **[H]** sans demander. Note toute décision structurante dans `DECISIONS.md`.
- Ne sollicite l'utilisateur que s'il est bloquant : SDK à installer, licence Android, ou changement du modèle de données §4.
- Aucun fichier en dehors du dossier du projet (hors caches Flutter/pub/Gradle).
- Après chaque fonctionnalité terminée et testée : skill `fin-de-fonctionnalite` (format, analyze, test, commit).

## Délégation

- **`testeur`** : après toute modification de code Dart ou de données, et avant chaque commit. Il lance `flutter analyze` et `flutter test`, puis renvoie un diagnostic des échecs (cause probable, fichier:ligne). Il ne modifie pas le code : c'est toi qui corriges.
- **`relecteur-local`** : dès qu'on ajoute ou met à jour une dépendance, qu'on touche un manifeste Android, des réglages Gradle, la sauvegarde, l'export/import ou tout code d'E/S. Également avant chaque build release. Il est en lecture seule et rend un verdict OK ou BLOQUANT.
- **`redacteur-recettes`** (sonnet) : pour les données du §5, dans cet ordre strict :
  1. **Catalogue d'abord** : un seul appel écrit `assets/recipes/ingredients.json` en entier (250 à 400 ingrédients). Le catalogue est figé avant de lancer les recettes.
  2. **Recettes par lots en parallèle** : plusieurs appels lancés dans le même message, chacun avec un thème et des quotas explicites (exemple : « lot vegan-1 : 15 plats véganes dont 6 sans four »), écrivant uniquement `assets/recipes/recipes/<lot>.json`. **Chaque lot n'utilise que des ingrédients du catalogue** et n'en ajoute jamais. S'il en manque un, il le signale dans son compte rendu ; tu mets alors le catalogue à jour toi-même, puis tu relances le lot.
  3. Ensuite, `testeur` lance les tests de données (schéma, références, slugs uniques, bornes, répartition du §5) et tu corriges les écarts par lots ciblés.
  Le skill `ajouter-recettes` détaille la procédure et le découpage en lots.

## Points d'attention

- **Android uniquement** : pas de dossier `ios/` ni de travail spécifique à iOS. Si une commande Flutter régénère `ios/`, supprime-le. Pour ajouter une plateforme, utilise toujours `--platforms android`.
- `apkanalyzer` et `aapt2` se trouvent dans le SDK Android (`%ANDROID_HOME%\cmdline-tools\latest\bin`, `build-tools\<version>`). Le script doit les localiser lui-même.
- Le ré-import du seed se fait par slug : il ne touche jamais `recipe_user_state` ni les recettes perso.
- Performance du générateur : < 1 s pour 14 créneaux et 500 recettes.
