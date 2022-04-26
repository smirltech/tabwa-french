import 'package:flutter/material.dart';

class ThemeLight {
  static const MaterialColor _baseColor = Colors.teal;

  static ThemeData get theme => ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme().copyWith(color: _baseColor),

        primaryColor: _baseColor,

        // accentColor: _baseColor,
        scaffoldBackgroundColor: _baseColor[50],
        cardColor: _baseColor[50],
        // textSelectionColor: _baseColor,
        // errorColor: _baseColor,
      );
}
