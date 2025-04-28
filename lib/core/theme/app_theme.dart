import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralised theme configuration for the Booking App.
///
/// Extend this class with dark theme or custom color schemes if needed.
class AppTheme {
  AppTheme._();

  /// Base light theme following Material 3 guidelines.
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.green,
        secondary: AppColors.green,
      ),
      dividerColor: AppColors.border,
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.black,
        displayColor: AppColors.black,
      ),
      inputDecorationTheme:
          const InputDecorationTheme(border: OutlineInputBorder()),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.black,
        ),
      ),
    );
  }

  // Brand colour extracted from the design mockup.
  static const Color _brandGreen = Color(0xFF27AE60);
}
