import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../system/helpers/audio_recorder/components/sound_player.dart';
import '../../../../system/helpers/helpers.dart';
import '../../../../system/helpers/sizes.dart';
import '../../../../system/themes/theme_setting.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/connectivity_controller.dart';
import '../../../models/translation.dart';
import '../../../models/word.dart';
import '../../../routes/routes.dart';
import '../../../services/words_service.dart';
import '../../words/show_word/components/add_translation.dart';
import '../../words/show_word/components/edit_translation.dart';
import '../../words/show_word/components/edit_word.dart';

class DesktopScreen extends StatelessWidget {
  DesktopScreen({Key? key}) : super(key: key) {
    soundPlayer = SoundPlayer();
    soundPlayer.init();
  }

  final ConnectivityController connectivityController =
      Get.find<ConnectivityController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final AuthController _authController = Get.find<AuthController>();
  late SoundPlayer soundPlayer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).hintColor),
          title: Obx(() {
            return CupertinoSearchTextField(
              controller: _wordsService.searchEditingController.value,
              onChanged: (value) {
                _wordsService.searchedWord.value = value;
              },
              style: TextStyle(
                  fontSize: ThemeSetting.large,
                  color: Theme.of(context).hintColor),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).hintColor,
                  width: 0.5,
                ),
              ),
              placeholder: "search".tr +
                  " " +
                  "in".tr +
                  ' ' +
                  _wordsService.categorie.value,
            );
          }),
          actions: [
            Obx(() {
              int cnt = 0;
              String cntStr = cnt.toString();
              try {
                cnt = _wordsService.filteredWords.value.length;
                cntStr = cnt > 999 ? '999+' : cnt.toString();
              } on Exception catch (_) {}
              return IconButton(
                onPressed: () {
                  final String v = _wordsService.categorie.value == 'tabwa'
                      ? 'français'
                      : 'tabwa';
                  _wordsService.setCategorie(v);
                },
                // color: Theme.of(context).hintColor,
                icon: badges.Badge(
                  badgeContent: Text(cntStr,
                          style: GoogleFonts.oswald(
                              color: Theme.of(context).hintColor,
                              fontSize: ThemeSetting.tiny))
                      .paddingSymmetric(
                    horizontal: 0,
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Theme.of(context).primaryColor,
                  ),
                  position: badges.BadgePosition.topEnd(top: -20, end: -30),
                  child: Text(
                      _wordsService.categorie.value
                          .substring(0, 1)
                          .toUpperCase(),
                      style: GoogleFonts.oswald(
                          fontWeight: FontWeight.bold,
                          fontSize: ThemeSetting.massive,
                          color: Theme.of(context).hintColor)),
                ),
              );
            }),
            const SizedBox(width: 20),
          ],
        ),
        body: Row(
          children: [
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      /*    if (_authController.user.value != null &&
                          (connectivityController.connectivityResult.value !=
                                  null &&
                              connectivityController
                                      .connectivityResult.value!.name !=
                                  'none')) {*/
                      return ElevatedButton.icon(
                              onPressed: () {
                                Get.toNamed(Routes.addWord);
                              },
                              icon: const Icon(Icons.add),
                              label: Text("new word".tr))
                          .paddingSymmetric(
                              horizontal: getShortSide(4.0),
                              vertical: getShortSide(2.0));
                    }),
                  ),
                  Expanded(
                    child: Obx(() {
                      if (_wordsService.isLoading.isTrue) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(getShortSide(30)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'loading...'.tr,
                                  style:
                                      TextStyle(fontSize: ThemeSetting.large),
                                ),
                                const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        );
                      } else if (_wordsService.filteredWords.isEmpty) {
                        if (_wordsService.searchedWord.isNotEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "no word or expression found from searched term"
                                        .tr,
                                    style: TextStyle(
                                        fontSize: ThemeSetting.normal)),
                                if (_authController.isAuthenticated())
                                  OutlinedButton(
                                      onPressed: () {
                                        _wordsService.suggestAddingWord();
                                      },
                                      child: Text("add".tr,
                                          style: TextStyle(
                                              fontSize: ThemeSetting.normal)))
                              ],
                            ),
                          );
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('no words or expressions yet'.tr,
                                  style:
                                      TextStyle(fontSize: ThemeSetting.normal)),
                              /*Text('the dictionnary has'.tr +
                              ' ${_wordsService.words.length} ' +
                              '${_wordsService.words.length > 1 ? 'words' : 'word'}'.tr),*/
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          Word word = _wordsService.filteredProverbs[index];
                          List<Translation> _translations = word.translations;
                          List<String> _traas = [];
                          if (_translations.isNotEmpty) {
                            _traas = _translations
                                .map((t) => "[${t.type_ab}] ${t.translation}")
                                .toList();
                          }
                          return Card(
                            // elevation: 0,
                            child: InkWell(
                              onTap: () {
                                _wordsService.setActiveWord(word);
                                //  Get.toNamed(Routes.showWord);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    word.word,
                                    style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ThemeSetting.large,
                                    ),
                                  ),
                                ],
                              ).paddingAll(getShortSide(5.0)),
                            ),
                          );
                        },
                        itemCount: _wordsService.filteredProverbs.length,
                      ).paddingSymmetric(horizontal: getShortSide(2.0));
                    }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Obx(() {
                    if (_wordsService.word.value == null) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          "select a word in the list on the left to see details"
                              .tr,
                          style: GoogleFonts.oswald(
                              fontSize: ThemeSetting.huge,
                              color: Theme.of(context).hintColor),
                        ),
                      );
                    }
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Card(
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                // todo: play audio
                                                String audioUrl =
                                                    "https://tabwa.smirltech.com/audio/words/${_wordsService.word.value!.id}.aac";
                                                // logcat('audioUrl: $audioUrl');
                                                soundPlayer.playFromNet(
                                                    audioUrl, whenFinished: () {
                                                  toastItInfo(msg: 'done'.tr);
                                                }, error: () {
                                                  toastItError(
                                                    msg: "no audio found".tr,
                                                  );
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.volume_up_outlined,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                _wordsService.word.value!.word,
                                                style: GoogleFonts.oswald(
                                                  fontSize: ThemeSetting.big,
                                                ),
                                              ),
                                            ),
                                            /* if (_authController.user.value !=
                                                    null &&
                                                (connectivityController
                                                            .connectivityResult
                                                            .value !=
                                                        null &&
                                                    connectivityController
                                                            .connectivityResult
                                                            .value!
                                                            .name !=
                                                        'none'))*/
                                            IconButton(
                                              onPressed: () {
                                                Get.bottomSheet(EditWord(
                                                    wordy: _wordsService
                                                        .word.value!));
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
                            padding: const EdgeInsets.all(2.0),
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  Translation tranz = _wordsService
                                      .word.value!.translations[index];
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: ThemeSetting.gray,
                                        radius: ThemeSetting.small,
                                        child: Text(
                                          (index + 1).toString(),
                                          style: TextStyle(
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
                                                showCredit(
                                                    context,
                                                    "translation".tr,
                                                    tranz.user,
                                                    tranz.updater);
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(TextSpan(
                                                      text: "Type",
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              ": ${tranz.type}",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary),
                                                        ),
                                                      ])),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          // todo: play audio
                                                          String audioUrl =
                                                              "https://tabwa.smirltech.com/audio/translations/${tranz.id}.aac";
                                                          //  logcat('audioUrl: $audioUrl');
                                                          soundPlayer
                                                              .playFromNet(
                                                                  audioUrl,
                                                                  whenFinished:
                                                                      () {
                                                            toastItInfo(
                                                                msg: 'done'.tr);
                                                          }, error: () {
                                                            toastItError(
                                                              msg:
                                                                  "no audio found"
                                                                      .tr,
                                                            );
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .volume_up_outlined,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          tranz.translation,
                                                          style: GoogleFonts
                                                              .oswald(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                ThemeSetting
                                                                    .big,
                                                          ),
                                                        ),
                                                      ),
                                                      /*  if (_authController
                                                                  .user.value !=
                                                              null &&
                                                          (connectivityController
                                                                      .connectivityResult
                                                                      .value !=
                                                                  null &&
                                                              connectivityController
                                                                      .connectivityResult
                                                                      .value!
                                                                      .name !=
                                                                  'none'))*/
                                                      IconButton(
                                                        onPressed: () {
                                                          Get.bottomSheet(
                                                            EditTranslation(
                                                                translaty:
                                                                    tranz),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 0.5,
                                                    color: Colors.grey,
                                                  ),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if (tranz.example
                                                                  .isNotEmpty)
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    // todo: play audio
                                                                    String
                                                                        audioUrl =
                                                                        "https://tabwa.smirltech.com/audio/examples/${tranz.id}.aac";
                                                                    //  logcat('audioUrl: $audioUrl');
                                                                    soundPlayer.playFromNet(
                                                                        audioUrl,
                                                                        whenFinished:
                                                                            () {
                                                                      toastItInfo(
                                                                          msg: 'done'
                                                                              .tr);
                                                                    }, error:
                                                                            () {
                                                                      toastItError(
                                                                        msg: "no audio found"
                                                                            .tr,
                                                                      );
                                                                    });
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .volume_up_outlined,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              Expanded(
                                                                child: Text(
                                                                  tranz.example,
                                                                  style:
                                                                      GoogleFonts
                                                                          .oswald(
                                                                    fontSize:
                                                                        ThemeSetting
                                                                            .normal,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const VerticalDivider(
                                                          thickness: 0.5,
                                                          color: Colors.grey,
                                                          width: 0.0,
                                                        ).paddingOnly(
                                                            right: getShortSide(
                                                                10)),
                                                        Expanded(
                                                          child: Text(
                                                            tranz
                                                                .example_translation,
                                                            style: GoogleFonts
                                                                .oswald(
                                                              color:
                                                                  ThemeSetting
                                                                      .green,
                                                              fontSize:
                                                                  ThemeSetting
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
                                itemCount: _wordsService
                                    .word.value!.translations.length),
                          ),
                        ),
                      ],
                    );
                  }),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Obx(() {
                      /*         if (_authController.user.value != null &&
                          (connectivityController.connectivityResult.value !=
                                  null &&
                              connectivityController
                                      .connectivityResult.value!.name !=
                                  'none')) {*/
                      return FloatingActionButton(
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Get.bottomSheet(AddTranslation());
                        },
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
