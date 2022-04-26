import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/views/words/show_word/components/add_translation.dart';
import 'package:tabwa_french/app/views/words/show_word/components/edit_translation.dart';
import 'package:tabwa_french/app/views/words/show_word/components/edit_word.dart';
import 'package:tabwa_french/system/themes/theme_setting.dart';

import '../../../../system/helpers/sizes.dart';
import '../../../models/translation.dart';
import '../../../services/words_service.dart';

class ShowWordScreen extends StatelessWidget {
  ShowWordScreen({Key? key}) : super(key: key);
  final WordsService _wordsService = Get.find<WordsService>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('word or expression'.tr),
      ),
      floatingActionButton: (_authController.user.value == null)
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Get.bottomSheet(AddTranslation());
              },
            ),
      body: Obx(() {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                //  color: Colors.grey[200],
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    _wordsService.word.value!.word,
                                    style: const TextStyle(
                                      // color: Colors.black,
                                      fontSize: ThemeSetting.normal,
                                    ),
                                  ),
                                ),
                                if (_authController.user.value != null)
                                  IconButton(
                                    onPressed: () {
                                      Get.bottomSheet(EditWord(
                                          wordy: _wordsService.word.value!));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                              ]),
                          onTap: () {
                            showCredit(
                                context,
                                'word or expression'.tr,
                                _wordsService.word.value!.user,
                                _wordsService.word.value!.updater);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      Translation tranz =
                          _wordsService.word.value!.translations[index];
                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: ThemeSetting.gray,
                            radius: ThemeSetting.small,
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                fontSize: ThemeSetting.small,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    showCredit(context, "translation".tr,
                                        tranz.user, tranz.updater);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              tranz.translation,
                                              style: const TextStyle(
                                                //  color: Colors.black,
                                                fontSize: ThemeSetting.normal,
                                              ),
                                            ),
                                          ),
                                          if (_authController.user.value !=
                                              null)
                                            IconButton(
                                              onPressed: () {
                                                Get.bottomSheet(
                                                  EditTranslation(
                                                      translaty: tranz),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              tranz.example,
                                              style: const TextStyle(
                                                //  color: Colors.black,
                                                fontSize: ThemeSetting.small,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              tranz.example_translation,
                                              style: const TextStyle(
                                                color: ThemeSetting.green,
                                                fontSize: ThemeSetting.small,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: _wordsService.word.value!.translations.length),
              ),
            ),
          ],
        );
      }),
    );
  }

  void showCredit(
      BuildContext context, String title, String adder, String editor) {
    Get.snackbar(
      title,
      '',
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: ThemeSetting.verySmall,
                ),
                children: [
                  TextSpan(
                      text: 'added by'.tr + ': ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: adder,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: ThemeSetting.verySmall,
                ),
                children: [
                  TextSpan(
                      text: 'last modified by'.tr + ': ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: editor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
