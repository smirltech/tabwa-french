import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabwa_french/app/views/home/plateforms/mobile/components/item_card.dart';

import '../../../../../system/helpers/sizes.dart';
import '../../../../../system/themes/theme_setting.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../services/words_service.dart';
import '../../components/main_menu.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme
                  .of(context)
                  .hintColor,
            ),
            onPressed: () {
              Get.dialog(MainMenu(), transitionCurve: Curves.linearToEaseOut);
            },
          ),
          // title: Text(APP_NAME),
          title: Obx(() {
            return CupertinoSearchTextField(
              controller: WordsService.of.searchEditingController.value,
              onChanged: (value) {
                WordsService.of.searchedWord.value = value;
              },
              style: TextStyle(
                  fontSize: ThemeSetting.large,
                  color: Theme
                      .of(context)
                      .hintColor),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme
                      .of(context)
                      .hintColor,
                  width: 0.5,
                ),
              ),
              placeholder: "search".tr +
                  " " +
                  "in".tr +
                  ' ' +
                  WordsService.of.categorie.value,
            );
          }),
          actions: [
            Obx(() {
              int cnt = 0;
              String cntStr = cnt.toString();
              try {
                cnt = WordsService.of.filteredWords.value.length;
                cntStr = cnt > 999 ? '999+' : cnt.toString();
              } on Exception catch (_) {}
              return IconButton(
                onPressed: () {
                  final String v = WordsService.of.categorie.value == 'tabwa'
                      ? 'français'
                      : 'tabwa';
                  WordsService.of.setCategorie(v);
                },
                // color: Theme.of(context).hintColor,
                icon: badges.Badge(
                  badgeContent: Text(cntStr,
                      style: GoogleFonts.oswald(
                          color: Theme
                              .of(context)
                              .hintColor,
                          fontSize: ThemeSetting.tiny))
                      .paddingSymmetric(
                    horizontal: 0,
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Theme
                        .of(context)
                        .secondaryHeaderColor,
                  ),
                  //badgeColor: Theme.of(context).primaryColor,
                  position: badges.BadgePosition.topEnd(top: -10, end: -25),
                  child: Text(
                      WordsService.of.categorie.value.substring(0, 1)
                          .toUpperCase(),
                      style: GoogleFonts.oswald(
                          fontWeight: FontWeight.bold,
                          fontSize: ThemeSetting.massive,
                          color: Theme
                              .of(context)
                              .hintColor)),
                ),
              );
            }),
            const SizedBox(width: 20),
          ],
        ),
        floatingActionButton: AuthController.of.isAuthenticated()
            ? FloatingActionButton(
          backgroundColor: ThemeSetting.green,
          onPressed: () {
           // AuthController.of.initOnlineLogin();
            Get.toNamed(Routes.addWord);
          },
          child: const Icon(Icons.add),
        )
            : null,
        body: SafeArea(
          child: RefreshIndicator(child: Obx(() {
            if (WordsService.of.isLoading.isTrue) {
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
            } else if (WordsService.of.filteredWords.isEmpty) {
              if (WordsService.of.searchedWord.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("no word or expression found from searched term".tr,
                          style: TextStyle(fontSize: ThemeSetting.normal)),
                      if (AuthController.of.isAuthenticated())
                        OutlinedButton(
                            onPressed: () {
                              WordsService.of.suggestAddingWord();
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
                        style: TextStyle(fontSize: ThemeSetting.normal)),
                    /*Text('the dictionary has'.tr +
                        ' ${WordsService.of.words.length} ' +
                        '${WordsService.of.words.length > 1 ? 'words' : 'word'}'.tr),*/
                  ],
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return ItemCard(word: WordsService.of.filteredWords[index]);
              },
              itemCount: WordsService.of.filteredWords.length,
            ).paddingSymmetric(horizontal: getShortSide(2.0));
          }), onRefresh: () async {
            WordsService.of.getAll();
            await 3.delay();
          }),
        ),
      );
    });
  }
}
