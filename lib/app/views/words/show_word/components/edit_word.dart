import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/translations_controller.dart';
import 'package:tabwa_french/app/models/type.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../../../../system/configs/configs.dart';
import '../../../../../system/helpers/log_cat.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/types_controller.dart';
import '../../../../models/word.dart';
import '../../../../services/words_service.dart';

class EditWord extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final Word wordy;

  EditWord({Key? key, required this.wordy}) : super(key: key) {
    word = {
      'word': wordy.word,
      'categorie': wordy.categorie,
    };

    selectedCategorie.value = wordy.categorie;
  }

  Map<String, dynamic> word = {
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
    return Container(
      color: Colors.white,
      height: getShortSide(260),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
                child: Text("edit word".tr,
                    style: TextStyle(fontSize: getShortSide(20)))),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: word['word'],
                    onChanged: (value) {
                      word['word'] = value;
                    },
                    decoration:
                        roundedTextInputDecoration(labelText: 'word'.tr),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField(
                          decoration: roundedTextInputDecoration(
                              labelText: 'category'.tr),
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
                    child: Text('edit'.tr),
                    onPressed: () {
                      word['user_id'] = _authController.user.value!.id;
                      _wordsService.editWord(word);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
