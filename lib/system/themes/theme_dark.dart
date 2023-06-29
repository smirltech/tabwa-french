import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabwa_french/system/themes/theme_setting.dart';

class ThemeDark {
  static ThemeData get theme => ThemeData.dark().copyWith(
    useMaterial3: true,
    primaryColor: ThemeSetting.dark,
    appBarTheme: const AppBarTheme(
      color: ThemeSetting.dark,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        )
    ),
  );
}
