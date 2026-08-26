import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Super Smash League branding — red / green / gold from the SSL poster.
abstract final class AppTheme {
  /// Deep maroon primary (poster titles, filled buttons).
  static const Color primary = Color(0xFF8B1E1E);

  /// Bright sports green (secondary titles, nav indicator).
  static const Color secondary = Color(0xFF2E9B3C);

  /// Medal / star gold accent.
  static const Color accent = Color(0xFFE8B923);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF7F7F5);
  static const Color ink = Color(0xFF1A1A1A);

  /// Legacy aliases — map to SSL primary for call-site compatibility.
  static const Color goldDeep = primary;
  static const Color gold = accent;
  static const Color goldBright = accent;
  static const Color ivory = surface;
  static const Color mist = surfaceMuted;
  static const Color courtGreen = primary;

  static ThemeData light() {
    final base = ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      surface: surface,
      brightness: Brightness.light,
    );

    final textTheme = GoogleFonts.dmSansTextTheme().copyWith(
      displayLarge: GoogleFonts.outfit(
        fontWeight: FontWeight.w700,
        color: ink,
      ),
      displayMedium: GoogleFonts.outfit(
        fontWeight: FontWeight.w700,
        color: ink,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontWeight: FontWeight.w600,
        color: ink,
      ),
      titleLarge: GoogleFonts.outfit(
        fontWeight: FontWeight.w600,
        color: ink,
      ),
      titleMedium: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: base.copyWith(
        primary: primary,
        onPrimary: Colors.white,
        secondary: secondary,
        onSecondary: Colors.white,
        tertiary: accent,
        onTertiary: ink,
        primaryContainer: const Color(0xFFB33A3A),
        onPrimaryContainer: Colors.white,
        secondaryContainer: const Color(0xFFA8D5AE),
        onSecondaryContainer: ink,
        surface: surface,
        onSurface: ink,
      ),
      scaffoldBackgroundColor: surfaceMuted,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.94),
        indicatorColor: secondary.withValues(alpha: 0.22),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? primary : ink.withValues(alpha: 0.5),
          );
        }),
      ),
      // Solid buttons: primary red + white label.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white70,
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
        ),
      ),
      // Text buttons on light screens: dark red (never white-on-white).
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return Colors.white;
            return primary;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return primary;
            return Colors.white;
          }),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: primary.withValues(alpha: 0.1),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: primary,
        contentTextStyle: GoogleFonts.dmSans(color: Colors.white),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: accent,
      ),
      chipTheme: ChipThemeData(
        selectedColor: primary,
        checkmarkColor: Colors.white,
        labelStyle: GoogleFonts.dmSans(color: ink),
        secondaryLabelStyle: GoogleFonts.dmSans(color: Colors.white),
      ),
    );
  }
}

/// Soft SSL wash (red / green / gold) behind primary shells.
class CourtBackdrop extends StatelessWidget {
  const CourtBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFBF8),
            Color(0xFFF5F0D8),
            Color(0xFFE4F0E6),
            Color(0xFFF0E0E0),
          ],
        ),
      ),
      child: child,
    );
  }
}
