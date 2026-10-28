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

## 2026-10-28 — V2 : choix validés et données nutritionnelles

- **Choix C1 à C12** de `docs/INVENTAIRE_NUTRITION.md` appliqués avec leurs propositions par défaut (objectif de la session : « plan validé »). Le modèle de données V2 (C1) est ajouté par une migration drift **additive** (schéma 2) : trois colonnes sur `ingredients` et quinze tables nouvelles ; aucune table V1 modifiée.
- **Valeurs nutritionnelles stockées en JSON** dans `ingredients.nutrition` (et `custom_products.nutrition`, `meal_preset_items.nutrition`) plutôt qu'en 16 colonnes : elles portent les fourchettes facultatives des aliments perso et restent lisibles par le domaine (`Nutrients.fromJson`).
- **Table Ciqual 2025** (Anses, 3 484 aliments, version du 2025-11-03) téléchargée depuis Recherche Data Gouv (doi:10.57745/RDMHWY) : **Licence Ouverte Etalab 2.0** (réutilisation libre avec mention de la source). L'extrait `tool/data/ciqual/ciqual_2025.tsv` est versionné ; les XML d'origine ne le sont pas.
- **Relier puis calculer** : les sous-agents `redacteur-nutrition` choisissent seulement le code Ciqual et la densité (lots par rayon) ; `tool/build_nutrition.dart` calcule les valeurs depuis la table. Raison : aucune valeur recopiée à la main, règle prudente appliquée de façon uniforme. Ciqual donnant des bornes min/max, la règle de l'ancienne app s'y applique (glucides, lipides, sucres, AG saturés, sel hauts ; protéines et fibres basses ; énergie à sa borne haute ou décalée 4/4/9).
- **Énergie absente dans Ciqual** (8 ingrédients : estragon, ricotta, tomates séchées, câpres, agar-agar, gousse de vanille, sirop d'agave, fruits rouges surgelés) : déduite des macros (4/4/9 + 2 kcal/g de fibres, formule UE 1169/2011), signalée par le script. Quatre ingrédients absents de Ciqual reliés à un aliment proche (halloumi → feta de vache, edamame → fève surgelée, pâte de curry rouge → harissa, graines de moutarde → graine de lin) ; colorant alimentaire à 0 (quantité négligeable).
- **Repas de la banque** : chaque ligne liée à un ingrédient sort du stock avec la règle min(besoin, stock) ; une recette ajoutée à la banque compte une portion, sans sortie de stock (elle est cuisinée par un créneau « Fait »).
- **Extras** : leur identifiant est conservé quand le menu est réenregistré, pour qu'un extra marqué « Fait » reste lié à son repas.
- **Bonus anti-gaspillage** du générateur : poids 10 par défaut (réglable de 0 à 30), entre la saison (12) et la rapidité (8) ; un ingrédient périssable ou à DLC ≤ 3 jours compte double.

## 2026-10-28 — V2 : scan et hors ligne

- **mobile_scanner 7.4.2**, version « bundled » (ML Kit `barcode-scanning` embarqué), jamais `useUnbundled`. Seule permission ajoutée : CAMERA.
- **Permissions réseau de ML Kit** : le manifeste principal déclare `INTERNET` et `ACCESS_NETWORK_STATE` avec `tools:node="remove"` : si une bibliothèque (télémétrie `datatransport`) les déclare, elles disparaissent du manifeste fusionné et aucun envoi n'est possible. Les manifestes debug et profile, prioritaires, gardent INTERNET pour le hot reload.
- **Base produits** : fichier SQLite séparé (`products.db` dans le dossier privé), ouvert en lecture seule ; import par le sélecteur de fichiers et copie en flux par le canal natif (`copyDocument`), puis vérification du format `popote-products-1`. Les produits perso et les liens restent dans la base principale.
- `tool/build_product_db.dart` lit l'export Open Food Facts **en flux** (HTTP + gzip), n'écrit qu'une base filtrée temporaire et la supprime ; 2026-10-28 : 2 117 569 lignes lues, 661 626 produits gardés, 31,7 Mo compressés (sous la limite de 150 Mo, aucun produit écarté).
- **Composants ML Kit restants** (audit relecteur-local du 2026-10-28) : le manifeste fusionné contient des composants `com.google.android.datatransport` (planification de la télémétrie) et les classes du client léger `play-services-mlkit-barcode-scanning`, tirés en transitif. Sans permission INTERNET rien ne peut partir, et sans méta-donnée `com.google.mlkit.vision.DEPENDENCIES` aucun modèle n'est téléchargé (modèle `libbarhopper_v3.so` + `.tflite` embarqués). On les laisse : les retirer imposerait de revalider le scan sur l'appareil. `check_offline` échoue si `useUnbundled=true` réapparaît.
- **Build release par l'agent** : comme en V1, `GRADLE_USER_HOME` temporaire (bac à sable) avec un magasin PKCS12 = autorités du JDK + racine Norton ; configuration globale et projet inchangés.

## 2026-10-28 — « Fait » et bilan du jour

- **Jour du journal d'un repas « Fait »** : le jour prévu du créneau, sauf s'il est à venir (repas avancé) : il est alors compté **aujourd'hui** (`mealLogDate`). Avant, un repas du jeudi mangé mercredi partait dans le bilan de jeudi et semblait absent. Un repas passé oublié reste sur son jour ; le message de confirmation indique le jour quand ce n'est pas aujourd'hui.
- **Date du jour** : `todayProvider` est recalculé au retour au premier plan si la date a changé (l'app pouvait rester des jours en arrière-plan avec un « aujourd'hui » figé).
