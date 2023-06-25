import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeLight {
  // static const MaterialColor _baseColor = Colors.blue;
  static const Color _baseColor = Colors.white;

  static ThemeData get theme => ThemeData.light().copyWith(
    useMaterial3: true,
      //  appBarTheme: const AppBarTheme().copyWith(color: _baseColor),
    appBarTheme: const AppBarTheme(
      color: _baseColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        )
    ),

        primaryColor: _baseColor,
        // accentColor: _baseColor,
        // scaffoldBackgroundColor: _baseColor[50],
        // cardColor: _baseColor[50],
        // textSelectionColor: _baseColor,
        // errorColor: _baseColor,
      );
}
