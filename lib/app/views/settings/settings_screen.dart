import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../system/helpers/helpers.dart';
import '../../services/words_service.dart';

class SettingsScreen extends StatelessWidget {
  final WordsService _wordsService = Get.find<WordsService>();

  SettingsScreen({Key? key}) : super(key: key) {
    selectedCategorie.value = _wordsService.categorie.value;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Settings'),
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
          ],
        ),
      ),
    );
  }
}
