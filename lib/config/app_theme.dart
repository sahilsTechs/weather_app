// lib/config/app_theme.dart
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primary,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
