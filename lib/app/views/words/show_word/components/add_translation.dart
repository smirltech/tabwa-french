import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/translations_controller.dart';
import 'package:tabwa_french/app/models/type.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../../../../system/configs/configs.dart';
import '../../../../../system/helpers/log_cat.dart';
import '../../../../../system/themes/theme_setting.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/types_controller.dart';
import '../../../../services/words_service.dart';

class AddTranslation extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final TypesController _typesController = Get.find<TypesController>();
  final TranslationsController _translationsController =
  Get.find<TranslationsController>();

  AddTranslation({Key? key}) : super(key: key) {
    tty = _typesController.types.value.map((e) {
      return DropdownMenuItem<Type>(
        value: e,
        child: Text(e.type),
      );
    }).toList();
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
      color: Theme
          .of(context)
          .primaryColor,
      child: Center(
        child: Column(
          children: [
            Text("add translation".tr,
                style: TextStyle(fontSize: ThemeSetting.large))
                .paddingSymmetric(vertical: getShortSide(10)),
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
                          labelText: 'translation'.tr),
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

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                child: Text('add'.tr),
                onPressed: () {
                  translation['word_id'] = _wordsService.word.value!.id;
                  translation['user_id'] = _authController.user.value!.id;
                  _translationsController.addTranslation(translation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
