import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tabwa_french/app/views/home/home_screen.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/lang/translate.dart';
import 'package:tabwa_french/system/themes/theme_setting.dart';

import 'app/controllers/controllers.dart';
import 'app/routes/routes.dart';
import 'app/services/services.dart';

late PackageInfo PACKAGE_INFO;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PACKAGE_INFO = await PackageInfo.fromPlatform();

  await GetStorage.init();
  await Services.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    Controllers.init();
    var _themy = GetStorage().read('themy') ?? themy;
    themy = _themy == 'dark'
        ? ThemeMode.dark
        : _themy == 'light'
            ? ThemeMode.light
            : ThemeMode.system;
  }

  var themy = ThemeMode.system;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: DEBUG_MODE,
      enableLog: DEBUG_MODE,
      locale: const Locale('fr', 'FR'),
      fallbackLocale: const Locale('en', 'US'),
      translations: Translate(),
      theme: ThemeSetting.getTheme(false),
      darkTheme: ThemeSetting.getTheme(true),
      themeMode: themy,
      initialRoute: Routes.home,
      getPages: Routes.routes,
    );
  }
}
