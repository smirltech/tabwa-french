import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';
import 'package:tabwa_french/system/themes/theme_dark.dart';
import 'package:tabwa_french/system/themes/theme_light.dart';

class ThemeSetting {
  /// Theme colors
  static const Color gray = Color(0xFFE0E0E0);
  static const Color green = Colors.pink;

  /// Theme sizes
  static final double veryTiny = getTextSize(8.0);
  static final double tiny = getTextSize(10.0);

  // static final double verySmall = getTextSize(12.0);
  static final double small = getTextSize(11.0);
  static final double normal = getTextSize(12.0);
  static final double big = getTextSize(14.0);

//  static final double veryBig = getTextSize(20.0);
  static final double large = getTextSize(16.0);

//  static final double veryLarge = getTextSize(24.0);
  static final double huge = getTextSize(18.0);

  static final double veryHuge = getTextSize(20.0);

  static final double massive = getTextSize(24.0);

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
