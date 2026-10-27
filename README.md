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
