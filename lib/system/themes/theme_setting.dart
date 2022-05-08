import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tabwa_french/system/themes/theme_dark.dart';
import 'package:tabwa_french/system/themes/theme_light.dart';

class ThemeSetting {
  /// Theme colors
  static const Color gray = Color(0xFFE0E0E0);
  static const Color green = Colors.pink;

  /// Theme sizes
  static const double veryTiny = 8.0;
  static const double tiny = 10.0;
  static const double verySmall = 12.0;
  static const double small = 14.0;
  static const double normal = 16.0;
  static const double big = 18.0;
  static const double veryBig = 20.0;
  static const double large = 22.0;
  static const double veryLarge = 24.0;
  static const double huge = 26.0;
  static const double veryHuge = 28.0;
  static const double massive = 30.0;

  /// The default theme.
  static ThemeData darkTheme = ThemeDark.theme;
  static ThemeData lightTheme = ThemeLight.theme;

  static ThemeData getTheme(bool isDark) {
    if (isDark) {
      return ThemeDark.theme;
    } else {
      return ThemeLight.theme;
    }
  }
}
