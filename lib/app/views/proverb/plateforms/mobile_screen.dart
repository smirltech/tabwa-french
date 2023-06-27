import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../system/helpers/sizes.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/connectivity_controller.dart';
import '../../../models/translation.dart';
import '../../../models/word.dart';
import '../../../routes/routes.dart';
import '../../../services/words_service.dart';

class MobileScreen extends StatelessWidget {
  MobileScreen({Key? key}) : super(key: key);
  // final ConnectivityController connectivityController =
  //     Get.find<ConnectivityController>();
  // final WordsService WordsService.of = Get.find<WordsService>();
  // final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).hintColor),
        title: CupertinoSearchTextField(
          controller: WordsService.of.searchEditingController.value,
          onChanged: (value) {
            WordsService.of.searchedWord.value = value;
          },
          style: TextStyle(fontSize: getTextSize(12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).hintColor,
              width: 0.5,
            ),
          ),
          placeholder: "search".tr + ' ' + 'proverb'.tr,
        ),
        actions: [
          Obx(() {
            int cnt = 0;
            String cntStr = cnt.toString();
            try {
              cnt = WordsService.of.filteredProverbs.value.length;
              cntStr = cnt > 999 ? '999+' : cnt.toString();
            } on Exception catch (_) {}
            return badges.Badge(
              badgeContent: Text(cntStr,
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: getTextSize(9)))
                  .paddingSymmetric(
                horizontal: 2,
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Theme.of(context).primaryColor,
              ),
              position: badges.BadgePosition.topEnd(top: 10, end: 10),
              child: TextButton(
                onPressed: () {
                  final String v = WordsService.of.categorie.value == 'tabwa'
                      ? 'français'
                      : 'tabwa';
                  WordsService.of.setCategorie(v);
                },
                child: Text(
                    WordsService.of.categorie.value.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getTextSize(18),
                      color: Theme.of(context).hintColor,
                    )),
              ),
            );
          }),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-word');
        },
        child: const Icon(Icons.add),
      ),
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
                      style: const TextStyle(fontSize: 24),
                    ),
                    const LinearProgressIndicator(),
                  ],
                ),
              ),
            );
          } else if (WordsService.of.filteredProverbs.isEmpty) {
            if (WordsService.of.searchedWord.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("no word or expression found from searched term".tr),
                    if (AuthController.of.isAuthenticated())
                      OutlinedButton(
                          onPressed: () {
                            WordsService.of.suggestAddingWord();
                          },
                          child: Text("add".tr)),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('no proverb yet'.tr),
                  /*Text('the dictionnary has'.tr +
                        ' ${WordsService.of.words.length} ' +
                        '${WordsService.of.words.length > 1 ? 'words' : 'word'}'.tr),*/
                ],
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              Word word = WordsService.of.filteredProverbs[index];
              List<Translation> _translations = word.translations;
              List<String> _traas = [];
              if (_translations.isNotEmpty) {
                _traas = _translations.map((t) => t.translation).toList();
              }
              return Card(
                elevation: 0.2,
                child: InkWell(
                  onTap: () {
                    WordsService.of.setActiveWord(word);
                    Get.toNamed(Routes.showWord);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word.word,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.bold,
                          fontSize: getTextSize(16),
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
                                style: GoogleFonts.courgette(
                                  fontSize: getTextSize(14),
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
            itemCount: WordsService.of.filteredProverbs.length,
          );
        }), onRefresh: () async {
          WordsService.of.getAll();
          await 3.delay();
        }),
      ),
    );
  }
}
