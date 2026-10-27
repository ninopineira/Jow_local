import '../domain/enums.dart';

/// Tous les textes de l'interface, centralisés pour une future traduction.
abstract final class S {
  static const appName = 'Popote';

  // Onglets
  static const tabMenu = 'Menu';
  static const tabList = 'Liste';
  static const tabRecipes = 'Recettes';
  static const tabSettings = 'Réglages';

  // Commun
  static const cancel = 'Annuler';
  static const ok = 'OK';
  static const save = 'Enregistrer';
  static const delete = 'Supprimer';
  static const close = 'Fermer';
  static const next = 'Suivant';
  static const back = 'Retour';
  static const search = 'Rechercher';
  static const minutes = 'min';
  static const loading = 'Chargement…';
  static const errorGeneric = 'Une erreur est survenue.';
  static String servings(int n) => '$n ${n > 1 ? 'portions' : 'portion'}';
  static String people(int n) => '$n ${n > 1 ? 'personnes' : 'personne'}';
  static String minutesValue(int n) => '$n min';
  static const decrease = 'Diminuer';
  static const increase = 'Augmenter';

  // Premier lancement
  static const welcomeTitle = 'Bienvenue dans Popote';
  static const welcomeBody =
      'Quelques questions pour composer des menus à ton goût. '
      'Tout reste sur ton téléphone et se modifie ensuite dans les réglages.';
  static const stepPeople = 'Combien êtes-vous à table ?';
  static const stepDiet = 'Votre régime';
  static const stepAllergies = 'Allergies et intolérances';
  static const stepAversions = 'Ingrédients que vous n’aimez pas';
  static const stepEquipment = 'Vos équipements';
  static const stepSlots = 'Repas à planifier';
  static const stepTimes = 'Temps de préparation';
  static const start = 'C’est parti';
  static const noPork = 'Sans porc';
  static const allergyWarning =
      'Vérifie toujours l’étiquette des produits achetés : la composition '
      'peut varier selon les marques.';
  static const aversionHint = 'Rechercher un ingrédient';
  static const maxWeekday = 'En semaine, au plus';
  static const maxWeekend = 'Le week-end, au plus';
  static const weekStart = 'La semaine commence le';
  static const lunch = 'Midi';
  static const dinner = 'Soir';
  static const flexitarianHint = 'Viande au plus 3 repas par semaine.';

  static const weekdays = [
    'lundi',
    'mardi',
    'mercredi',
    'jeudi',
    'vendredi',
    'samedi',
    'dimanche',
  ];
  static String weekday(int day) => weekdays[day - 1];
  static String weekdayCap(int day) {
    final w = weekday(day);
    return w[0].toUpperCase() + w.substring(1);
  }

  static const months = [
    'janvier',
    'février',
    'mars',
    'avril',
    'mai',
    'juin',
    'juillet',
    'août',
    'septembre',
    'octobre',
    'novembre',
    'décembre',
  ];
  static String date(DateTime d) => '${d.day} ${months[d.month - 1]}';
  static String weekOf(DateTime d) => 'Semaine du ${date(d)}';

  static String meal(Meal m) => m == Meal.lunch ? lunch : dinner;

  static String diet(Diet d) => switch (d) {
    Diet.omnivore => 'Omnivore',
    Diet.flexitarian => 'Flexitarien',
    Diet.pescetarian => 'Pescétarien',
    Diet.vegetarian => 'Végétarien',
    Diet.vegan => 'Végan',
  };

  static String dietShort(Diet d) => switch (d) {
    Diet.omnivore => 'omnivore',
    Diet.flexitarian => 'flexitarien',
    Diet.pescetarian => 'pescétarien',
    Diet.vegetarian => 'végétarien',
    Diet.vegan => 'végan',
  };

  static String allergen(Allergen a) => switch (a) {
    Allergen.gluten => 'Gluten',
    Allergen.crustaceans => 'Crustacés',
    Allergen.eggs => 'Œufs',
    Allergen.fish => 'Poisson',
    Allergen.peanuts => 'Arachides',
    Allergen.soy => 'Soja',
    Allergen.milk => 'Lait',
    Allergen.nuts => 'Fruits à coque',
    Allergen.celery => 'Céleri',
    Allergen.mustard => 'Moutarde',
    Allergen.sesame => 'Sésame',
    Allergen.sulphites => 'Sulfites',
    Allergen.lupin => 'Lupin',
    Allergen.molluscs => 'Mollusques',
  };

  static String withoutAllergen(Allergen a) =>
      'sans ${allergen(a).toLowerCase()}';

  static String equipment(Equipment e) => switch (e) {
    Equipment.oven => 'Four',
    Equipment.hob => 'Plaques',
    Equipment.microwave => 'Micro-ondes',
    Equipment.blender => 'Mixeur',
    Equipment.multicooker => 'Robot cuiseur',
    Equipment.airFryer => 'Friteuse à air',
    Equipment.steamer => 'Cuiseur vapeur',
    Equipment.pressureCooker => 'Autocuiseur',
  };

  static String withoutEquipment(Equipment e) =>
      'sans ${equipment(e).toLowerCase()}';

  static String aisle(Aisle a) => switch (a) {
    Aisle.produce => 'Fruits et légumes',
    Aisle.meatFish => 'Boucherie et poissonnerie',
    Aisle.dairy => 'Crèmerie',
    Aisle.savory => 'Épicerie salée',
    Aisle.sweet => 'Épicerie sucrée',
    Aisle.frozen => 'Surgelés',
    Aisle.bakery => 'Boulangerie',
    Aisle.drinks => 'Boissons',
    Aisle.misc => 'Divers',
  };

  static String recipeType(RecipeType t) => switch (t) {
    RecipeType.main => 'Plat',
    RecipeType.dessert => 'Dessert',
    RecipeType.breakfast => 'Petit-déjeuner',
  };

  static String difficulty(Difficulty d) => switch (d) {
    Difficulty.easy => 'Facile',
    Difficulty.medium => 'Moyen',
    Difficulty.hard => 'Difficile',
  };

  static String mainBase(MainBase b) => switch (b) {
    MainBase.poultry => 'Volaille',
    MainBase.beef => 'Bœuf et veau',
    MainBase.pork => 'Porc',
    MainBase.lamb => 'Agneau',
    MainBase.fish => 'Poisson',
    MainBase.seafood => 'Fruits de mer',
    MainBase.legumes => 'Légumineuses',
    MainBase.tofu => 'Tofu et soja',
    MainBase.eggs => 'Œufs',
    MainBase.cheese => 'Fromage',
    MainBase.pasta => 'Pâtes',
    MainBase.rice => 'Riz',
    MainBase.grains => 'Céréales',
    MainBase.potatoes => 'Pommes de terre',
    MainBase.vegetables => 'Légumes',
    MainBase.sweet => 'Sucré',
  };

  static String unit(Unit u) => switch (u) {
    Unit.g => 'g',
    Unit.kg => 'kg',
    Unit.ml => 'ml',
    Unit.cl => 'cl',
    Unit.l => 'l',
    Unit.piece => 'pièce(s)',
    Unit.tbsp => 'c. à soupe',
    Unit.tsp => 'c. à café',
    Unit.pinch => 'pincée(s)',
  };

  static String marker(Marker m) => switch (m) {
    Marker.meat => 'Viande',
    Marker.pork => 'Porc',
    Marker.poultry => 'Volaille',
    Marker.fish => 'Poisson',
    Marker.seafood => 'Fruits de mer',
    Marker.dairy => 'Produit laitier',
    Marker.egg => 'Œuf',
    Marker.honey => 'Miel',
    Marker.gelatin => 'Gélatine',
    Marker.alcohol => 'Alcool',
  };

  static String theme(ThemePreference t) => switch (t) {
    ThemePreference.system => 'Système',
    ThemePreference.light => 'Clair',
    ThemePreference.dark => 'Sombre',
  };

  // Menu
  static const generate = 'Générer le menu';
  static const validate = 'Valider le menu';
  static const validated = 'Menu validé';
  static const validatedHint = 'Le menu reste modifiable : la liste suit.';
  static const previousWeek = 'Semaine précédente';
  static const nextWeek = 'Semaine suivante';
  static const emptySlot = 'À remplir';
  static const eatingOut = 'Repas dehors';
  static String leftoversOf(String title) => 'Restes de : $title';
  static const leftovers = 'Restes';
  static const locked = 'Verrouillé';
  static const lock = 'Verrouiller';
  static const unlock = 'Déverrouiller';
  static const replace = 'Remplacer';
  static const alternatives = 'Alternatives compatibles';
  static const chooseRecipe = 'Choisir une recette';
  static const searchMore = 'Chercher une autre recette';
  static const clearSlot = 'Vider le créneau';
  static const markEatingOut = 'Repas dehors';
  static const markLeftovers = 'Manger des restes de…';
  static const cookDouble = 'Cuisiner en double pour…';
  static const seeRecipe = 'Voir la recette';
  static const slotServings = 'Portions du créneau';
  static const extras = 'Extras de la semaine';
  static const extrasHint =
      'Desserts, goûters ou petits-déjeuners sans créneau.';
  static const addExtra = 'Ajouter un extra';
  static const noActiveSlots =
      'Aucun repas à planifier : choisis tes créneaux dans les réglages.';
  static const generateFirst = 'Génère un menu ou choisis des recettes.';
  static const review = 'Bilan de la semaine';
  static const reviewPrompt =
      'La semaine est passée : fais le bilan des recettes.';
  static const reviewOpen = 'Faire le bilan';
  static const reviewLater = 'Plus tard';
  static const reviewNothing = 'Aucune recette cuisinée cette semaine.';
  static const liked = 'On a aimé';
  static const disliked = 'Pas aimé';
  static const skip = 'Passer';
  static const reviewDone = 'Terminer le bilan';
  static const reviewThanks = 'Bilan enregistré.';
  static String shortfall(int count, List<String> constraints) {
    final c = constraints.isEmpty ? '' : ' avec ${constraints.join(' + ')}';
    final n = count <= 1
        ? '$count recette compatible'
        : '$count recettes compatibles';
    return 'Seulement $n$c : certains créneaux restent vides.';
  }

  static String shortfallTime(int count) =>
      'Pas assez de recettes compatibles dans le temps disponible '
      '($count au total) : certains créneaux restent vides.';
  static const addedToMenu = 'Ajouté au menu.';
  static const chooseSlot = 'Choisir le créneau';
  static const leftoversSource = 'Restes de quel repas ?';
  static const doubleTarget = 'Pour quel repas ?';
  static const noSourceSlot = 'Aucun repas cuisiné avant ce créneau.';

  // Liste
  static const listTitle = 'Liste des ingrédients';
  static const listEmpty = 'Valide ton menu pour obtenir ta liste';
  static const pantrySection = 'À vérifier dans tes placards';
  static const manualSection = 'Articles ajoutés';
  static const addItem = 'Ajouter un article';
  static const bought = 'Acheté';
  static const atHome = 'Déjà à la maison';
  static String forRecipes(List<String> titles) =>
      'pour : ${titles.join(', ')}';
  static const copy = 'Copier';
  static const share = 'Partager';
  static const copied = 'Liste copiée.';
  static String shareTitle(DateTime d) =>
      'Courses — ${weekOf(d).toLowerCase()}';
  static const optionalTag = 'facultatif';

  // Recettes
  static const recipesTitle = 'Recettes';
  static const searchRecipes = 'Rechercher une recette';
  static const filterQuick = '≤ 30 min';
  static const filterFavorites = 'Favoris';
  static const filterToPlace = 'À caser';
  static const filterPersonal = 'Perso';
  static const filterSeason = 'De saison';
  static const showAll = 'Tout afficher';
  static const noRecipes = 'Aucune recette ne correspond.';
  static const newRecipe = 'Nouvelle recette';
  static const favorite = 'Favori';
  static const toPlace = 'À caser';
  static const addToMenu = 'Ajouter au menu';
  static const duplicate = 'Dupliquer';
  static const duplicateSuffix = ' (ma version)';
  static const edit = 'Modifier';
  static const cookMode = 'Mode cuisine';
  static const ingredients = 'Ingrédients';
  static const steps = 'Étapes';
  static const prep = 'Préparation';
  static const cook = 'Cuisson';
  static const equipmentTitle = 'Équipements';
  static const allergensTitle = 'Allergènes';
  static const noAllergen = 'Aucun des 14 allergènes réglementaires';
  static const dislikedBadge =
      'Pas aimée : n’est plus proposée automatiquement';
  static const undislike = 'Proposer à nouveau';
  static const dislike = 'Ne plus proposer';
  static const deleteRecipe = 'Supprimer la recette ?';
  static const deleteRecipeBody = 'Elle sera retirée des menus.';
  static String stepOf(int i, int n) => 'Étape $i sur $n';
  static const finish = 'Terminé';
  static String incompatible(String reasons) => 'Incompatible : $reasons';
  static String reasonAversion(String name) => 'contient $name';
  static const reasonPork = 'contient du porc';
  static String reasonDiet(Diet d) => 'pas ${dietShort(d)}';
  static String reasonAllergen(Allergen a) =>
      'contient : ${allergen(a).toLowerCase()}';
  static String reasonEquipment(Equipment e) =>
      'demande : ${equipment(e).toLowerCase()}';

  // Éditeur
  static const editorNew = 'Nouvelle recette';
  static const editorEdit = 'Modifier la recette';
  static const title = 'Titre';
  static const description = 'Description courte';
  static const baseServings = 'Portions de base';
  static const prepMin = 'Préparation (min)';
  static const cookMin = 'Cuisson (min)';
  static const type = 'Type';
  static const difficultyLabel = 'Difficulté';
  static const mainBaseLabel = 'Base principale';
  static const addIngredient = 'Ajouter un ingrédient';
  static const quantity = 'Quantité';
  static const unitLabel = 'Unité';
  static const optional = 'Facultatif';
  static const note = 'Note (émincé…)';
  static const addStep = 'Ajouter une étape';
  static String stepLabel(int i) => 'Étape $i';
  static const photo = 'Photo';
  static const takePhoto = 'Prendre une photo';
  static const pickPhoto = 'Choisir dans la galerie';
  static const removePhoto = 'Retirer la photo';
  static String createIngredient(String name) => 'Créer « $name »';
  static const newIngredient = 'Nouvel ingrédient';
  static const name = 'Nom';
  static const aisleLabel = 'Rayon';
  static const markers = 'Contient';
  static const pieceWeight = 'Poids moyen d’une pièce (g)';
  static const pantry = 'Produit de placard';
  static const perishable = 'Périssable';
  static const computedDiet = 'Calculé depuis les ingrédients';
  static const titleRequired = 'Donne un titre à la recette.';
  static const ingredientsRequired = 'Ajoute au moins un ingrédient.';
  static const stepsRequired = 'Ajoute au moins une étape.';
  static const compatibleDiets = 'Régimes compatibles';

  // Réglages
  static const settingsTitle = 'Réglages';
  static const householdProfile = 'Profil du foyer';
  static const favoriteShare = 'Part de favoris dans les menus';
  static const antiRepeat = 'Ne pas reprendre une recette pendant';
  static String weeks(int n) =>
      n == 0 ? 'désactivé' : '$n semaine${n > 1 ? 's' : ''}';
  static const aisleOrder = 'Ordre des rayons';
  static const themeLabel = 'Thème';
  static const data = 'Mes données';
  static const export = 'Exporter mes données';
  static const exportHint = 'Fichier zip enregistré où tu veux.';
  static const exportDone = 'Export enregistré.';
  static const import = 'Importer des données';
  static const importPreview = 'Importer ce fichier ?';
  static String importSummary(
    int recipes,
    int favorites,
    int menus,
    bool profile,
  ) =>
      '${profile ? 'Profil du foyer, ' : ''}$recipes recette(s) perso, '
      '$favorites favori(s), $menus menu(s).';
  static const merge = 'Fusionner';
  static const replaceAll = 'Remplacer';
  static const importDone = 'Import terminé.';
  static const importError = 'Fichier illisible ou d’un autre format.';
  static const reset = 'Tout réinitialiser';
  static const resetConfirm1 = 'Effacer toutes tes données ?';
  static const resetConfirm1Body =
      'Profil, recettes perso, favoris, menus et listes seront supprimés.';
  static const resetConfirm2 = 'Vraiment tout effacer ?';
  static const resetConfirm2Body = 'Cette action est définitive.';
  static const resetDone = 'Données effacées.';
  static const about = 'À propos';
  static const aboutBody =
      'Popote ne se connecte jamais à internet : elle ne demande même pas '
      'l’autorisation d’y accéder. Ton profil, tes recettes et tes menus '
      'restent uniquement sur ce téléphone.';
  static const aboutData =
      'Aucune sauvegarde cloud automatique : pour changer de téléphone, '
      'utilise l’export de tes données.';
  static const aboutFont = 'Police Nunito, licence SIL Open Font License.';
  static const version = 'Version 1.0.0';
}
