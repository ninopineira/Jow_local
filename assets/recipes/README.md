# Données fournies

- `ingredients.json` : catalogue (schéma `ingredients.schema.json`).
- `recipes/<lot>.json` : un fichier par lot (schéma `recipes.schema.json`).
- `seed.json` : `{"version": N, "lots": [...]}`. Incrémenter `version` à chaque modification des données : l'app ré-importe par slug sans toucher l'état utilisateur ni les recettes perso.

## Conventions

- `aisle` : produce (fruits et légumes), meat_fish (boucherie et poissonnerie), dairy (crèmerie), savory (épicerie salée), sweet (épicerie sucrée), frozen (surgelés), bakery (boulangerie), drinks (boissons), misc (divers).
- `markers` (régime) : meat (toute chair d'animal terrestre, y compris porc et volaille), pork, poultry, fish, seafood (crustacés et mollusques), dairy, egg, honey, gelatin, alcohol.
  Cohérence exigée : pork ⇒ meat, poultry ⇒ meat ; fish ⇔ allergène fish ; egg ⇔ eggs ; dairy ⇔ milk ; seafood ⇒ crustaceans ou molluscs.
- `allergens` : les 14 allergènes réglementaires (gluten, crustaceans, eggs, fish, peanuts, soy, milk, nuts, celery, mustard, sesame, sulphites, lupin, molluscs), y compris les allergènes cachés des produits transformés.
- `seasonMonths` : mois de saison (France métropolitaine) des fruits et légumes frais ; absent pour les produits disponibles toute l'année.
- `equipment` : oven (four), hob (plaques), microwave, blender (mixeur), multicooker (robot cuiseur), air_fryer, steamer (cuiseur vapeur), pressure_cooker (autocuiseur).
- Le régime et les allergènes d'une recette ne sont jamais saisis : ils sont calculés depuis les ingrédients.
