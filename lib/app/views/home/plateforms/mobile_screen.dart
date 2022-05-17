import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../system/helpers/sizes.dart';
import '../../../../system/themes/theme_setting.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/connectivity_controller.dart';
import '../../../models/translation.dart';
import '../../../models/word.dart';
import '../../../routes/routes.dart';
import '../../../services/words_service.dart';
import '../components/main_menu.dart';

class MobileScreen extends StatelessWidget {
  MobileScreen({Key? key}) : super(key: key);
  final ConnectivityController connectivityController =
      Get.find<ConnectivityController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              Get.dialog(MainMenu(), transitionCurve: Curves.linearToEaseOut);
            },
          ),
          // title: Text(APP_NAME),
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
                icon: Badge(
                  badgeContent: Text(cntStr,
                          style: GoogleFonts.oswald(
                              color: Theme.of(context).hintColor,
                              fontSize: ThemeSetting.tiny))
                      .paddingSymmetric(
                    horizontal: 0,
                  ),
                  badgeColor: Theme.of(context).primaryColor,
                  position: BadgePosition.topEnd(top: -20, end: -30),
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
        floatingActionButton: Obx(() {
          if (_authController.user.value != null &&
              (connectivityController.connectivityResult.value != null &&
                  connectivityController.connectivityResult.value!.name !=
                      'none')) {
            return FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.addWord);
              },
              child: const Icon(Icons.add),
            );
          }
          return const SizedBox.shrink();
        }),
        body: RefreshIndicator(child: Obx(() {
          if (_wordsService.isLoading.isTrue) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(getShortSide(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'loading...'.tr,
                      style: TextStyle(fontSize: ThemeSetting.large),
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
                    Text("no word or expression found from searched term".tr,
                        style: TextStyle(fontSize: ThemeSetting.normal)),
                    if (_authController.isAuthenticated())
                      OutlinedButton(
                          onPressed: () {
                            _wordsService.suggestAddingWord();
                          },
                          child: Text("add".tr,
                              style: TextStyle(fontSize: ThemeSetting.normal)))
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('no words or expressions yet'.tr,
                      style: TextStyle(fontSize: ThemeSetting.normal)),
                  /*Text('the dictionnary has'.tr +
                      ' ${_wordsService.words.length} ' +
                      '${_wordsService.words.length > 1 ? 'words' : 'word'}'.tr),*/
                ],
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              Word word = _wordsService.filteredWords[index];
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
                    Get.toNamed(Routes.showWord);
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
                      Wrap(
                        children: [
                          ..._traas.map(
                            (tra) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              color: Theme.of(context).highlightColor,
                              child: Text(
                                tra,
                                style: GoogleFonts.oswald(
                                  fontSize: ThemeSetting.big,
                                ),
                              ),
                            ).paddingSymmetric(
                                horizontal: getShortSide(2),
                                vertical: getShortSide(2)),
                          ),
                        ],
                      ),
                    ],
                  ).paddingAll(getShortSide(5.0)),
                ),
              );
            },
            itemCount: _wordsService.filteredWords.length,
          ).paddingSymmetric(horizontal: getShortSide(2.0));
        }), onRefresh: () async {
          _wordsService.getAll();
          await 3.delay();
        }),
      ),
    );
  }
}
