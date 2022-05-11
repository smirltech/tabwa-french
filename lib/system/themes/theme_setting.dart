import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';
import 'package:tabwa_french/system/themes/theme_dark.dart';
import 'package:tabwa_french/system/themes/theme_light.dart';

class ThemeSetting {
  /// Theme colors
  static const Color gray = Color(0xFFE0E0E0);
  static const Color green = Colors.pink;

  /// Theme sizes
  static final double veryTiny = getShortSide(8.0);
  static final double tiny = getShortSide(10.0);
  static final double verySmall = getShortSide(12.0);
  static final double small = getShortSide(14.0);
  static final double normal = getShortSide(16.0);
  static final double big = getShortSide(18.0);
  static final double veryBig = getShortSide(20.0);
  static final double large = getShortSide(22.0);
  static final double veryLarge = getShortSide(24.0);
  static final double huge = getShortSide(26.0);
  static final double veryHuge = getShortSide(28.0);
  static final double massive = getShortSide(30.0);

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
