---
name: verifier-hors-ligne
description: Full offline verification of Popote's release build — flutter build apk --release, then tool/check_offline.dart, then the relecteur-local audit. Use before any release or tag, after dependency changes, when the user asks "est-ce que l'app est bien 100 % locale ?", or whenever INTERNET/ACCESS_NETWORK_STATE, backups or network packages come up.
---

# Vérifier que l'app reste 100 % locale

Le source ne suffit pas : des plugins peuvent injecter des permissions dans le **manifeste fusionné**. On vérifie donc l'APK release réel (SPEC §1.1 et §1.5).

1. `flutter build apk --release`. Si le SDK Android ou une licence manque, c'est un cas où l'utilisateur doit intervenir : donne-lui la commande exacte (par exemple `! flutter doctor --android-licenses`).
2. `dart run tool/check_offline.dart`. Le script doit échouer (code ≠ 0) en cas de permission interdite dans l'APK, de paquet de la liste noire dans `pubspec.lock` ou de motif interdit dans `lib/`. Tant qu'il n'existe pas, l'écrire est la priorité (SPEC §1.5).
3. Délègue au sous-agent **`relecteur-local`** pour l'audit complet : sauvegardes Android, dépendances transitives, code.
4. En cas d'échec, corrige la cause plutôt que le contrôle. Exemple : retirer le plugin fautif, ou retirer la permission avec `tools:node="remove"` en le justifiant dans `DECISIONS.md`. Ne retire jamais un motif de la liste noire pour faire passer le script.

Compte rendu : permissions de l'APK release (liste), résultat du script, verdict du relecteur.
