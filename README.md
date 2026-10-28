# Popote

Planificateur de menus de la semaine pour Android, **100 % hors ligne** : l'app ne se connecte jamais à internet et les données du foyer restent sur le téléphone.

Spécification complète : [SPEC.md](SPEC.md). Décisions : [DECISIONS.md](DECISIONS.md).

## Développement (Windows)

```sh
flutter pub get
flutter analyze
flutter test
flutter run                        # téléphone Android branché en USB
```

## Contrôle hors ligne

```sh
flutter build apk --release
dart run tool/check_offline.dart   # échoue si l'APK, pubspec.lock ou lib/ enfreint la règle hors ligne
```

## Données V2 (pendant le développement uniquement)

Ces scripts utilisent internet **sur le PC** ; l'app, elle, ne s'y connecte jamais.

```sh
# Base produits Open Food Facts (export lu en flux, rien de stocké décompressé)
dart run tool/build_product_db.dart            # → build/product_db/produits-fr-AAAAMMJJ.db.gz + rapport
dart run tool/build_product_db.dart --source extrait.csv --max-mb 150   # fichier local, taille visée

# Valeurs nutritionnelles des ingrédients (table Ciqual 2025, Licence Ouverte Etalab 2.0)
dart run tool/prepare_ciqual.dart <dossier des XML Ciqual>   # → tool/data/ciqual/ciqual_2025.tsv
dart run tool/build_nutrition.dart                           # → assets/recipes/nutrition.json
```

Pour installer la base produits : copier `produits-fr-AAAAMMJJ.db.gz` sur le téléphone par câble USB, puis
Réglages → « Base produits » → « Importer une base produits ». Réimporter un fichier plus récent remplace la
base sans toucher aux produits perso ni aux liens produit → ingrédient.
