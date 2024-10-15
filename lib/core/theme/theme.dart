import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

ThemeData getAppDarkTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      displayMedium: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: 16,
      ),
      displaySmall: GoogleFonts.lato(
        color: AppColors.white.withOpacity(0.44),
        fontSize: 16,
      ),
      // Setting the bodyLarge style to ensure all text fields have white text in dark mode
      bodyLarge: const TextStyle(
        color: AppColors.white, // Default white text for text input
        fontSize: 16,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 16,
        ),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.white.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      hintStyle: GoogleFonts.lato(
        color: AppColors.white.withOpacity(0.5),
        fontSize: 16,
      ),
      labelStyle: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: 16,
      ),
      fillColor: AppColors.lightBlack,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      prefixIconColor: AppColors.white.withOpacity(0.8),
      suffixIconColor: AppColors.white.withOpacity(0.8),
    ),
  );
}

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    //scaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.white,
    //appBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        color: AppColors.background,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      displayMedium: GoogleFonts.lato(
        color: AppColors.background,
        fontSize: 16,
      ),
      displaySmall: GoogleFonts.lato(
        color: AppColors.background.withOpacity(0.44),
        fontSize: 16,
      ),
    ),
    //button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)))),
  );
}
