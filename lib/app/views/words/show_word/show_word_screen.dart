import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/views/words/show_word/components/add_translation.dart';
import 'package:tabwa_french/app/views/words/show_word/components/edit_translation.dart';
import 'package:tabwa_french/app/views/words/show_word/components/edit_word.dart';
import 'package:tabwa_french/system/helpers/audio_recorder/components/sound_player.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/themes/theme_setting.dart';

import '../../../../system/helpers/sizes.dart';
import '../../../controllers/connectivity_controller.dart';
import '../../../models/translation.dart';
import '../../../services/words_service.dart';

class ShowWordScreen extends StatelessWidget {
  ShowWordScreen({Key? key}) : super(key: key) {
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
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        soundPlayer.dispose();
        return Future(() => true);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text('word or expression'.tr),
          ),
          floatingActionButton: Obx(() {
            if (_authController.user.value != null &&
                (connectivityController.connectivityResult.value != null &&
                    connectivityController.connectivityResult.value!.name !=
                        'none')) {
              return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Get.bottomSheet(AddTranslation());
                },
              );
            }
            return const SizedBox.shrink();
          }),
          body: Obx(() {
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // todo: play audio
                                        String audioUrl =
                                            "https://tabwa.smirltech.com/audio/words/${_wordsService.word.value!.id}.aac";
                                        // logcat('audioUrl: $audioUrl');
                                        soundPlayer.playFromNet(audioUrl,
                                            whenFinished: () {
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
                                          fontSize: ThemeSetting.large,
                                        ),
                                      ),
                                    ),
                                    if (_authController.user.value != null &&
                                        (connectivityController
                                                    .connectivityResult.value !=
                                                null &&
                                            connectivityController
                                                    .connectivityResult
                                                    .value!
                                                    .name !=
                                                'none'))
                                      IconButton(
                                        onPressed: () {
                                          Get.bottomSheet(EditWord(
                                              wordy:
                                                  _wordsService.word.value!));
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
                          Translation tranz =
                              _wordsService.word.value!.translations[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        showCredit(context, "translation".tr,
                                            tranz.user, tranz.updater);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                              TextSpan(text: "Type", children: [
                                            TextSpan(
                                              text: ": ${tranz.type}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            ),
                                          ])),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  // todo: play audio
                                                  String audioUrl =
                                                      "https://tabwa.smirltech.com/audio/translations/${tranz.id}.aac";
                                                  //  logcat('audioUrl: $audioUrl');
                                                  soundPlayer
                                                      .playFromNet(audioUrl,
                                                          whenFinished: () {
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
                                                  tranz.translation,
                                                  style: GoogleFonts.courgette(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        ThemeSetting.normal,
                                                  ),
                                                ),
                                              ),
                                              if (_authController.user.value !=
                                                      null &&
                                                  (connectivityController
                                                              .connectivityResult
                                                              .value !=
                                                          null &&
                                                      connectivityController
                                                              .connectivityResult
                                                              .value!
                                                              .name !=
                                                          'none'))
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (tranz
                                                          .example.isNotEmpty)
                                                        IconButton(
                                                          onPressed: () {
                                                            // todo: play audio
                                                            String audioUrl =
                                                                "https://tabwa.smirltech.com/audio/examples/${tranz.id}.aac";
                                                            //  logcat('audioUrl: $audioUrl');
                                                            soundPlayer
                                                                .playFromNet(
                                                                    audioUrl,
                                                                    whenFinished:
                                                                        () {
                                                              toastItInfo(
                                                                  msg: 'done'
                                                                      .tr);
                                                            }, error: () {
                                                              toastItError(
                                                                msg:
                                                                    "no audio found"
                                                                        .tr,
                                                              );
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .volume_up_outlined,
                                                            color: Colors.blue,
                                                            size: getShortSide(
                                                                20),
                                                          ),
                                                        ),
                                                      Expanded(
                                                        child: Text(
                                                          tranz.example,
                                                          style: GoogleFonts
                                                              .courgette(
                                                            fontSize:
                                                                ThemeSetting
                                                                    .small,
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
                                                    right: getShortSide(10)),
                                                Expanded(
                                                  child: Text(
                                                    tranz.example_translation,
                                                    style:
                                                        GoogleFonts.courgette(
                                                      color: ThemeSetting.green,
                                                      fontSize:
                                                          ThemeSetting.small,
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
                        itemCount:
                            _wordsService.word.value!.translations.length),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
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
