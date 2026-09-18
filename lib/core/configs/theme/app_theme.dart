import 'package:flutter/material.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';

class AppTheme {
  // Light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    splashColor: AppColors.lightBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      surface: AppColors.lightSurface,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightMainText),
      bodyMedium: TextStyle(color: AppColors.lightSecondaryText),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: AppColors.lightButtonBackground,
        foregroundColor: AppColors.lightButtonText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );

  // Dark theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    splashColor: AppColors.darkBackground,

    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      surface: AppColors.darkSurface,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkMainText),
      bodyMedium: TextStyle(color: AppColors.darkSecondaryText),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: AppColors.darkButtonBackground,
        foregroundColor: AppColors.darkButtonText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );
}
