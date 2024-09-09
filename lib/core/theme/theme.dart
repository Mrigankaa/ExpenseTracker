import 'package:expencetracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryVariant,
    primaryColorDark: AppColors.primaryVariant,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: AppColors.onBackground, fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: AppColors.onBackground, fontSize: 28, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: AppColors.onBackground, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.onBackground, fontSize: 14),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.primaryColor,
      
    ),
    // Define additional theme properties here
  );
}