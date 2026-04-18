import 'package:flutter/material.dart';
import 'color.dart';

class AppTheme {

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSurface: AppColors.textPrimary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary, // light mode color
      foregroundColor: Colors.white,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark, // 👈 DARK MODE variant
      secondary: AppColors.primaryLight,
      surface: AppColors.backgroundDark,
      onPrimary: Colors.white,
      onSurface: AppColors.textPrimaryDark,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark, // 👈 switch here
      foregroundColor: Colors.white,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimaryDark),
      bodyMedium: TextStyle(color: AppColors.textSecondaryDark),
    ),
  );
}