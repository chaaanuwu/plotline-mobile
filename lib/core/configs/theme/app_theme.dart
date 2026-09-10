import 'package:flutter/material.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';

class AppTheme {
  // light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
  );

  // dark theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
  );
}
