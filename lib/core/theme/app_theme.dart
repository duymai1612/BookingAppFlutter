import 'package:flutter/material.dart';

/// Centralised theme configuration for the Booking App.
///
/// Extend this class with dark theme or custom color schemes if needed.
class AppTheme {
  AppTheme._();

  /// Base light theme following Material 3 guidelines.
  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _brandGreen),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme:
          const InputDecorationTheme(border: OutlineInputBorder()),
    );
  }

  // Brand colour extracted from the design mockup.
  static const Color _brandGreen = Color(0xFF27AE60);
}
