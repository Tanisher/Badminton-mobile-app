import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Golden court branding for Badminton Manager.
abstract final class AppTheme {
  static const Color goldDeep = Color(0xFF8A6A12);
  static const Color gold = Color(0xFFC9A227);
  static const Color goldBright = Color(0xFFE0B83A);
  static const Color ivory = Color(0xFFFFFBF0);
  static const Color mist = Color(0xFFFFF8E7);
  static const Color ink = Color(0xFF2A2208);

  /// Kept for call sites that still reference the old name.
  static const Color courtGreen = goldDeep;

  static ThemeData light() {
    final base = ColorScheme.fromSeed(
      seedColor: gold,
      primary: goldDeep,
      secondary: goldBright,
      surface: mist,
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
        primary: goldDeep,
        onPrimary: Colors.white,
        secondary: gold,
        onSecondary: Colors.white,
        primaryContainer: gold,
        onPrimaryContainer: Colors.white,
        secondaryContainer: goldBright,
        onSecondaryContainer: Colors.white,
      ),
      scaffoldBackgroundColor: mist,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: goldDeep,
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
        indicatorColor: gold.withValues(alpha: 0.22),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? goldDeep : ink.withValues(alpha: 0.5),
          );
        }),
      ),
      // Solid buttons: gold fill + white label (readable everywhere).
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: goldDeep,
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
          backgroundColor: goldDeep,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
        ),
      ),
      // Transparent buttons on light screens: dark gold text (never white-on-white).
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: goldDeep,
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: goldDeep,
          side: const BorderSide(color: goldDeep),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: goldDeep,
        foregroundColor: Colors.white,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return Colors.white;
            return goldDeep;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return goldDeep;
            return Colors.white;
          }),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: goldDeep.withValues(alpha: 0.1),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: goldDeep,
        contentTextStyle: GoogleFonts.dmSans(color: Colors.white),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: goldBright,
      ),
      chipTheme: ChipThemeData(
        selectedColor: goldDeep,
        checkmarkColor: Colors.white,
        labelStyle: GoogleFonts.dmSans(color: ink),
        secondaryLabelStyle: GoogleFonts.dmSans(color: Colors.white),
      ),
    );
  }
}

/// Warm gold wash behind primary shells.
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
            Color(0xFFFFFCF5),
            Color(0xFFFFF3D1),
            Color(0xFFF5E2A8),
          ],
        ),
      ),
      child: child,
    );
  }
}
