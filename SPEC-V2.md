# SPEC V2 — Popote + nutrition : stock, scan et calories

Ce document décrit l'évolution V2 de Popote. **SPEC.md reste la référence** pour tout ce que ce document ne modifie pas. Les points marqués **[H]** sont des hypothèses par défaut : applique-les sans demander.

## 0. Contexte et objectif

Popote V1 (SPEC.md) est terminée et installée sur mon téléphone. J'ai aussi une app de nutrition, construite avec Claude Code, qui tourne sur mon téléphone. Son code est dans `C:\Projets\App_nutrition`.

But de la V2 : une seule app qui :

1. planifie les menus et donne la liste de courses (V1) ;
2. tient le stock du frigo, du congélateur et des placards grâce au scan des produits achetés ;
3. compte les calories des repas faits et de tout ce que je mange ;
4. reprend le reste de l'app de nutrition : dépense (sport, pas), journal et bilan du jour.

**On ne fusionne pas les deux codes.** Popote est la base. Les fonctionnalités de l'app de nutrition y sont réécrites dans son architecture (`domain/`, `data/`, `ui/`), avec ses tests et sa règle 100 % hors ligne.

Le suivi des calories concerne **une seule personne (moi)**. Le nombre de personnes du foyer continue de servir aux portions des recettes et aux quantités de la liste.

## 1. Ce qui change dans SPEC.md

- **§1 reste absolu : aucun accès réseau.** Seule nouvelle permission autorisée : `android.permission.CAMERA`, pour le scan. INTERNET et ACCESS_NETWORK_STATE restent interdites. `tool/check_offline` est mis à jour en conséquence, et la liste noire s'enrichit du paquet `openfoodfacts` (SDK réseau) et de tout client d'API alimentaire.
- **Lecture des codes-barres entièrement sur l'appareil**, avec un modèle de détection embarqué dans l'app. Avec `mobile_scanner`, c'est la version « bundled » par défaut : ne pas activer `useUnbundled`, qui fait télécharger le modèle par les services Google Play.
- **§3.7** : la liste de courses déduit désormais le stock (§7 ci-dessous).
- **§3.8** : la navigation passe à cinq onglets (§9).
- **§7** : les valeurs nutritionnelles entrent dans le périmètre.
- Si l'app de nutrition actuelle utilise internet (par exemple l'API Open Food Facts), cette partie n'est pas reprise : la base produits locale du §3 la remplace.

## 2. Phase 0 : inventaire de l'app de nutrition (avant tout code)

Lis l'app de nutrition **en lecture seule** et écris `docs/INVENTAIRE_NUTRITION.md` :

- stack, écrans et fonctionnalités ;
- **formules exactes**, avec un exemple chiffré pour chacune : métabolisme de base et dépense quotidienne, conversion pas → kcal, table MET et calcul des séances, estimation de la musculation, règle péjorative des fourchettes de macros (glucides en haut, protéines en bas, règle retenue pour les lipides), objectifs ;
- modèle de données ;
- appels réseau éventuels ;
- format d'export, si `docs/EXPORT_FORMAT.md` est présent dans Popote (§10).

Termine par un **plan de portage** : pour chaque fonctionnalité, reprise telle quelle, adaptée ou abandonnée, avec la raison. Les formules sont reprises à l'identique ; une erreur manifeste est signalée, pas corrigée en silence. Ensuite, arrête-toi pour que je valide le plan.

## 3. Base produits hors ligne (Open Food Facts)

- **Script PC `tool/build_product_db`**, documenté dans le README et lancé pendant le développement, quand internet est autorisé. Il télécharge l'export Open Food Facts et garde les produits vendus en France qui ont un code-barres, un nom et une énergie pour 100 g ou 100 ml. Colonnes conservées :
  - code-barres, nom, marque ;
  - quantité du paquet, convertie en g, ml ou pièces, multipacks compris (« 4 x 125 g ») ;
  - portion ;
  - pour 100 g ou 100 ml : kcal, protéines, glucides, sucres, lipides, acides gras saturés, fibres, sel ;
  - catégories (pour le rapprochement avec les ingrédients, §5).

  Le script produit un fichier SQLite compressé `produits-fr-AAAAMMJJ.db.gz` et un rapport (nombre de produits, taille).
- **Mon PC manque de place.** Ne jamais stocker le dump complet décompressé (l'export CSV fait environ 0,9 Go compressé et 9 Go décompressé). Traite-le en flux, et supprime les fichiers temporaires à la fin. Taille visée pour le fichier final : 150 Mo au plus **[H]**. Au-delà, garde en priorité les produits les plus scannés et les plus complets, et indique dans le rapport ce qui a été écarté.
- **Le fichier n'est pas dans l'APK**, pour que l'app reste légère et rapide à réinstaller pendant le développement **[H]**. Je le copie sur le téléphone par câble USB, et l'app l'importe une fois depuis Réglages → « Base produits » via le sélecteur de fichiers, puis le stocke dans son dossier privé. Mettre à jour la base, c'est réimporter un fichier plus récent, sans toucher aux produits perso ni aux liens produit → ingrédient.
- **Produit inconnu, ou base pas encore importée** : fiche produit saisie à la main (nom, poids du paquet, valeurs pour 100 g lues sur l'étiquette), enregistrée comme produit perso. Pour ce code-barres, elle passe avant la base. Un produit de la base peut aussi être corrigé : la correction devient un produit perso.
- **Attribution** : l'écran « À propos » crédite Open Food Facts (base sous licence ODbL) et la table Ciqual de l'Anses.

## 4. Valeurs nutritionnelles des ingrédients et des recettes

- Chaque ingrédient du catalogue reçoit kcal, protéines, glucides et lipides pour 100 g (fibres, sucres et sel en option). Les valeurs viennent de la **table Ciqual de l'Anses** (version la plus récente : fin 2025, 3 484 aliments), téléchargée pendant le développement. Vérifie sa licence au téléchargement et note-la dans `DECISIONS.md`. Le code Ciqual de chaque ingrédient est stocké dans les données fournies.
- Quand une valeur est donnée en fourchette, applique la **règle péjorative** de l'app de nutrition (glucides en haut, protéines en bas, lipides selon l'inventaire). Je préfère une estimation prudente.
- Conversions de poids : pièces via le poids moyen par pièce, ml via une densité (1 par défaut, valeur propre pour les huiles, le miel, etc.).
- La fiche recette affiche les kcal et les macros par portion.
- Recettes et ingrédients perso : valeurs saisies à la main, ou reprises d'un aliment Ciqual ou d'un produit scanné.

## 5. Stock : frigo, congélateur, placards

- **Lots de stock** : produit (code-barres) et/ou ingrédient lié, quantité restante (g, ml ou pièces), emplacement (frigo, congélateur ou placard, déduit du rayon et modifiable), date d'ajout, date limite (DLC) optionnelle saisie à la main.
- **Ajout par scan** : scanner un produit ajoute un paquet de sa quantité (par exemple 500 g). L'écran « Ranger mes courses » enchaîne les scans en rafale, avec compteur, bouton « annuler le dernier » et quantité modifiable (×2, poids différent).
- **Lien produit → ingrédient** : pour servir aux recettes, un produit doit être lié à un ingrédient du catalogue (« Spaghetti marque X 500 g » → pâtes sèches). Au premier scan d'un code-barres, l'app propose l'ingrédient le plus probable (catégories Open Food Facts, nom), que je confirme ou change en un geste. Le lien est ensuite mémorisé pour ce code-barres. Un produit peut rester sans lien (biscuits, boissons…) : il est en stock et peut être mangé directement (§6), mais ne sert pas aux recettes.
- **Ajout sans scan** (vrac, fruits et légumes, produits sans code-barres) : choisir un ingrédient et une quantité.
- **Écran Stock** : classement par emplacement, recherche, quantités restantes, DLC proches mises en avant. Actions : ajuster, « fini » (remet à 0), supprimer, déplacer (frigo → congélateur…).
- **Règles** :
  - le stock n'est jamais négatif ;
  - une sortie prend d'abord le lot dont la DLC est la plus proche, puis le plus ancien ;
  - les unités sont converties via le catalogue (pièces ↔ grammes avec le poids moyen).
- **Journal des mouvements** (entrée par scan, sortie par repas, ajustement), pour pouvoir annuler et comprendre l'état du stock.

## 6. Repas faits, consommation et calories

- **Bouton « Fait »** sur chaque créneau du menu et chaque extra. Un geste suffit, sans fenêtre de confirmation. Un bouton « Ajuster » optionnel permet de changer les parts mangées ou de remplacer ou retirer un ingrédient.
- **Effet sur le stock** : pour chaque ingrédient, on calcule le besoin pour les portions cuisinées (portions du créneau, restes compris). On retire **min(besoin, stock disponible)**. Si le stock est insuffisant ou vide, on retire ce qu'il y a et le reste est considéré comme non utilisé : aucune erreur, aucun stock négatif, aucun avertissement bloquant.
- **Restes** : la sortie de stock se fait sur le créneau où l'on cuisine. Marquer « Fait » un créneau « restes » ne touche pas au stock mais compte les calories.
- **Calories** : « Fait » ajoute à mon journal du jour **ma part**, 1 portion par défaut (ajustable : ½, 1½, 2…). Elle est calculée sur **la recette complète telle que prévue, même si des ingrédients manquaient dans le stock** (estimation prudente). Si j'ai ajusté la recette (ingrédient retiré ou remplacé), le calcul suit l'ajustement.
- **Annuler « Fait »** (erreur de saisie) : remet exactement le stock retiré, grâce au journal des mouvements, et retire l'entrée du journal alimentaire.
- **Repas dehors** : rien ne sort du stock ; je peux saisir des calories à la main.
- **« J'ai mangé »**, hors recettes : scanner un produit, ou choisir un produit, un ingrédient ou un repas de la banque, puis une quantité (grammes, portion, paquet entier). L'entrée va dans le journal et sort du stock avec la même règle min(besoin, stock).

## 7. Liste de courses avec le stock

- **À acheter = besoin de la semaine (V1) − stock disponible.** Le stock est réservé dans l'ordre chronologique des créneaux pas encore faits : si les pâtes en stock couvrent le dîner de lundi mais pas celui de jeudi, seul le manque de jeudi est dans la liste.
- Deux sections :
  - **« À acheter »** : le manque, arrondi au conditionnement quand un produit lié est connu (« 1 paquet de 500 g ») ;
  - **« Déjà en stock »** (repliée) : ce que le stock couvre.
- **Scanner pendant les courses ou au rangement** ajoute le produit au stock et coche la ligne correspondante, via le lien produit → ingrédient.
- La case « déjà à la maison » de la V1 est remplacée par le stock réel : cocher « j'en ai déjà » ajoute la quantité au stock.
- La liste est recalculée quand le menu ou le stock change, en conservant les cases cochées comme en V1.

## 8. Générateur de menu et stock

- Le générateur continue de proposer des recettes **même si leurs ingrédients ne sont pas en stock**. Le stock n'est jamais une contrainte dure.
- **Nouveau bonus de score** pour les recettes qui utilisent du stock existant, surtout périssable ou proche de sa DLC (anti-gaspillage). Poids réglable **[H]**.
- La fiche recette et chaque créneau affichent un indicateur « x/y ingrédients en stock ».

## 9. Nutrition et dépense (reprise de l'app de nutrition)

Reprendre les fonctionnalités inventoriées en phase 0, au minimum :

- **profil nutrition** : les données dont ont besoin les formules de l'ancienne app (âge, taille, poids, sexe, niveau d'activité, objectif…) ;
- **journal alimentaire du jour** : repas faits, « j'ai mangé » et saisies libres, avec totaux kcal et macros, objectif et historique ;
- **banque de repas** : repas pré-composés avec estimation péjorative, distincts des recettes. Une recette peut être ajoutée à la banque **[H]** ;
- **pas** saisis à la main et convertis en kcal ;
- **sport** : musculation détaillée (exercices, séries, répétitions, charge, repos, groupes musculaires, progression) et autres sports avec MET ;
- **pesées** (poids dans le temps), si l'ancienne app les a ;
- **bilan du jour** : apport − dépense (métabolisme de base + activité + pas), avec un graphique sur 7 et 30 jours.

**Interface [H]** : cinq onglets, **Menu**, **Liste**, **Stock**, **Nutrition** (journal, bilan, sport), **Recettes**. Les Réglages passent dans une icône de la barre du haut. Un bouton de scan est accessible depuis Stock, Liste et Nutrition. Même direction visuelle que SPEC.md §3.8.

## 10. Import des données de l'ancienne app

Si `docs/EXPORT_FORMAT.md` existe (produit dans l'ancienne app par un prompt séparé), écris un import depuis ce fichier : profil, aliments et produits ajoutés, banque de repas, journal alimentaire, pas, séances, pesées. Import avec aperçu et confirmation, et idempotent (réimporter ne crée pas de doublons). Si le fichier n'existe pas, saute cette partie et note-le dans `PROGRESS.md`.

## 11. Données déjà présentes dans Popote

- L'app garde le même identifiant Android : la V2 s'installe par-dessus la V1 et conserve menus, favoris, avis et recettes perso.
- **Migration drift** vers une nouvelle version de schéma, testée depuis le schéma V1 : aucune perte de données.
- L'export/import de SPEC.md §3.9 couvre aussi les nouvelles données (stock, mouvements, journal, nutrition, sport, produits perso, liens produit → ingrédient). La base produits Open Food Facts n'est pas exportée : elle se réimporte.

## 12. Qualité et tests

- **Domaine** :
  - sortie de stock min(besoin, stock), jamais négative, ordre DLC puis ancienneté, conversions d'unités ;
  - réservation chronologique et liste = besoin − stock ;
  - « Fait » puis « Annuler » restaure exactement le stock ;
  - restes ;
  - calories d'un repas fait = recette complète, même avec un stock vide ; ajustements ;
  - valeurs par portion et règle péjorative ;
  - formules reprises de l'ancienne app : mêmes résultats sur les exemples chiffrés de l'inventaire.
- **Données** :
  - tout ingrédient hors placard a un code Ciqual et des valeurs nutritionnelles (sel, eau à 0 acceptés) ;
  - `build_product_db` testé sans réseau sur un petit extrait (fixture de quelques produits) ;
  - import de la base produits ;
  - migration V1 → V2 ;
  - export puis import V2 sans perte ;
  - import de l'ancienne app sur un exemple.
- **Widgets** : ranger ses courses par scan, lier un produit à un ingrédient, marquer un repas fait puis annuler, « j'ai mangé », liste avec stock, bilan du jour. Le scanner passe par une interface qu'on peut simuler dans les tests.
- `flutter analyze` sans problème, `flutter test` avec 0 échec, `flutter build apk --release` réussi, `tool/check_offline` réussi (CAMERA seule nouvelle permission, pas d'INTERNET).

## 13. Façon de travailler

- Mêmes règles que SPEC.md §8.
- L'ancienne app de nutrition est en lecture seule.
- Phase 0, puis arrêt pour validation avant d'écrire le code de l'app.
- `PROGRESS.md` mis à jour après chaque fonctionnalité et relu au début de chaque session.
