import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary: Apricot Crush (Pantone 2025)
  static const Color apricotCrush = Color(0xFFFB9062);
  
  // Backgrounds
  static const Color stoneBlue = Color(0xFFE6EBF0); // Light mode bg assumption
  static const Color offWhite = Color(0xFFF8F9FA);
  static const Color deepCharcoal = Color(0xFF121212); // Dark mode bg
  
  // Accents
  static const Color limeGreen = Color(0xFFC7F464); // "Healthy" indicator
  static const Color glassWhite = Colors.white;
  static const Color glassBlack = Colors.black;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.apricotCrush,
      scaffoldBackgroundColor: AppColors.offWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.apricotCrush,
        brightness: Brightness.light,
        surface: AppColors.stoneBlue,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.apricotCrush,
      scaffoldBackgroundColor: AppColors.deepCharcoal,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.apricotCrush,
        brightness: Brightness.dark,
        surface: const Color(0xFF1E1E1E),
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final baseTextTheme = brightness == Brightness.light
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return baseTextTheme.copyWith(
      // Headings - Playfair Display (Serif)
      displayLarge: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.displayLarge, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.displayMedium, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.displaySmall, fontWeight: FontWeight.bold),
      headlineLarge: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.headlineLarge, fontWeight: FontWeight.bold),
      headlineMedium: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.headlineMedium, fontWeight: FontWeight.bold),
      headlineSmall: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.headlineSmall, fontWeight: FontWeight.bold),
      
      // Body - Inter (Sans-Serif)
      titleLarge: GoogleFonts.inter(textStyle: baseTextTheme.titleLarge, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.inter(textStyle: baseTextTheme.titleMedium, fontWeight: FontWeight.w500),
      titleSmall: GoogleFonts.inter(textStyle: baseTextTheme.titleSmall),
      bodyLarge: GoogleFonts.inter(textStyle: baseTextTheme.bodyLarge),
      bodyMedium: GoogleFonts.inter(textStyle: baseTextTheme.bodyMedium),
      bodySmall: GoogleFonts.inter(textStyle: baseTextTheme.bodySmall),
      labelLarge: GoogleFonts.inter(textStyle: baseTextTheme.labelLarge, fontWeight: FontWeight.bold),
    );
  }
}
