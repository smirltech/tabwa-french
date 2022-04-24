import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/views/words/show_word/components/add_translation.dart';
import 'package:tabwa_french/app/views/words/show_word/components/edit_translation.dart';
import 'package:tabwa_french/app/views/words/show_word/components/edit_word.dart';

import '../../../../system/helpers/sizes.dart';
import '../../../models/translation.dart';
import '../../../services/words_service.dart';

class ShowWordScreen extends StatelessWidget {
  ShowWordScreen({Key? key}) : super(key: key);
  final WordsService _wordsService = Get.find<WordsService>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('word'.tr),
      ),
      floatingActionButton: FloatingActionButton(
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
                color: Colors.grey[200],
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(_wordsService.word.value!.word,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'added by'.tr + ': ',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _wordsService.word.value!.user,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'last modified by'.tr + ': ',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _wordsService.word.value!.updater,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ],
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
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      Translation tranz =
                          _wordsService.word.value!.translations[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'added by'.tr + ': ',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: tranz.user,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                    ])),
                                  ),
                                  Flexible(
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'last modified by'.tr + ': ',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: tranz.updater,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                    ])),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(tranz.translation,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        EditTranslation(translaty: tranz),
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
                                    child: Text(tranz.example,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                  Expanded(
                                    child: Text(tranz.example_translation,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.blue)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
}
