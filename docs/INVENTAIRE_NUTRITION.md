# Inventaire de l'app de nutrition et plan de portage (SPEC-V2 §2)

Source lue **en lecture seule** : `C:\Projets\App_nutrition`, commit `8e94ebf` (« Ajoute le suivi des pas, la banque de repas et les séances détaillées »), arbre de travail propre. Date de l'inventaire : 2026-10-28.

Fichiers de référence : `src/domain/*.ts` (formules, testées), `src/constants/met.ts`, `src/db/schema.ts`, `src/db/seed.ts`, `src/services/open-food-facts.ts`, `docs/formules.md`, `docs/modele-donnees.md`.

---

## 1. Stack

| Sujet | Choix |
|---|---|
| Framework | Expo SDK 57, React Native 0.86, React 19, TypeScript 6 strict |
| Navigation | Expo Router, 4 onglets natifs |
| Base | SQLite locale (`expo-sqlite`, fichier `app_nutrition.db`) + Drizzle ORM, 2 migrations |
| État | aucun store : lecture directe de la base (`useLiveQuery`) |
| Scan | `expo-camera` (lecture de codes-barres) |
| Aliments | base locale (`foods`) + API Open Food Facts en secours |
| Tests | Jest (`jest-expo`) : 8 fichiers de tests du domaine, 1 test d'écrans, 1 test du client OFF |
| Identifiant Android | `com.appnutrition.tracker` (différent de Popote : les deux apps coexistent sur le téléphone) |

Permissions du manifeste Android de l'ancienne app : CAMERA, **INTERNET**, RECORD_AUDIO, SYSTEM_ALERT_WINDOW, VIBRATE, READ/WRITE_EXTERNAL_STORAGE (≤ API 32). Seule CAMERA est reprise.

## 2. Écrans et fonctionnalités

| Onglet / feuille | Contenu |
|---|---|
| **Aujourd'hui** (`app/index.tsx`) | Jauge de balance (0 au centre, déficit cyan à gauche, surplus ambre à droite, encoche d'objectif). Ingéré, dépensé, P/G/L du jour. Détail de la dépense : métabolisme + vie courante, séances, pas. Pas du jour (saisie), poids de référence. Navigation par jour. Invitation à compléter le profil s'il manque. |
| **Repas** (`app/meals.tsx`) | 4 moments : petit-déjeuner, déjeuner, dîner, collation. Total du jour et P/G/L. Lignes « aliment + grammes ». |
| ↳ Ajouter un aliment (`add-meal-sheet.tsx`) | Recherche par nom dans `foods`, **scan** (appel OFF), création manuelle (valeurs pour 100 g, fourchettes min/max facultatives), quantité **en grammes uniquement**, aperçu kcal/macros. |
| ↳ Banque de repas (`meal-bank-sheet.tsx`) | Repas enregistrés (nom, moment par défaut, lignes aliment + grammes). Appliquer = recopier les lignes dans le jour. Composer un repas, ou enregistrer le moment du jour comme modèle. Suppression. |
| **Entraînements** (`app/workouts.tsx`) | Activités chronométrées (sport, durée, intensité tranquille/modérée/intense, kcal mesurées par la montre en option). Séances de musculation détaillées (exercices, séries, répétitions, charge, repos, durée réelle facultative, kcal en option). Total dépensé en séance. |
| ↳ Progression (`strength-progress-sheet.tsx`) | Par exercice : meilleure série (1RM estimé), historique par séance, volume. |
| **Bilan** (`app/stats.tsx`) | 7 derniers jours sur l'axe de la jauge, cumul de la semaine, écart à l'objectif, projection de poids (kcal / 7 700). Pesées (poids, historique), « Me peser ». |
| Profil (`profile-sheet.tsx`) | Sexe, date de naissance, taille, niveau d'activité (hors séances), poids initial, objectif (prise de masse / perte de gras / maintien). |
| Pas (`steps-sheet.tsx`) | Saisie manuelle d'un nombre de pas par jour (remplace la valeur, n'additionne pas). |

Absents de l'ancienne app : **export/import** (aucun code d'export malgré la consigne de son CLAUDE.md), objectifs de macros, graphique sur 30 jours, fibres/sucres/sel, portions et paquets (tout est en grammes), lien avec des recettes.

## 3. Formules exactes, avec exemples chiffrés

Toutes les fonctions sont pures et **n'arrondissent jamais** (l'arrondi est réservé à l'affichage, `format.ts`). Les exemples ci-dessous seront repris tels quels comme tests du domaine dans Popote (SPEC-V2 §12).

**Profil de référence pour les exemples** : homme, né le 1996-11-15, 180 cm, 75 kg, activité modérée. Âge au 2026-10-28 = **29 ans**.

### 3.1 Âge (`ageInYears`)

Années pleines entre la date de naissance et le jour calculé (jours ISO locaux) ; on retire 1 si l'anniversaire n'est pas encore passé.
- 1996-11-15 → 2026-10-28 : 2026 − 1996 = 30, anniversaire pas encore passé → **29**.
- 1996-11-15 → 2026-11-15 : **30**.

L'âge est recalculé **pour chaque jour** du bilan (pas d'âge figé).

### 3.2 Métabolisme de base (BMR), Mifflin-St Jeor (`basalMetabolicRate`)

```
Homme : 10 × poids(kg) + 6,25 × taille(cm) − 5 × âge + 5
Femme : 10 × poids(kg) + 6,25 × taille(cm) − 5 × âge − 161
```
- Homme 75 kg, 180 cm, 29 ans : 750 + 1 125 − 145 + 5 = **1 735 kcal**.
- Femme 60 kg, 165 cm, 28 ans : 600 + 1 031,25 − 140 − 161 = **1 330,25 kcal**.

### 3.3 Dépense quotidienne (TDEE) (`totalDailyEnergyExpenditure`)

`TDEE = BMR × facteur`. Le facteur décrit la vie **hors séances** (les séances s'ajoutent à part).

| Niveau | Facteur | Libellé |
|---|---|---|
| `sedentary` | 1,2 | bureau, peu de marche |
| `light` | 1,375 | debout une partie de la journée |
| `moderate` | 1,55 | beaucoup de marche au quotidien |
| `active` | 1,725 | métier physique |
| `very_active` | 1,9 | métier physique intense |

- Homme de référence, modéré : 1 735 × 1,55 = **2 689,25 kcal**.
- Femme ci-dessus, légère : 1 330,25 × 1,375 = **1 829,09375 kcal**.

Poids utilisé pour un jour : la **pesée la plus récente antérieure ou égale** à ce jour (`weightOnDay`). Sans profil ou sans pesée, TDEE et balance valent `null` (l'app n'invente pas de poids).

### 3.4 Activité chronométrée, table MET (`workoutEnergyExpenditure`, `effectiveMet`)

```
MET effectif = MET de référence (effort modéré) × facteur d'intensité
kcal         = MET effectif × 3,5 × poids(kg) / 200 × durée(min)
```
Facteurs d'intensité : tranquille **0,75**, modérée **1**, intense **1,3**. Une valeur saisie à la main (montre) remplace le calcul. Sans poids connu et sans valeur saisie : 0.

- Course 10 km/h (MET 9,8), 30 min, modérée, 75 kg : 9,8 × 3,5 × 75 / 200 × 30 = **385,875 kcal**.
- Même séance, intense : MET 12,74 → **501,6375 kcal**.
- Même séance avec 420 kcal saisies : **420 kcal**.

**Table MET réellement utilisée** : celle du seed (`src/db/seed.ts`), complétée par nom à chaque démarrage. Activités chronométrées (MET « modéré ») :

| Activité | MET | Activité | MET | Activité | MET |
|---|---|---|---|---|---|
| Marche (5 km/h) | 3,5 | Natation | 5,8 | Badminton | 5,5 |
| Marche rapide (6 km/h) | 5,0 | Rameur | 7,0 | Escalade | 8,0 |
| Randonnée | 6,0 | Elliptique | 5,0 | Boxe (sac) | 5,5 |
| Montée d'escaliers | 8,8 | Corde à sauter | 11,0 | Boxe (assaut) | 7,8 |
| Course (8 km/h) | 8,3 | Circuit / poids du corps | 8,0 | Arts martiaux | 10,3 |
| Course (10 km/h) | 9,8 | HIIT | 8,0 | Ski | 7,0 |
| Course (12 km/h) | 11,5 | Football | 7,0 | Surf | 5,0 |
| Course (14 km/h) | 13,5 | Basket | 6,5 | Golf | 4,8 |
| Vélo (route) | 8,0 | Handball | 8,0 | Équitation | 5,5 |
| Vélo d'appartement | 7,0 | Volley | 4,0 | Danse | 5,0 |
| Spinning / RPM | 8,5 | Tennis | 7,3 | Yoga | 2,5 |
| Musculation (modérée) | 3,5 | Padel | 6,0 | Pilates | 3,0 |
| Musculation (intense) | 6,0 | | | Étirements | 2,3 |

Mouvements de musculation (30, avec groupe musculaire : pectoraux, dos, jambes, épaules, bras, gainage, corps entier) : développé couché, développé incliné, écarté poulie, dips, pompes, tractions, tirage vertical, rowing barre, rowing haltère, soulevé de terre, squat, presse à cuisses, fentes, soulevé de terre jambes tendues, leg curl, leg extension, mollets debout, développé militaire, élévations latérales, oiseau, curl biceps, curl marteau, extension triceps poulie, barre au front, gainage, relevé de jambes, crunch, épaulé-jeté, kettlebell swing, burpees. Leur MET (3,0 à 8,0) n'est **jamais utilisé** dans le calcul d'une séance (voir 3.5) : c'est une donnée morte, reprise pour l'import.

### 3.5 Musculation (`strength.ts`)

```
charge d'une série = charge saisie, ou 0,65 × poids de corps si la charge vaut 0 (poids du corps)
volume (kg)        = Σ répétitions × charge
durée (min)        = durée saisie si > 0, sinon Σ (3 s × répétitions + repos de la série, 90 s par défaut) / 60
densité (kg/min)   = volume / durée
MET                = 3,5 + clamp((densité − 60) / (200 − 60), 0, 1) × (6,0 − 3,5)
kcal               = MET × 3,5 × poids(kg) / 200 × durée     (ou valeur saisie, prioritaire)
1RM estimé (Epley) = charge × (1 + répétitions / 30) ; = charge si 1 répétition ; 0 si charge ou reps ≤ 0
meilleure série    = celle qui a le plus grand 1RM estimé
```
Sans poids de corps connu et sans valeur saisie : 0 kcal (les séries au poids du corps comptent alors 0 kg de volume).

- **Séance chronométrée** : 5 000 kg déplacés en 45 min, 75 kg → densité 111,1 ; MET = 3,5 + (51,1 / 140) × 2,5 = **4,4127** ; kcal = 4,4127 × 1,3125 × 45 = **260,625 kcal**.
- **Durée déduite** : squat 4 × 8 × 100 kg, repos 120 s → volume 3 200 kg ; durée = 4 × (24 + 120) s = 9,6 min ; densité 333 → MET plafonné à **6,0** ; kcal = 6 × 3,5 × 75 / 200 × 9,6 = **75,6 kcal**.
- **Poids du corps** : tractions 3 × 10 à 0 kg, repos non saisi, 75 kg → charge 48,75 kg ; volume 1 462,5 kg ; durée 3 × (30 + 90) s = 6 min ; densité 243,75 → MET 6,0 ; **47,25 kcal**.
- **Séance peu dense** : 2 000 kg en 60 min → densité 33,3 → MET plancher **3,5** ; **275,625 kcal**.
- **1RM** : 100 kg × 8 → 100 × (1 + 8/30) = **126,67 kg**.

### 3.6 Pas → kcal (`stepsEnergyExpenditure`)

```
foulée (m)     = 0,415 × taille(cm) / 100      (0,72 m si taille inconnue ou ≤ 0)
distance (km)  = pas × foulée / 1000
durée (min)    = distance / 4,8 × 60
kcal           = (3,5 − 1) × 3,5 × poids(kg) / 200 × durée     (MET net de la marche)
```
0 pas ou moins → 0. Sans poids connu → 0.

- 10 000 pas, 180 cm, 75 kg : foulée 0,747 m ; 7,47 km ; 93,375 min ; 2,5 × 3,5 × 75 / 200 × 93,375 = **306,3867 kcal**.
- 8 000 pas, taille inconnue, 75 kg : 0,72 m ; 5,76 km ; 72 min ; **236,25 kcal**.

### 3.7 Bilan du jour (`dailyBalance`, `summarizeDay`)

```
dépense = TDEE + kcal des activités + kcal des séances de musculation + kcal des pas
balance = kcal ingérées − dépense
statut  = maintien si |balance| ≤ 50 kcal ; sinon surplus (> 0) ou déficit (< 0)
écart à l'objectif = balance − delta quotidien de l'objectif
```
- Homme de référence, ingéré 2 500 kcal, course 30 min modérée (385,875), 10 000 pas (306,3867) : dépense = 2 689,25 + 385,875 + 306,3867 = 3 381,5117 ; balance = **−881,51 kcal** (déficit). Objectif perte de gras (−400) → écart **−481,51 kcal**.

### 3.8 Objectifs (`goals`, `profile-sheet.tsx`)

Un objectif = type + **delta quotidien signé** de la balance, avec date de début. C'est un **historique** : l'objectif actif pour un jour est le plus récent déjà commencé. Valeurs par défaut (non modifiables dans l'interface actuelle) : prise de masse **+300**, perte de gras **−400**, maintien **0** (« environ 0,3 kg par semaine »). Le poids cible existe en base mais n'est jamais saisi. **Aucun objectif de macros** n'existe.

### 3.9 Projection de poids (`projectedWeightChangeKg`)

`variation (kg) = cumul de la balance (kcal) / 7 700`. Le cumul vaut `null` dès qu'un jour de la période n'est pas calculable.
- Sept jours à −881,51 : −6 170,58 kcal → **−0,80 kg**.

### 3.10 Macronutriments et règle péjorative des fourchettes (`nutrition.ts`)

Valeurs stockées **pour 100 g**, conversion à la portion au moment du calcul : `valeur × grammes / 100`. Énergie des macros : protéines 4, glucides 4, lipides 9 kcal/g.

Un aliment peut porter des bornes min/max facultatives (kcal et trois macros). Dès qu'**une seule** borne est renseignée, l'aliment est lu au pire (`resolveFoodValues`), **partout** (ligne, repas, banque, jour) :

| Valeur | Borne retenue |
|---|---|
| Glucides | **haute** (max si présente, sinon valeur simple) |
| **Lipides** | **haute** — règle retenue par l'ancienne app |
| Protéines | **basse** (min si présente, sinon valeur simple) |
| Énergie | kcal max si déclarée ; sinon `max(0, kcal déclarées + écart 4/4/9 des grammes ajoutés ou retirés)` |

Une borne kcal min seule ne change rien. Un aliment sans fourchette est rendu tel quel.

- Exemple : 285 kcal, P 10 (8–12), G 50 (45–55), L 5 (4–6), sans borne kcal → P **8**, G **55**, L **6** ; écart = (32 + 220 + 54) − (40 + 200 + 45) = +21 → **306 kcal**. Portion de 150 g : 459 kcal, P 12, G 82,5, L 9.

Contrôle de cohérence (`isEnergyInconsistent`) : signale un aliment si `|kcal(macros) − kcal déclarées| / max(kcal déclarées, 1) > 20 %` (après lecture péjorative ; faux si les deux valent 0).
- 100 kcal déclarées, P 10, G 20, L 5 → 165 kcal impliquées → écart 65 % → **incohérent**.

## 4. Modèle de données de l'ancienne app

Dates en texte ISO `AAAA-MM-JJ` (jour local), valeurs nutritionnelles pour 100 g.

| Table | Colonnes |
|---|---|
| `foods` | id, barcode (unique), name, brand, kcal/protein/carbs/fat_per_100g, 8 colonnes de bornes `_min/_max` (nullables), source (`off`, `ciqual`, `manual`), updated_at |
| `meals` | id, date, slot (`breakfast`, `lunch`, `dinner`, `snack`), note |
| `meal_items` | id, meal_id (cascade), food_id (restrict), quantity_g |
| `exercises` | id, name (unique), met, kind (`cardio`, `strength`), muscle_group |
| `workouts` | id, date, exercise_id (restrict), duration_min, intensity (`light`, `moderate`, `vigorous`), kcal_override, note |
| `strength_sessions` | id, date, name, duration_min (nullable), kcal_override, note |
| `strength_sets` | id, session_id (cascade), exercise_id (restrict), set_index, reps, weight_kg (0 = poids du corps), rest_sec |
| `body_metrics` | id, date, weight_kg, body_fat_pct |
| `profile` | id = 1, sex, birth_date, height_cm, activity_level |
| `goals` | id, start_date, kind (`bulk`, `cut`, `maintain`), daily_kcal_delta, target_weight_kg |
| `meal_presets` | id, name (unique), default_slot, note, created_at |
| `meal_preset_items` | id, preset_id (cascade), food_id (restrict), quantity_g |
| `daily_steps` | id, date (unique), steps |

Le journal **recalcule** les kcal depuis `foods` : corriger un aliment réécrit l'historique des jours passés.

## 5. Appels réseau

Un seul : `src/services/open-food-facts.ts`, `GET https://world.openfoodfacts.org/api/v2/product/<code>.json` (User-Agent identifiant, délai de 8 s), appelé au scan depuis `add-meal-sheet.tsx` quand le code-barres est absent de `foods`. Le résultat est mis en cache dans `foods` (source `off`). Le script `scripts/seed-foods.mjs` (base OFF locale) n'est **pas implémenté** (`TODO`), et `assets/db/` est vide.

→ **Abandonné** (SPEC-V2 §1) : remplacé par la base produits locale (§3) et la fiche produit perso. On garde la règle « une valeur absente n'est jamais mise à 0 » de `mapResponse`, pour `build_product_db`.

## 6. Format d'export

`docs/EXPORT_FORMAT.md` **n'existe pas** dans Popote, et l'ancienne app n'a aucun export. L'import du §10 est donc sauté (noté dans `PROGRESS.md`). Si le fichier apparaît plus tard, l'import se fera à partir de lui ; le modèle du §4 ci-dessus donne déjà la correspondance des tables.

## 7. Erreurs et incohérences signalées (non corrigées)

Les formules sont reprises **à l'identique**. Points à trancher :

1. **Double comptage du repos pendant les séances.** Les activités et la musculation sont comptées en MET **brut** par-dessus le TDEE, qui couvre déjà le repos de ces minutes ; les pas, eux, sont comptés en MET **net** (− 1). Pour 30 min de course à 75 kg, la différence est 1 × 3,5 × 75 / 200 × 30 ≈ **39 kcal** de dépense en trop par séance (≈ 10 %), soit une estimation optimiste, à rebours de la prudence demandée ailleurs. C'est un choix documenté de l'ancienne app, pas un bug de code. **Proposition** : reprendre tel quel (défaut), avec option de passer au MET net plus tard.
2. **Table `MET_VALUES` morte** (`src/constants/met.ts`) : jamais utilisée, et différente du seed (pas de « Vélo d'appartement 7,0 », vélo modéré à 8,0, natation déclinée en trois valeurs…). Seule la table du seed (§3.4) est reprise.
3. **« Musculation (modérée / intense) » en activité chronométrée** coexiste avec les séances détaillées : saisir les deux compte la séance deux fois. Repris (utile pour une séance non détaillée), avec une mention dans l'interface.
4. **Poids du corps à 65 %** pour toute série à 0 kg, y compris gainage ou crunch (où les « répétitions » n'ont pas le même sens), et une série lestée (dips + 10 kg) ignore le poids du corps. Approximation assumée, reprise.
5. **Durée déduite** : le repos est compté aussi après la dernière série. Écart de 1,5 min par séance au plus ; repris.
6. **Historique non figé** : modifier un aliment change les kcal des jours passés. Dans Popote V2, avec une base produits réimportable, ce serait plus gênant (voir choix C6).
7. **Objectif non réglable** : le delta est figé aux valeurs par défaut. Le porter tel quel, ou le rendre modifiable (choix C8).

## 8. Plan de portage

Légende : **R** = repris tel quel (même formule, mêmes constantes, mêmes tests chiffrés), **A** = adapté, **X** = abandonné.

| Fonctionnalité | Décision | Raison / adaptation dans Popote |
|---|---|---|
| BMR Mifflin-St Jeor, âge par jour | **R** | `lib/domain/energy.dart`, tests des exemples 3.1–3.2. |
| TDEE et facteurs d'activité | **R** | Mêmes 5 niveaux et libellés « hors séances ». |
| Activités chronométrées (MET × intensité, valeur saisie prioritaire) | **R** | Table MET du seed (§3.4) en asset JSON `assets/nutrition/exercises.json`, complétée par nom au démarrage comme l'ancienne app. |
| Musculation détaillée (volume, densité, MET 3,5–6, durée déduite, poids du corps, 1RM Epley, meilleure série, progression) | **R** | `lib/domain/strength.dart` ; écran de saisie série par série et progression par exercice. |
| Pas → kcal | **R** | Saisie manuelle uniquement (aucun capteur, aucune API santé). |
| Bilan du jour, statut ±50, écart à l'objectif | **R** | Onglet Nutrition. Apport = journal (repas faits, « j'ai mangé », saisies libres). |
| Projection de poids /7 700 | **R** | Affichée comme tendance. |
| Règle péjorative des fourchettes | **R** puis **A** | Même règle pour kcal/P/G/L. Étendue aux nouvelles valeurs (fibres basses ; sucres, AG saturés, sel hauts) et appliquée aux valeurs Ciqual « < x » (choix C3–C4). |
| Contrôle de cohérence 4/4/9 (20 %) | **A** | Utilisé dans `build_product_db` (rapport) et sur la fiche produit perso (avertissement), pas seulement à l'import. |
| Profil nutrition | **A** | Table à une ligne, **distincte** du profil du foyer (le foyer sert aux portions). Mêmes champs + objectif. |
| Objectifs (historique, delta signé) | **A** | Repris, avec delta modifiable (choix C8). Pas d'objectif de macros (absent de l'ancienne app). |
| Pesées (historique, % de masse grasse) | **R** | Poids du jour = pesée la plus récente ≤ jour. |
| Journal alimentaire (4 moments, grammes) | **A** | Mêmes 4 moments ; entrées issues d'un créneau du menu, d'un extra, d'un produit, d'un ingrédient, d'un repas de la banque ou d'une saisie libre (kcal à la main) ; quantités en grammes, portions ou paquet entier ; valeurs figées à la saisie (choix C6). |
| Banque de repas | **A** | Repas pré-composés d'ingrédients, de produits ou d'aliments perso, lus au pire ; une recette peut y être ajoutée [H]. Appliquer = recopier (jamais de lien vivant), comme l'ancienne app. |
| Aliments perso (`foods` manual) | **A** | Deviennent produits perso (avec code-barres) ou ingrédients perso (sans code-barres), valeurs pour 100 g, fourchettes facultatives. |
| Base d'aliments de départ (22 aliments) | **X** | Remplacée par le catalogue d'ingrédients Popote relié à Ciqual (§4) et la base OFF locale. |
| Scan + API Open Food Facts | **X** | Réseau interdit. Remplacé par `mobile_scanner` (modèle embarqué) + base produits locale importée par fichier. |
| `scripts/seed-foods.mjs` | **X** | Jamais implémenté ; remplacé par `tool/build_product_db` (SPEC-V2 §3). |
| Graphique 7 jours | **A** | 7 et 30 jours (SPEC-V2 §9). |
| Jauge de balance (cyan / ambre, ton neutre « constate, ne juge pas ») | **A** | Reprise de l'idée et du ton, redessinée avec le thème Popote (§3.8) ; couleurs de direction à choisir dans la palette (choix C10). |
| `MET_VALUES` | **X** | Code mort, incohérent avec le seed (§7.2). |
| Export / import | **A** (nouveau) | Inexistant dans l'ancienne app ; intégré à l'export Popote V2 (SPEC-V2 §11). |
| Import depuis l'ancienne app (§10) | **X pour l'instant** | `docs/EXPORT_FORMAT.md` absent. |

### Ordre de réalisation proposé (après validation)

1. `check_offline` et `relecteur-local` mis à jour (CAMERA autorisée, `openfoodfacts` en liste noire), puis essai de `mobile_scanner` sur un APK release pour vérifier le manifeste fusionné (voir risque R1).
2. Domaine pur : `energy`, `strength`, `nutrition` (péjoratif), `balance` avec les exemples de ce document en tests.
3. Données : téléchargement de Ciqual, licence dans `DECISIONS.md`, liaison des 377 ingrédients par lots (`redacteur-nutrition`), tests de données.
4. Migration drift V1 → V2 et nouvelles tables (choix C1), avec test depuis le schéma V1.
5. `tool/build_product_db` (fixture hors réseau) puis import de la base dans l'app.
6. Stock, scan, lien produit → ingrédient ; puis « Fait » / « Annuler » ; puis liste avec stock ; puis bonus du générateur.
7. Onglet Nutrition (journal, banque, pas, sport, pesées, bilan 7/30 j), navigation à 5 onglets.
8. Export/import V2, build release, vérification hors ligne complète.

## 9. Risques repérés

- **R1 — ML Kit et télémétrie.** La version « bundled » de ML Kit (utilisée par `mobile_scanner`) peut tirer `com.google.android.datatransport` (journalisation d'usage), qui déclare INTERNET et ACCESS_NETWORK_STATE dans son manifeste. À vérifier sur le **manifeste fusionné** dès le premier essai. Parades : retirer ces permissions avec `tools:node="remove"` (justifié dans `DECISIONS.md` ; sans permission, aucun envoi possible), ou un lecteur sans Google (zxing-cpp natif). Choix C9.
- **R2 — Taille de la base produits** (≤ 150 Mo) et temps d'import sur le téléphone : importer par copie du fichier décompressé en flux, puis ouvrir la base en lecture seule (`ATTACH`), plutôt que réinsérer les lignes dans la base principale.
- **R3 — Unités de cuisine** (c. à soupe, c. à café, pincée) : il faut une conversion en grammes pour les calories (choix C5).
- **R4 — Ingrédients du placard** : 73 des 377 ingrédients sont « placard » (huiles, sucre, farine…). SPEC-V2 §12 n'exige un code Ciqual que hors placard, mais les huiles pèsent lourd dans les kcal (choix C2).

## 10. Choix à valider

| # | Question | Proposition par défaut |
|---|---|---|
| **C1** | **Modèle de données V2** (changement du §4, donc soumis à validation). Nouvelles colonnes sur `ingredients` : code Ciqual, kcal, protéines, glucides, lipides, fibres, sucres, AG saturés, sel (pour 100 g), densité, origine des valeurs. Nouvelles tables : `products_custom`, `product_links` (code-barres → ingrédient), `stock_lots`, `stock_movements`, `meal_completions` (créneau ou extra fait, parts mangées, ajustements), `food_log_entries`, `meal_presets` + `meal_preset_items`, `nutrition_profile`, `nutrition_goals`, `body_weights`, `daily_steps`, `exercises`, `workouts`, `strength_sessions`, `strength_sets`. Base OFF dans un **fichier SQLite séparé** attaché en lecture seule. | Oui, tel quel. |
| **C2** | Valeurs nutritionnelles pour **tous** les ingrédients, placard compris (sel, eau, épices à 0 accepté), plutôt que seulement hors placard. | Tous. |
| **C3** | Valeurs Ciqual non numériques : « < x » → x pour glucides, lipides, sucres, AG saturés, sel ; 0 pour protéines et fibres. « traces » → 0. « - » (absent) → valeur d'un aliment Ciqual voisin, signalée dans le compte rendu. | Oui. |
| **C4** | Règle péjorative pour les nouvelles valeurs : sucres, AG saturés et sel en borne haute ; fibres en borne basse. Lipides : borne **haute** (règle de l'ancienne app). | Oui. |
| **C5** | Conversions : c. à soupe = 15 ml, c. à café = 5 ml, multipliées par la densité ; pincée = 0,5 g ; pièce = poids moyen du catalogue. | Oui. |
| **C6** | Journal alimentaire : valeurs **figées à la saisie** (kcal et macros copiées), pour qu'une réimport de la base ou une correction ne réécrive pas le passé. L'ancienne app recalculait. | Figer. |
| **C7** | Correspondance des moments : midi → déjeuner, soir → dîner ; petit-déjeuner et collation pour « j'ai mangé » et la banque. | Oui. |
| **C8** | Delta d'objectif modifiable (défauts +300 / −400 / 0 conservés). | Modifiable. |
| **C9** | Lecteur de codes-barres : `mobile_scanner` bundled, avec retrait des permissions réseau injectées si R1 se confirme ; repli sur un lecteur zxing natif si le retrait ne suffit pas. | Oui. |
| **C10** | Couleurs de direction de la balance : déficit et surplus dans des teintes neutres compatibles avec la palette Popote (tomate reste réservé à « générer » et « valider »). | Oui. |
| **C11** | Double comptage des séances (§7.1) : MET brut repris à l'identique. | Identique. |
| **C12** | Import de l'ancienne app : sauté tant que `docs/EXPORT_FORMAT.md` n'existe pas. Le produire dans l'ancienne app est un prompt séparé (SPEC-V2 §10). | Sauter pour l'instant. |
