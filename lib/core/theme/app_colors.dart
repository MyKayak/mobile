import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF2979FF);
  static const Color primaryContainer = Color(0xFF1A4FA0);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFFD6E3FF);

  static const Color surface = Color(0xFF0D1117);
  static const Color surfaceContainer = Color(0xFF161B22);
  static const Color surfaceContainerHigh = Color(0xFF21262D);
  static const Color surfaceContainerHighest = Color(0xFF2D333B);

  static const Color onSurface = Color(0xFFE6EDF3);
  static const Color onSurfaceVariant = Color(0xFF8B949E);

  static const Color outline = Color(0xFF30363D);
  static const Color outlineVariant = Color(0xFF21262D);
  
  static const Color gold = Color(0xFFFFD700);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color bronze = Color(0xFFCD7F32);

  static const Color error = Color(0xFFF85149);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color scrim = Color(0x99000000);

  static ColorScheme get darkScheme => const ColorScheme.dark(
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        onPrimaryContainer: onPrimaryContainer,
        secondary: primary,
        secondaryContainer: primaryContainer,
        surface: surface,
        surfaceContainerLowest: surface,
        surfaceContainerLow: surfaceContainer,
        surfaceContainer: surfaceContainer,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainerHighest: surfaceContainerHighest,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        error: error,
        onError: onError,
        scrim: scrim,
      );
}
