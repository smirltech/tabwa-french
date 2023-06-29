import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabwa_french/system/themes/theme_setting.dart';

class ThemeLight {

  static ThemeData get theme => ThemeData.light().copyWith(
    useMaterial3: true,
      //  appBarTheme: const AppBarTheme().copyWith(color: _baseColor),
    appBarTheme: const AppBarTheme(
      color: ThemeSetting.light,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        )
    ),

        primaryColor: ThemeSetting.light,
        // accentColor: _baseColor,
        // scaffoldBackgroundColor: _baseColor[50],
        // cardColor: _baseColor[50],
        // textSelectionColor: _baseColor,
        // errorColor: _baseColor,
      );
}
