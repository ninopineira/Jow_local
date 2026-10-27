# SPEC — Popote (nom provisoire) : planificateur de menus 100 % hors ligne

Ce document est la référence du projet. Les points marqués **[H]** sont des hypothèses par défaut : applique-les sans demander (je peux les modifier avant de lancer).

## 0. Contexte et objectif

Application mobile **Android** inspirée des fonctionnalités de Jow (recettes personnalisées → menu de la semaine → liste des ingrédients), avec deux différences majeures :

- **100 % locale.** L'app ne se connecte jamais à internet et aucune donnée ne quitte le téléphone. Raison : protéger les données personnelles du foyer (régime, allergies, habitudes alimentaires) contre toute fuite, revente ou piratage d'un serveur.
- **Pas de courses en ligne.** L'app produit la liste des ingrédients de la semaine, et s'arrête là.

Seules les fonctionnalités de Jow servent d'inspiration : son nom, son logo, ses visuels et ses textes de recettes ne sont pas repris.

Utilisation : un foyer, un profil par appareil. Langue : français uniquement en V1 (textes de l'interface centralisés pour pouvoir traduire plus tard).

## 1. Règle absolue : aucun accès réseau à l'exécution

Internet est autorisé **pendant le développement** (installer Flutter, récupérer les paquets pub.dev, Gradle). Il est interdit **dans l'app**.

1. **Android** : l'APK release ne déclare ni `android.permission.INTERNET` ni `android.permission.ACCESS_NETWORK_STATE`, y compris dans le manifeste fusionné (les plugins peuvent en ajouter : il faut vérifier l'APK final, pas seulement `src/main/AndroidManifest.xml`). Les manifestes `debug` et `profile` générés par Flutter gardent INTERNET pour le hot reload : c'est normal, ils ne partent pas dans la release.
2. **Dépendances** : aucun paquet réseau. Liste noire minimale : `http`, `dio`, `chopper`, `retrofit`, `web_socket_channel`, `grpc`, `google_fonts`, `cached_network_image`, `url_launcher`, `firebase_*`, `sentry*`, `supabase*`, tout SDK d'analytics, de crash reporting ou de publicité. Dans `lib/`, aucun `HttpClient`, `Image.network`, `NetworkImage`, `Uri.http`/`Uri.https`, `Socket`.
3. **Ressources** : polices et images embarquées dans `assets/` (aucun téléchargement de police au lancement).
4. **Pas de sauvegarde cloud automatique** : `android:allowBackup="false"` et `dataExtractionRules` qui excluent tout (sauvegarde cloud et transfert d'appareil). **[H]** Contrepartie : export/import manuel des données (§3.9).
5. **Script de contrôle** `tool/check_offline.dart` (ou équivalent lancé par une commande unique documentée dans le README), qui échoue si :
   - les permissions de l'APK release contiennent INTERNET ou ACCESS_NETWORK_STATE (lecture via `apkanalyzer` ou `aapt2` du SDK Android) ;
   - `pubspec.lock` contient un paquet de la liste noire ;
   - `lib/` contient un des motifs interdits du point 2.
6. **Écran « À propos »** : explique en deux phrases que l'app ne se connecte jamais à internet et que les données restent sur le téléphone.

Autorisé car déclenché par l'utilisateur et sans émission réseau de l'app : copier la liste dans le presse-papiers, la partager en texte via la feuille de partage du système, choisir un fichier d'export/import via le sélecteur de fichiers du système.

## 2. Stack et architecture

- **Flutter** (dernière version stable) et Dart, plateforme **android** uniquement. Flutter garde la possibilité d'ajouter iOS plus tard sans réécrire l'app.
- **SQLite via drift** (+ `sqlite3_flutter_libs`), migrations versionnées et testées.
- **Riverpod** pour l'état, **go_router** pour la navigation. **[H]**
- **Material 3**.
- Tests : `flutter_test` (unitaires et widgets). Lint : `flutter_lints` ; `flutter analyze` sans aucun problème.
- **Développement sur PC Windows** : les tests tournent sur l'hôte (`flutter test`), sans émulateur ; les essais se font sur un téléphone Android branché en USB.

Découpage :

- `lib/domain/` : Dart pur, sans Flutter ni base de données. Modèles, générateur de menu, agrégation de la liste, conversions d'unités, calcul du régime. C'est le cœur de l'app et la partie la plus testée.
- `lib/data/` : base drift, DAO, import des recettes fournies, export/import JSON.
- `lib/ui/` : écrans, widgets, thème.
- `assets/recipes/` : recettes et ingrédients fournis (JSON + schéma). `assets/fonts/` : polices.

## 3. Fonctionnalités V1

### 3.1 Premier lancement : profil du foyer

Assistant en quelques écrans, tout modifiable ensuite dans les réglages :

- nombre de personnes (1 à 12, défaut 2) ;
- régime : omnivore, flexitarien (viande au plus 3 repas par semaine **[H]**), pescétarien, végétarien, végan ; option « sans porc » ;
- exclusions strictes (allergies, intolérances), avec les 14 allergènes réglementaires : gluten, crustacés, œufs, poisson, arachides, soja, lait, fruits à coque, céleri, moutarde, sésame, sulfites, lupin, mollusques ;
- aversions : ingrédients que le foyer n'aime pas (recherche dans le catalogue d'ingrédients) ;
- équipements disponibles : four, plaques, micro-ondes, mixeur, robot cuiseur, friteuse à air, cuiseur vapeur, autocuiseur ;
- repas à planifier : grille 7 jours × midi/soir (défaut : tous les soirs) ;
- temps de préparation maximal en semaine et le week-end (défaut 30 et 60 min) ;
- jour de début de semaine (défaut lundi). **[H]**

Les allergènes sont signalés au niveau des ingrédients, y compris les produits transformés (bouillon, sauce soja, moutarde, pâte feuilletée…). Un avertissement visible rappelle de toujours vérifier l'étiquette des produits achetés.

### 3.2 Catalogue de recettes

- Recettes fournies (§5) et recettes perso, dans une même liste.
- Recherche texte et filtres : temps, type (plat, dessert, petit-déjeuner), favoris, « à caser », perso, de saison.
- Par défaut, seules les recettes compatibles avec le profil apparaissent ; un interrupteur « tout afficher » montre les autres avec la raison de l'incompatibilité.
- Fiche recette : titre, temps de préparation et de cuisson, difficulté, équipements, sélecteur de portions (+/−) qui recalcule toutes les quantités, ingrédients, étapes numérotées, boutons favori, « à caser », ajouter au menu (choix du créneau), dupliquer.
- **Mode cuisine** : une étape par écran, gros texte, écran maintenu allumé.
- Visuel : les recettes fournies n'ont pas de photo ; elles ont une vignette générée (couleur et icône selon la base principale). **[H]** Les recettes perso peuvent avoir une photo prise ou choisie dans la galerie, stockée dans le dossier de l'app.

### 3.3 Recettes perso

Éditeur : titre, portions de base, temps, difficulté, type, équipements, ingrédients (autocomplétion sur le catalogue ; création d'un nouvel ingrédient avec son rayon et ses marqueurs), quantité et unité, étapes, photo. Le régime compatible et les allergènes sont calculés automatiquement depuis les ingrédients. On peut modifier, dupliquer (y compris une recette fournie, pour la personnaliser) et supprimer. Une mise à jour des recettes fournies ne touche jamais aux recettes perso.

### 3.4 Recettes aimées : favoris, « à caser », bilan de la semaine

Le besoin : chaque semaine, l'utilisateur indique les recettes qu'il aime pour qu'elles reviennent dans ses prochains menus.

- **Favori** (cœur) : recette aimée, de façon durable. Le générateur en place une part réglable dans chaque menu (défaut 40 %). **[H]**
- **À caser** (punaise) : « je veux la manger bientôt ». Prioritaire au prochain menu généré, puis retirée de « à caser » une fois planifiée dans un menu validé.
- **Bilan de la semaine** : à la fin de la semaine (ou à l'ouverture de la suivante), un écran passe en revue chaque recette cuisinée avec trois choix : on a aimé (devient favori), on n'a pas aimé (n'est plus proposée automatiquement, réversible), passer. Accessible aussi à la main depuis l'onglet Menu.
- Une recette « pas aimée » reste consultable et planifiable à la main.

### 3.5 Menu de la semaine

- Grille jours × créneaux actifs du profil, sur la semaine choisie.
- **Générer le menu** remplit les créneaux vides et respecte les créneaux verrouillés.
- Par créneau : remplacer (3 alternatives compatibles + recherche), verrouiller, vider, choisir une recette à la main, marquer « restes » ou « repas dehors » (rien dans la liste), ajuster les portions (défaut : nombre de personnes).
- **Cuisiner en double** : un créneau peut fournir les restes d'un autre (lundi soir ×2 → mardi midi « restes de… »). Les portions s'additionnent dans la liste. **[H]**
- **Extras de la semaine** : desserts, goûters ou petits-déjeuners ajoutés à la semaine sans créneau, avec leurs portions ; ils comptent dans la liste.
- **Valider le menu** génère la liste des ingrédients. Un menu validé reste modifiable ; la liste suit.
- Navigation entre semaines. L'historique est conservé (anti-répétition et bilan).

### 3.6 Générateur de menu

Fonction pure du domaine, déterministe pour une graine donnée (graine fixe dans les tests, aléatoire dans l'app).

**Contraintes dures, jamais violées** : régime et « sans porc », exclusions, aversions, équipements disponibles, temps maximal du jour, type « plat » pour les créneaux midi et soir, recettes « pas aimées » exclues, pas deux fois la même recette dans la semaine (hors restes), limite de repas avec viande pour le flexitarien.

**Préférences (score)** :

- placer toutes les recettes « à caser » quand c'est possible ;
- atteindre la part de favoris visée ;
- anti-répétition : une recette n'est pas reprise si elle figure dans les 2 semaines précédentes (réglable, favoris compris) ;
- variété : pas la même base principale (poulet, bœuf, poisson, légumineuses, œufs, pâtes…) sur deux créneaux consécutifs ;
- saison : bonus aux recettes dont les fruits et légumes sont de saison (calendrier embarqué, France métropolitaine) ;
- anti-gaspillage : bonus quand une recette réutilise un ingrédient périssable déjà entamé par une autre recette de la semaine (crème, herbes fraîches, demi-poivron…) ;
- recettes plus rapides en semaine.

Si les recettes compatibles ne suffisent pas, le générateur remplit ce qu'il peut, laisse les autres créneaux vides et explique pourquoi (exemple : « seulement 6 recettes compatibles avec végan + sans gluten + sans four »).

Performance : moins d'une seconde pour 14 créneaux et 500 recettes sur un téléphone de milieu de gamme.

### 3.7 Liste des ingrédients de la semaine

- Calculée depuis le menu validé et les extras : quantités mises à l'échelle des portions, additionnées par ingrédient.
- Conversions : g/kg, ml/cl/l, cuillères à soupe et à café vers leur équivalent ; les pièces restent en pièces ; conversion pièce ↔ grammes seulement si l'ingrédient a un poids moyen défini.
- Arrondis lisibles : pièces arrondies à l'unité supérieure (au demi pour certains légumes), grammes à 5 ou 10 près, affichage « 1,2 kg ».
- Regroupement par rayon : fruits et légumes, boucherie et poissonnerie, crèmerie, épicerie salée, épicerie sucrée, surgelés, boulangerie, boissons, divers. Ordre des rayons réglable.
- Section repliée « À vérifier dans tes placards » pour les ingrédients de base (sel, poivre, huile, vinaigre, farine, sucre, épices…).
- Chaque ligne : case « acheté », case « déjà à la maison », détail « pour : recette A, recette B ».
- Articles libres ajoutés à la main.
- Si le menu change, la liste est recalculée en conservant les cases cochées des lignes inchangées.
- Copier ou partager la liste en texte.

### 3.8 Interface

- Quatre onglets : **Menu**, **Liste**, **Recettes**, **Réglages**. Le bilan de la semaine s'ouvre depuis Menu.
- Direction visuelle (précise volontairement, pour éviter un style par défaut) : Material 3 ; fond blanc `#FFFFFF` en thème clair et anthracite `#121614` en thème sombre ; couleur principale vert basilic `#2F7D4F` ; accent tomate `#E2553A` réservé aux actions fortes (générer, valider) ; cartes à coins arrondis de 16 px avec ombre légère ; police Nunito (licence SIL OFL) embarquée ; icônes Material intégrées à Flutter, variantes arrondies ; vignettes de recettes colorées par base principale.
- À éviter : fond crème ou beige, mots en italique dans les titres, étiquettes numérotées « 01 / 02 / 03 », étiquettes en police monospace.
- Accessibilité : respect de la taille de texte du système, contrastes AA, zones tactiles d'au moins 48 px, libellés pour les lecteurs d'écran.
- États vides utiles (liste vide → « Valide ton menu pour obtenir ta liste »).

### 3.9 Réglages et données

- Profil (§3.1), part de favoris, horizon anti-répétition, ordre des rayons, thème clair/sombre/système.
- **Export** de toutes les données utilisateur (profil, recettes perso et leurs photos, favoris, « à caser », avis, historique des menus, listes) dans un fichier enregistré là où l'utilisateur le choisit. Format JSON versionné (photos incluses dans une archive zip **[H]**).
- **Import** avec aperçu et confirmation : fusionner ou remplacer.
- Réinitialisation complète avec double confirmation.

## 4. Modèle de données (drift)

- `ingredients` : id, nom, rayon, unité par défaut (g, ml, pièce, c. à soupe, c. à café, pincée), poids moyen par pièce (g, optionnel), est_placard, périssable, marqueurs (viande, porc, volaille, poisson, fruits de mer, lait, œuf, miel, gélatine, alcool et les 14 allergènes), mois de saison (fruits et légumes), origine (fourni ou perso).
- `recipes` : id, slug stable (recettes fournies), titre, description courte, type (plat, dessert, petit-déjeuner), portions de base, préparation (min), cuisson (min), difficulté, équipements requis, base principale, origine, version du seed, chemin de photo (optionnel), dates de création et de modification.
- `recipe_ingredients` : recette, ingrédient, quantité pour les portions de base, unité, optionnel, note (« émincé »).
- `recipe_steps` : recette, ordre, texte.
- `recipe_user_state` : recette, favori, à caser, pas aimée, date de dernière planification.
- `profile` (une seule ligne) et tables liées : aversions, exclusions, équipements, créneaux actifs.
- `week_menus` : id, date de début, statut (brouillon ou validé), graine.
- `menu_slots` : menu, jour, repas (midi ou soir), type (recette, restes, dehors, vide), recette (optionnelle), portions, verrouillé, créneau source des restes (optionnel).
- `week_extras` : menu, recette, portions.
- `shopping_items` : menu, ingrédient ou libellé libre, quantité, unité, acheté, déjà à la maison, ajouté à la main.

Le régime compatible et les allergènes d'une recette sont **toujours calculés** depuis les marqueurs de ses ingrédients, jamais saisis à la main.

## 5. Recettes fournies

- **Au moins 150 recettes originales**, rédigées pour ce projet en français (aucune copie de Jow ni d'un autre site), portions de base : 4. D'autres pourront être ajoutées plus tard par lots, via une nouvelle version du seed.
- Variété garantie pour chaque régime : quel que soit le régime choisi (végan compris), au moins 21 plats compatibles, soit 3 semaines de dîners sans répétition.
- Répartition minimale : au moins 135 plats et 15 desserts ou petits-déjeuners ; au moins 55 plats végétariens dont au moins 25 véganes ; au moins 20 à base de poisson ou fruits de mer ; volaille, bœuf et porc représentés ; au moins 35 sans gluten ; au moins 25 sans four ; au moins 70 % prêtes en 30 minutes ou moins ; toutes les saisons couvertes.
- **Catalogue d'ingrédients** : 250 à 400 ingrédients courants avec rayon, marqueurs, poids moyen par pièce quand c'est pertinent, mois de saison pour les fruits et légumes.
- Quantités réalistes, vérifiées par des tests de bornes par portion et par catégorie (bornes définies dans les tests et justifiées en commentaire).
- Format : JSON dans `assets/recipes/` avec un schéma. Import en base au premier lancement, puis ré-import quand la version du seed augmente (mise à jour par slug, sans toucher l'état utilisateur ni les recettes perso).

## 6. Qualité et tests

- `flutter analyze` : 0 problème. Code formaté avec `dart format`.
- **Domaine** : contraintes dures du générateur vérifiées sur au moins 200 graines et plusieurs profils (dont végan + sans gluten + sans four) ; « à caser » placées ; part de favoris ; anti-répétition ; flexitarien ; cas infaisable expliqué ; agrégation, conversions et arrondis de la liste ; cuisiner en double ; extras ; calcul du régime et des allergènes.
- **Données** : chaque JSON fourni respecte le schéma ; tout ingrédient référencé existe ; slugs uniques ; quantités dans les bornes ; répartition du §5 respectée ; import idempotent ; mise à jour du seed sans perte d'état utilisateur ; migrations ; un export puis un import redonnent les mêmes données.
- **Widgets** : premier lancement, générer et valider un menu, remplacer un créneau, cocher la liste, créer une recette perso, bilan de la semaine.
- `flutter build apk --release` réussit et `tool/check_offline` passe sur l'APK obtenu.

## 7. Hors périmètre V1 (idées pour plus tard)

- « Que cuisiner avec ce que j'ai » (recherche par ingrédients restants).
- Minuteurs dans le mode cuisine.
- Valeurs nutritionnelles.
- Plusieurs profils ; partage entre téléphones (à concevoir sans internet, car l'app n'a pas accès au réseau).
- Widget d'écran d'accueil.
- Version iOS (nécessite un Mac avec Xcode ; le code Flutter la permettra sans réécriture).
- Chiffrement applicatif de la base (SQLCipher). En V1, la base est dans le dossier privé de l'app, protégé par le chiffrement du système.

## 8. Façon de travailler

- Applique les hypothèses **[H]** sans demander. Note dans `DECISIONS.md` toute décision structurante prise en cours de route, avec sa raison.
- Ne me sollicite que pour ce qui ne peut pas avancer sans moi : installer un SDK, accepter une licence Android, ou un choix qui changerait le modèle de données du §4.
- N'écris aucun fichier en dehors du dossier du projet (hors caches normaux de Flutter, pub et Gradle).
- Android uniquement : ne crée pas de dossier `ios/` et ne fais aucun travail spécifique à iOS.
- Commit git après chaque fonctionnalité terminée et testée, pour pouvoir reprendre proprement si une session s'interrompt.
