import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';


// Theme.of(context).extension<AppTextStyles>()!.monoTime

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle monoTime;
  final TextStyle monoDate;
  final TextStyle monoMedal;
  final TextStyle monoTimeSmall;

  const AppTextStyles({
    required this.monoTime,
    required this.monoDate,
    required this.monoMedal,
    required this.monoTimeSmall,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? monoTime,
    TextStyle? monoDate,
    TextStyle? monoMedal,
    TextStyle? monoTimeSmall,
  }) {
    return AppTextStyles(
      monoTime: monoTime ?? this.monoTime,
      monoDate: monoDate ?? this.monoDate,
      monoMedal: monoMedal ?? this.monoMedal,
      monoTimeSmall: monoTimeSmall ?? this.monoTimeSmall,
    );
  }

  @override
  AppTextStyles lerp(covariant ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      monoTime: TextStyle.lerp(monoTime, other.monoTime, t)!,
      monoDate: TextStyle.lerp(monoDate, other.monoDate, t)!,
      monoMedal: TextStyle.lerp(monoMedal, other.monoMedal, t)!,
      monoTimeSmall: TextStyle.lerp(monoTimeSmall, other.monoTimeSmall, t)!,
    );
  }
}

class AppDecorations extends ThemeExtension<AppDecorations> {
  final BoxDecoration cardDecoration;

  const AppDecorations({
    required this.cardDecoration,
  });

  @override
  AppDecorations copyWith({
    BoxDecoration? cardDecoration,
  }) {
    return AppDecorations(
      cardDecoration: cardDecoration ?? this.cardDecoration,
    );
  }

  @override
  AppDecorations lerp(covariant ThemeExtension<AppDecorations>? other, double t) {
    if (other is! AppDecorations) return this;
    return AppDecorations(
      cardDecoration: BoxDecoration.lerp(cardDecoration, other.cardDecoration, t)!,
    );
  }
}

abstract final class AppTheme {

  static TextTheme _buildTextTheme(ColorScheme scheme) {
    final base = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(color: scheme.onSurface),
      displayMedium: base.displayMedium?.copyWith(color: scheme.onSurface),
      displaySmall: base.displaySmall?.copyWith(color: scheme.onSurface),
      headlineLarge: base.headlineLarge?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: scheme.onSurface,
        fontSize: 16,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: scheme.onSurface,
        fontSize: 14,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: scheme.onSurfaceVariant,
        fontSize: 12,
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: base.labelMedium?.copyWith(color: scheme.onSurface),
      labelSmall: base.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
    );
  }

  static AppTextStyles _buildAppTextStyles(ColorScheme scheme) {
    final mono = GoogleFonts.jetBrainsMono();
    return AppTextStyles(
      monoTime: mono.copyWith(
        color: scheme.onSurface,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      monoDate: mono.copyWith(
        color: scheme.onSurfaceVariant,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
      ),
      monoMedal: mono.copyWith(
        color: AppColors.onSurface,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
      monoTimeSmall: mono.copyWith(
        color: scheme.onSurfaceVariant,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
      ),
    );
  }

  static AppDecorations _buildAppDecorations(ColorScheme scheme) {
    return AppDecorations(
      cardDecoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outline.withAlpha(80), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }

  static ThemeData dark() {
    final scheme = AppColors.darkScheme;
    final textTheme = _buildTextTheme(scheme);
    final appTextStyles = _buildAppTextStyles(scheme);
    final appDecorations = _buildAppDecorations(scheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      extensions: [appTextStyles, appDecorations],

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: scheme.primary.withAlpha(40),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: scheme.primary, size: 24);
          }
          return IconThemeData(color: scheme.onSurfaceVariant, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w600,
            );
          }
          return textTheme.labelSmall?.copyWith(
            color: scheme.onSurfaceVariant,
          );
        }),
        elevation: 0,
        height: 64,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),

      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outline, width: 0.5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      dividerTheme: DividerThemeData(
        color: scheme.outline,
        thickness: 0.5,
        space: 1,
      ),

      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodySmall,
        iconColor: scheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHigh,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        prefixIconColor: scheme.onSurfaceVariant,
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.primary.withAlpha(30);
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.primary;
            }
            return scheme.onSurfaceVariant;
          }),
          side: WidgetStateProperty.all(
            BorderSide(color: scheme.outline),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          textStyle: WidgetStateProperty.all(
            textTheme.labelLarge,
          ),
          visualDensity: VisualDensity.compact,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: textTheme.labelLarge,
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),

      expansionTileTheme: ExpansionTileThemeData(
        collapsedIconColor: scheme.onSurfaceVariant,
        iconColor: scheme.primary,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
        shape: Border.all(color: Colors.transparent),
        collapsedShape: Border.all(color: Colors.transparent),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return scheme.onSurfaceVariant;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary.withAlpha(60);
          }
          return scheme.surfaceContainerHighest;
        }),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return scheme.onSurfaceVariant;
        }),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
      ),

      splashColor: scheme.primary.withAlpha(20),
      highlightColor: scheme.primary.withAlpha(12),

      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 22),
    );
  }
}
