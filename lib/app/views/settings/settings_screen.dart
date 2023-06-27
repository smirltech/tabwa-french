import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';
import 'package:tabwa_french/system/themes/theme_setting.dart';

import '../../../system/helpers/helpers.dart';
import '../../services/words_service.dart';

class SettingsScreen extends StatelessWidget {
 // final WordsService _wordsService = Get.find<WordsService>();
 // final AuthController _authController = Get.find<AuthController>();

  SettingsScreen({Key? key}) : super(key: key) {
    selectedCategorie.value = WordsService.of.categorie.value;
    selectedthemy.value = AuthController.of.themy.value;
  }

  var selectedCategorie = 'tabwa'.obs;
  List<DropdownMenuItem<String>> dm = [
    const DropdownMenuItem(
      value: 'tabwa',
      child: Text('Tabwa'),
    ),
    const DropdownMenuItem(
      child: Text('Français'),
      value: 'français',
    ),
  ];

  var selectedthemy = 'system'.obs;
  List<DropdownMenuItem<String>> themy = [
    const DropdownMenuItem(
      value: 'light',
      child: Text('Light'),
    ),
    const DropdownMenuItem(
      value: 'dark',
      child: Text('Dark'),
    ),
    const DropdownMenuItem(
      value: 'system',
      child: Text('System'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).hintColor),
        title: Text('settings'.tr,
            style: TextStyle(color: Theme.of(context).hintColor)),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                      decoration: roundedTextInputDecoration(
                          labelText: 'primary dictionnary'.tr),
                      items: dm,
                      value: selectedCategorie.value,
                      onChanged: (value) {
                        selectedCategorie.value = value.toString();
                        WordsService.of.setCategorie(value.toString());
                      },

                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                      decoration:
                          roundedTextInputDecoration(labelText: 'theme'.tr,),
                      items: themy,
                      value: selectedthemy.value,
                      onChanged: (value) {
                        selectedthemy.value = value.toString();
                        AuthController.of.storeTheme(value.toString());
                      }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
