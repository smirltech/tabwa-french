import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/system/configs/configs.dart';

class AddWordScreen extends StatelessWidget {
  AddWordScreen({Key? key}) : super(key: key);
  final AuthController _authController = Get.find<AuthController>();
  final WordsService _wordsService = Get.find<WordsService>();
  Map<String, dynamic> word = {
    'user_id': 1,
    'word': '',
    'categorie': 'tabwa',
  };
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
        title: Text('add word'.tr),
      ),
      body: Center(
        child: Column(
          children: [
            Text(APP_NAME),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: word['word'],
                onChanged: (value) {
                  word['word'] = value;
                },
                decoration: InputDecoration(
                  labelText: 'word'.tr,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'category'.tr,
                      ),
                      items: dm,
                      value: selectedCategorie.value,
                      onChanged: (value) {
                        word['categorie'] = value;
                        selectedCategorie.value = value.toString();
                      }),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                child: Text('add'.tr),
                onPressed: () {
                  word['user_id'] = _authController.user.value!.id;
                  _wordsService.addWord(word);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
