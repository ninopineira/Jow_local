# Décisions

Décisions structurantes prises en cours de route, avec leur raison (SPEC §8).

## 2026-10-27 — Android uniquement, `ios/` supprimé

- La mention d'iOS dans le prompt de scaffolding était une erreur. Le dossier `ios/` généré a été supprimé, conformément à SPEC §8 : Android uniquement.
- `cupertino_icons` est retiré des dépendances : le projet utilise uniquement les icônes Material (SPEC §3.8).

## 2026-10-27 — Organisation des données fournies

- `assets/recipes/ingredients.json` (catalogue), `assets/recipes/recipes/<lot>.json` (un fichier par lot), `assets/recipes/seed.json` (version du seed et liste des lots), schémas JSON à côté.
- **Raison** : permettre la rédaction des lots en parallèle sans conflit d'écriture, et l'ajout de nouveaux lots via une nouvelle version du seed (SPEC §5).

## 2026-10-27 — Dépendances : pas d'`image_picker` ni de `sqlite3_flutter_libs`

- `image_picker` tire `image_picker_platform_interface` → `http` dans le graphe **runtime** : retiré. Photos (galerie, appareil photo), partage de texte, maintien de l'écran allumé et choix de fichier d'export/import passent par un petit canal natif Kotlin (`MainActivity`) avec les intents système, sans dépendance.
- `sqlite3_flutter_libs` est en fin de vie (0.6.0+eol, paquet vide) : `sqlite3` 3.x embarque la bibliothèque native via ses build hooks.
- `web_socket_channel`, `shelf*`, `http_multi_server` et `web_socket` restent dans `pubspec.lock` **uniquement via les outils de dev** (`build_runner`, nécessaire à drift). Ils ne partent pas dans l'APK. `tool/check_offline.dart` contrôle donc la liste noire sur le graphe runtime calculé depuis `pubspec.lock` (`dart pub deps --json`, dépendances de dev exclues) et signale les paquets de dev en information.

## 2026-10-27 — Modèle de données : précisions techniques

- Marqueurs `meat` (toute chair animale terrestre), `pork`, `poultry`… et allergènes séparés dans le JSON ; cohérence testée. « Sans porc » exclut aussi la gélatine (souvent porcine). Les ingrédients facultatifs comptent dans le régime et les allergènes (prudence).
- Table technique `app_meta` (clé/valeur) : version du seed importée, dernière semaine passée en bilan. Aucune table du §4 n'est modifiée.
- Créneau source des restes stocké comme « jour:repas » dans le même menu.
- Arrondi « au demi » des pièces : appliqué au rayon fruits et légumes.
- Police : Nunito n'est publiée en amont qu'en version variable ; `Nunito-Variable.ttf` est embarquée et le thème fixe l'axe `wght`.

## 2026-10-27 — Générateur

- « Générer » (re)remplit les créneaux actifs vides **et** les créneaux recette non verrouillés ; verrouillés, restes et dehors sont conservés (sinon le verrou n'aurait pas d'effet).
- Priorités du score : à caser (pré-placement, les plus contraintes d'abord) > anti-répétition > part de favoris > variété > saison ≈ anti-gaspillage > rapidité en semaine > bruit (graine).
- Les restes d'un plat avec viande comptent comme repas avec viande pour la limite flexitarienne.

## 2026-10-27 — Build release

- Le NDK `28.2.13676358` exigé par `jni` a été installé automatiquement par Gradle lors d'un build (licence déjà acceptée) ; `ndkVersion` reste `flutter.ndkVersion`.
- Sur ce poste, Norton intercepte le TLS et `~/.gradle/gradle.properties` fait utiliser à Java le magasin Windows, inaccessible depuis le bac à sable de l'agent. Les builds lancés par l'agent utilisent un `GRADLE_USER_HOME` temporaire avec un magasin PKCS12 (autorités du JDK + racine Norton). Rien n'est modifié dans la configuration globale ni dans le projet.
