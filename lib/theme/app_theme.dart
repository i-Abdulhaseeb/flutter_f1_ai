import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF131313);
  static const Color surface = Color(0xFF131313);
  static const Color surfaceContainer = Color(0xFF1F1F1F);
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color surfaceContainerHighest = Color(0xFF353535);
  static const Color surfaceBright = Color(0xFF393939);
  static const Color surfaceDim = Color(0xFF131313);

  static const Color primary = Color(0xFFFFB4A8);
  static const Color primaryContainer = Color(0xFFE10600);
  static const Color primaryFixed = Color(0xFFFFDAD4);
  static const Color primaryFixedDim = Color(0xFFFFB4A8);
  static const Color onPrimary = Color(0xFF680200);
  static const Color onPrimaryContainer = Color(0xFFFFF2F0);
  static const Color inversePrimary = Color(0xFFC00500);

  static const Color onSurface = Color(0xFFE2E2E2);
  static const Color onSurfaceVariant = Color(0xFFE9BCB5);
  static const Color onBackground = Color(0xFFE2E2E2);

  static const Color secondary = Color(0xFFC8C6C5);
  static const Color secondaryContainer = Color(0xFF4A4949);
  static const Color onSecondary = Color(0xFF313030);

  static const Color tertiary = Color(0xFFC6C6CB);
  static const Color tertiaryContainer = Color(0xFF6F7075);

  static const Color outline = Color(0xFFAF8781);
  static const Color outlineVariant = Color(0xFF5E3F3A);

  static const Color error = Color(0xFFFFB4AB);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onError = Color(0xFF690005);

  static TextStyle get displayLg => GoogleFonts.spaceGrotesk(
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: -0.02 * 32,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );

  static TextStyle get headlineMd => GoogleFonts.spaceGrotesk(
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: -0.01 * 24,
    fontWeight: FontWeight.w900,
    color: primary,
    fontStyle: FontStyle.italic,
  );

  static TextStyle get telemetryNum => GoogleFonts.jetBrainsMono(
    fontSize: 18,
    height: 22 / 18,
    letterSpacing: -0.05 * 18,
    fontWeight: FontWeight.w700,
    color: primaryContainer,
    fontStyle: FontStyle.italic,
  );

  static TextStyle get bodyLg => GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
    color: onSurface,
  );

  static TextStyle get bodySm => GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
    color: onSurface,
  );

  static TextStyle get labelCaps => GoogleFonts.jetBrainsMono(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.1 * 12,
    fontWeight: FontWeight.w500,
    color: onSurfaceVariant,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      error: error,
      errorContainer: errorContainer,
      onError: onError,
      surface: surface,
      onSurface: onSurface,
      outline: outline,
      outlineVariant: outlineVariant,
    ),
    textTheme: TextTheme(
      displayLarge: displayLg,
      headlineMedium: headlineMd,
      bodyLarge: bodyLg,
      bodySmall: bodySm,
      labelSmall: labelCaps,
    ),
  );
}
