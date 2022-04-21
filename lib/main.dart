import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/words_controller.dart';
import 'package:tabwa_french/app/views/home/home_screen.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/lang/translate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    Get.put(WordsController());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: DEBUG_MODE,
      enableLog: DEBUG_MODE,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      translations: Translate(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
