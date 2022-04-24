import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/translations_controller.dart';
import 'package:tabwa_french/app/models/translation.dart';
import 'package:tabwa_french/app/models/type.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../../../../system/configs/configs.dart';
import '../../../../../system/helpers/log_cat.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/types_controller.dart';
import '../../../../services/words_service.dart';

class EditTranslation extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final TypesController _typesController = Get.find<TypesController>();
  final TranslationsController _translationsController =
      Get.find<TranslationsController>();
  final Translation translaty;

  EditTranslation({Key? key, required this.translaty}) : super(key: key) {
    translation = {
      'id': translaty.id,
      "type_id": translaty.type_id,
      "translation": translaty.translation,
      "example": translaty.example,
      "example_translation": translaty.example_translation,
    };

    tty = _typesController.types.value.map((e) {
      return DropdownMenuItem<Type>(
        value: e,
        child: Text(e.type),
      );
    }).toList();

    selectedType.value = _typesController.types.value.firstWhere((Type e) {
      return e.id == int.parse(translaty.type_id);
    });
  }

  var selectedType = Rxn<Type>();
  late List<DropdownMenuItem<Type>> tty;
  Map<String, dynamic> translation = {
    "type_id": 1,
    "translation": "",
    "example": "",
    "example_translation": "",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Text('edit translation'.tr,
                style: TextStyle(fontSize: getShortSide(20))),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      initialValue: translation['translation'],
                      onChanged: (value) {
                        translation['translation'] = value;
                      },
                      decoration: roundedTextInputDecoration(
                          labelText: 'transaltion'.tr),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(() {
                      return SizedBox(
                        width: double.infinity,
                        child: DropdownButtonFormField(
                            decoration: roundedTextInputDecoration(
                                labelText: 'type'.tr),
                            items: tty,
                            value: selectedType.value,
                            onChanged: (Type? value) {
                              logcat(value.toString());
                              translation['type_id'] = value!.id;
                              selectedType.value = value;
                            }),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      initialValue: translation['example'],
                      onChanged: (value) {
                        translation['example'] = value;
                      },
                      decoration:
                          roundedTextInputDecoration(labelText: 'example'.tr),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      initialValue: translation['example_translation'],
                      onChanged: (value) {
                        translation['example_translation'] = value;
                      },
                      decoration: roundedTextInputDecoration(
                          labelText: 'example translation'.tr),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: Text('edit'.tr),
                      onPressed: () {
                        _translationsController.editTranslation(translation);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
