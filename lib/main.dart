import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/app/views/home/home_screen.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/lang/translate.dart';

import 'app/controllers/controllers.dart';
import 'app/routes/routes.dart';
import 'app/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Services.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    Controllers.init();
  }

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.home,
      getPages: Routes.routes,
    );
  }
}
