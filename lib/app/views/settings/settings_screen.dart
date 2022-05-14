import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../../system/helpers/helpers.dart';
import '../../services/words_service.dart';

class SettingsScreen extends StatelessWidget {
  final WordsService _wordsService = Get.find<WordsService>();
  final AuthController _authController = Get.find<AuthController>();

  SettingsScreen({Key? key}) : super(key: key) {
    selectedCategorie.value = _wordsService.categorie.value;
    selectedthemy.value = _authController.themy.value;
  }

  var selectedCategorie = 'tabwa'.obs;
  List<DropdownMenuItem<String>> dm = [
    const DropdownMenuItem(
      child: Text('Tabwa'),
      value: 'tabwa',
    ),
    const DropdownMenuItem(
      child: Text('Français'),
      value: 'français',
    ),
  ];

  var selectedthemy = 'system'.obs;
  List<DropdownMenuItem<String>> themy = [
    const DropdownMenuItem(
      child: Text('Light'),
      value: 'light',
    ),
    const DropdownMenuItem(
      child: Text('Dark'),
      value: 'dark',
    ),
    const DropdownMenuItem(
      child: Text('System'),
      value: 'system',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'settings'.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: getTextSize(14.0)),
            ),
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
                        _wordsService.setCategorie(value.toString());
                      }),
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
                          roundedTextInputDecoration(labelText: 'theme'.tr),
                      items: themy,
                      value: selectedthemy.value,
                      onChanged: (value) {
                        selectedthemy.value = value.toString();
                        _authController.storeTheme(value.toString());
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
