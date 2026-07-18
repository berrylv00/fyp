import 'package:flutter/material.dart';

/// Single purple accent used across BOTH light and dark mode.
/// (Previously light mode used pink — this unifies it with dark mode.)
class AppColors {
  static const purple = Color(0xFF7C5CFC);
  static const purpleDark = Color(0xFF5B3FE0);
  static const navy = Color(0xFF0B1026);

  static const navy2 = Color(0xFF1A1448);

  static const darkBg = Color(0xFF100C2C);
  static const glass =
    Color.fromARGB(70, 28, 24, 74);
  static const darkCard = Color(0xFF1B1642);
  static const darkCard2 = Color(0xFF221C52);
  static const darkBorder = Color(0xFF332C6E);
  static const darkText = Color(0xFFF1EEFF);
  static const darkTextDim = Color(0xFFA79FD6);

  static const lightBg = Color(0xFFFAF8FF);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightBorder = Color(0xFFE7E1FA);
  static const lightText = Color(0xFF1E1A3D);
  static const lightTextDim = Color(0xFF7A72A8);

  static const green = Color(0xFF2FBE7A);
  static const red = Color(0xFFE24B4A);
  static const amber = Color(0xFFE0A430);
}

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.purple,
      secondary: AppColors.purple,
      surface: AppColors.lightCard,
    ),
    cardColor: AppColors.lightCard,
    dividerColor: AppColors.lightBorder,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.lightText),
      bodySmall: TextStyle(color: AppColors.lightTextDim),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightCard,
      selectedItemColor: AppColors.purple,
      unselectedItemColor: AppColors.lightTextDim,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBg,
      foregroundColor: AppColors.lightText,
      elevation: 0,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.purple,
      secondary: AppColors.purple,
      surface: AppColors.darkCard,
    ),
    cardColor: AppColors.darkCard,
    dividerColor: AppColors.darkBorder,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.darkText),
      bodySmall: TextStyle(color: AppColors.darkTextDim),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkCard2,
      selectedItemColor: AppColors.purple,
      unselectedItemColor: AppColors.darkTextDim,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBg,
      foregroundColor: AppColors.darkText,
      elevation: 0,
    ),
  );

  static Color? primaryColor;
}
