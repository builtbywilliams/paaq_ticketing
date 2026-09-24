import 'package:flutter/material.dart';
import 'tokens.dart';

/// Builds the app-wide ThemeData from PAAQ tokens.
/// Widgets read colours/type from tokens directly; this wires the Material
/// defaults (scaffold bg, colour scheme, font) so anything not custom-styled
/// still looks on-brand.
class PaaqTheme {
  PaaqTheme._();

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: PaaqColors.pageBg,
      colorScheme: base.colorScheme.copyWith(
        primary: PaaqColors.teal,
        onPrimary: Colors.white,
        surface: PaaqColors.surface,
        onSurface: PaaqColors.textPrimary,
        error: PaaqColors.pink,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: PaaqText.family,
        bodyColor: PaaqColors.textPrimary,
        displayColor: PaaqColors.textPrimary,
      ),
      dividerColor: PaaqColors.line,
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
