# Format d'export de l'ancienne app de nutrition (`app-nutrition-export`, version 1)

> **Origine** : ce format a été **proposé côté Popote** (session du 2026-10-28) à partir du schéma réel de
> l'ancienne app (`C:\Projets\App_nutrition\src\db\schema.ts`, voir `docs/INVENTAIRE_NUTRITION.md` §4),
> car l'ancienne app n'avait aucun export. Le prompt séparé à lancer dans l'ancienne app (SPEC-V2 §10) doit
> produire **exactement** ce fichier. Popote l'importe depuis Réglages → « Importer depuis l'ancienne app ».

Un seul fichier JSON UTF-8 (`app-nutrition-export-AAAAMMJJ.json`). Dates en texte ISO `AAAA-MM-JJ` (jour
local), valeurs nutritionnelles **pour 100 g**, nombres JSON (jamais de chaînes). Une valeur inconnue est
`null` ou absente, jamais `0`.

```json
{
  "format": "app-nutrition-export",
  "version": 1,
  "exportedAt": "2026-10-28T09:00:00",
  "profile": { "sex": "male", "birthDate": "1996-11-15", "heightCm": 180, "activityLevel": "moderate" },
  "goals": [ { "startDate": "2026-09-01", "kind": "cut", "dailyKcalDelta": -400, "targetWeightKg": null } ],
  "foods": [
    { "id": 12, "barcode": "3250390000001", "name": "Spaghetti", "brand": "Marque X",
      "kcalPer100g": 357, "proteinPer100g": 12.5, "carbsPer100g": 71, "fatPer100g": 1.5,
      "kcalMinPer100g": null, "kcalMaxPer100g": null, "proteinMinPer100g": null, "proteinMaxPer100g": null,
      "carbsMinPer100g": null, "carbsMaxPer100g": null, "fatMinPer100g": null, "fatMaxPer100g": null,
      "source": "off" }
  ],
  "meals": [ { "id": 40, "date": "2026-10-27", "slot": "lunch", "note": null,
               "items": [ { "foodId": 12, "quantityG": 120 } ] } ],
  "mealPresets": [ { "name": "Petit-déj classique", "defaultSlot": "breakfast",
                     "items": [ { "foodId": 12, "quantityG": 60 } ] } ],
  "dailySteps": [ { "date": "2026-10-27", "steps": 9500 } ],
  "workouts": [ { "date": "2026-10-27", "exerciseName": "Course (10 km/h)", "met": 9.8, "durationMin": 30,
                  "intensity": "moderate", "kcalOverride": null, "note": null } ],
  "strengthSessions": [ { "date": "2026-10-26", "name": "Jambes", "durationMin": null, "kcalOverride": null,
                          "note": null,
                          "sets": [ { "exerciseName": "Squat", "setIndex": 1, "reps": 8, "weightKg": 100,
                                      "restSec": 120 } ] } ],
  "bodyMetrics": [ { "date": "2026-10-20", "weightKg": 75, "bodyFatPct": null } ]
}
```

| Clé | Table d'origine | Codes |
|---|---|---|
| `profile` | `profile` (ligne 1) | `sex` : `male`/`female` ; `activityLevel` : `sedentary`, `light`, `moderate`, `active`, `very_active` |
| `goals` | `goals` | `kind` : `bulk`, `cut`, `maintain` |
| `foods` | `foods` (avec fourchettes `_min`/`_max`) | `source` : `off`, `ciqual`, `manual` |
| `meals[].items` | `meals` + `meal_items` | `slot` : `breakfast`, `lunch`, `dinner`, `snack` |
| `mealPresets` | `meal_presets` + `meal_preset_items` | `defaultSlot` : idem ou `null` |
| `dailySteps` | `daily_steps` | |
| `workouts` | `workouts` + nom et MET de `exercises` | `intensity` : `light`, `moderate`, `vigorous` |
| `strengthSessions[].sets` | `strength_sessions` + `strength_sets` + nom de `exercises` | `weightKg` 0 = poids du corps |
| `bodyMetrics` | `body_metrics` | |

## Import dans Popote

- **Aperçu puis confirmation** : nombre d'éléments par catégorie et ce qui est déjà présent.
- **Idempotent** : réimporter le même fichier ne crée aucun doublon. Repas : une entrée de journal par ligne,
  repérée par `oldapp:meal:<id>:<rang>`. Activités, séances et pesées : par date et contenu. Pas : une valeur
  par jour. Repas de la banque : par nom. Produits : par code-barres.
- **Journal** : valeurs figées à l'import, avec la lecture prudente des fourchettes (inventaire §3.10).
- **Aliments avec code-barres** : deviennent des produits perso, sauf si un produit perso existe déjà pour ce code.
- **Profil et objectifs** : le profil n'est importé que si Popote n'en a pas encore. Un objectif est ajouté
  s'il n'existe pas déjà à la même date.
- Le stock n'est pas touché (l'ancienne app n'en avait pas).
