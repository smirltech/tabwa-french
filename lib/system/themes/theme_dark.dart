import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeDark {
  static ThemeData get theme => ThemeData.dark().copyWith(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        )
    ),
  );
}
