import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/controllers/types_controller.dart';
import 'package:tabwa_french/app/models/type.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

import '../../../../system/helpers/sizes.dart';

class AddWordScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final TypesController _typesController = Get.find<TypesController>();

  AddWordScreen({Key? key}) : super(key: key) {
    tty = _typesController.types.value.map((e) {
      return DropdownMenuItem<Type>(
        value: e,
        child: Text(e.type),
      );
    }).toList();
    if (tty.isNotEmpty) selectedType.value = tty[0].value;

    word["word"] = _wordsService.searchedWord.value;
  }

  var word = <String, dynamic>{
    'user_id': 1,
    'word': '',
    'categorie': 'tabwa',
  }.obs;
  var selectedCategorie = 'tabwa'.obs;
  var selectedType = Rxn<Type>();

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

  late List<DropdownMenuItem<Type>> tty;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('new word'.tr),
        actions: [
          Obx(() {
            return TextButton(
              child: Text(
                'add'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: word.value['word'].toString().isEmpty
                  ? null
                  : () {
                      word.value['user_id'] = _authController.user.value!.id;
                      _wordsService.addWord(word.value);
                    },
            );
          }).paddingOnly(right: getShortSide(10)),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: word.value['word'],
                    onChanged: (value) {
                      word.value['word'] = value;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'word is required'.tr;
                      }
                      if (_wordsService.key_words.value
                          .contains(value.toLowerCase())) {
                        return 'word already exists'.tr;
                      }
                      return null;
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
                            word.value['categorie'] = value;
                            selectedCategorie.value = value.toString();
                          }),
                    );
                  }),
                ),
                const Divider(),
                Text("optional".tr,
                    style: TextStyle(fontSize: getTextSize(16))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: word.value['translation'],
                    onChanged: (value) {
                      word.value['translation'] = value;
                    },
                    decoration:
                        roundedTextInputDecoration(labelText: 'translation'.tr),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField(
                          decoration:
                              roundedTextInputDecoration(labelText: 'type'.tr),
                          items: tty,
                          value: selectedType.value,
                          onChanged: (Type? value) {
                            //  logcat(value.toString());
                            word.value['type_id'] = value!.id;
                            selectedType.value = value;
                          }),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: word.value['example'],
                    onChanged: (value) {
                      word.value['example'] = value;
                    },
                    decoration:
                        roundedTextInputDecoration(labelText: 'example'.tr),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: word.value['example_translation'],
                    onChanged: (value) {
                      word.value['example_translation'] = value;
                    },
                    decoration: roundedTextInputDecoration(
                        labelText: 'example translation'.tr),
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
