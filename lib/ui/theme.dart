import 'package:flutter/material.dart';

import '../domain/enums.dart';

/// Direction visuelle (SPEC §3.8).
abstract final class Palette {
  static const basil = Color(0xFF2F7D4F);
  static const tomato = Color(0xFFE2553A);
  static const lightBg = Color(0xFFFFFFFF);
  static const darkBg = Color(0xFF121614);

  /// Bouton tomate : texte foncé pour un contraste AA (4,5:1) sur #E2553A.
  static const onTomato = Color(0xFF1A0A06);
}

const radius = 16.0;

FontWeight _w(TextStyle? s) => s?.fontWeight ?? FontWeight.w400;

/// Nunito est embarquée en police variable : l'axe `wght` suit `fontWeight`.
TextStyle? _nunito(TextStyle? s) => s?.copyWith(
  fontFamily: 'Nunito',
  fontVariations: [FontVariation('wght', _w(s).value.toDouble())],
);

TextTheme _textTheme(TextTheme base) => base.copyWith(
  displayLarge: _nunito(base.displayLarge),
  displayMedium: _nunito(base.displayMedium),
  displaySmall: _nunito(base.displaySmall),
  headlineLarge: _nunito(
    base.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
  ),
  headlineMedium: _nunito(
    base.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
  ),
  headlineSmall: _nunito(
    base.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
  ),
  titleLarge: _nunito(base.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
  titleMedium: _nunito(base.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
  titleSmall: _nunito(base.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
  bodyLarge: _nunito(base.bodyLarge),
  bodyMedium: _nunito(base.bodyMedium),
  bodySmall: _nunito(base.bodySmall),
  labelLarge: _nunito(base.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
  labelMedium: _nunito(base.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
  labelSmall: _nunito(base.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
);

ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final scheme =
      ColorScheme.fromSeed(
        seedColor: Palette.basil,
        brightness: brightness,
      ).copyWith(
        primary: dark ? const Color(0xFF7BC896) : Palette.basil,
        onPrimary: dark ? const Color(0xFF00210F) : Colors.white,
        tertiary: Palette.tomato,
        onTertiary: Palette.onTomato,
        surface: dark ? Palette.darkBg : Palette.lightBg,
      );
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    brightness: brightness,
    fontFamily: 'Nunito',
    scaffoldBackgroundColor: scheme.surface,
  );
  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
  return base.copyWith(
    textTheme: _textTheme(base.textTheme),
    cardTheme: CardThemeData(
      shape: shape,
      elevation: 1,
      shadowColor: Colors.black26,
      color: dark ? const Color(0xFF1C211E) : Colors.white,
      surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 6),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: _textTheme(base.textTheme).titleLarge
          ?.copyWith(color: scheme.onSurface),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: shape,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: shape,
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      ),
    ),
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );
}

/// Style des actions fortes (générer, valider) : accent tomate.
ButtonStyle strongAction(BuildContext context) => FilledButton.styleFrom(
  backgroundColor: Palette.tomato,
  foregroundColor: Palette.onTomato,
  minimumSize: const Size(48, 52),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
);

/// Vignette générée des recettes fournies : couleur et icône selon la base.
({Color color, IconData icon}) thumbFor(MainBase b) => switch (b) {
  MainBase.poultry => (
    color: const Color(0xFFF3C77A),
    icon: Icons.egg_alt_rounded,
  ),
  MainBase.beef => (
    color: const Color(0xFFD98C7A),
    icon: Icons.lunch_dining_rounded,
  ),
  MainBase.pork => (
    color: const Color(0xFFF2A9A0),
    icon: Icons.kebab_dining_rounded,
  ),
  MainBase.lamb => (
    color: const Color(0xFFCFA48A),
    icon: Icons.outdoor_grill_rounded,
  ),
  MainBase.fish => (
    color: const Color(0xFF8EC3E6),
    icon: Icons.set_meal_rounded,
  ),
  MainBase.seafood => (
    color: const Color(0xFF9FD3D0),
    icon: Icons.phishing_rounded,
  ),
  MainBase.legumes => (
    color: const Color(0xFFC9D88B),
    icon: Icons.grain_rounded,
  ),
  MainBase.tofu => (color: const Color(0xFFE8E2C8), icon: Icons.square_rounded),
  MainBase.eggs => (color: const Color(0xFFF7DE8A), icon: Icons.egg_rounded),
  MainBase.cheese => (
    color: const Color(0xFFF5D77E),
    icon: Icons.local_pizza_rounded,
  ),
  MainBase.pasta => (
    color: const Color(0xFFF0CF96),
    icon: Icons.ramen_dining_rounded,
  ),
  MainBase.rice => (
    color: const Color(0xFFE9E4D4),
    icon: Icons.rice_bowl_rounded,
  ),
  MainBase.grains => (
    color: const Color(0xFFDCC79A),
    icon: Icons.bakery_dining_rounded,
  ),
  MainBase.potatoes => (
    color: const Color(0xFFE3C48F),
    icon: Icons.restaurant_rounded,
  ),
  MainBase.vegetables => (
    color: const Color(0xFFA8D5A2),
    icon: Icons.eco_rounded,
  ),
  MainBase.sweet => (color: const Color(0xFFF2B5C8), icon: Icons.cake_rounded),
};
