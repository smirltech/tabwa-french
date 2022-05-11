import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../controllers/connectivity_controller.dart';
import '../../models/translation.dart';
import '../../models/word.dart';
import '../../routes/routes.dart';

class ProverbScreen extends StatefulWidget {
  const ProverbScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProverbScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProverbScreen> {
  final ConnectivityController connectivityController =
      Get.find<ConnectivityController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final AuthController _authController = Get.find<AuthController>();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          // title: Text(APP_NAME),
          title: CupertinoSearchTextField(
            controller: _wordsService.searchEditingController.value,
            onChanged: (value) {
              _wordsService.searchedWord.value = value;
            },
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            placeholder: "search".tr + ' ' + 'proverb'.tr,
          ),
          actions: [
            Obx(() {
              int cnt = 0;
              String cntStr = cnt.toString();
              try {
                cnt = _wordsService.filteredProverbs.value.length;
                cntStr = cnt > 999 ? '999+' : cnt.toString();
              } on Exception catch (_) {}
              return Badge(
                badgeContent:
                    Text(cntStr, style: const TextStyle(color: Colors.white))
                        .paddingSymmetric(
                  horizontal: 2,
                ),
                badgeColor: Theme.of(context).primaryColor,
                position: BadgePosition.topEnd(top: 0, end: -1),
                child: TextButton(
                  onPressed: () {
                    final String v = _wordsService.categorie.value == 'tabwa'
                        ? 'français'
                        : 'tabwa';
                    _wordsService.setCategorie(v);
                  },
                  child: Text(
                      _wordsService.categorie.value
                          .substring(0, 1)
                          .toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getShortSide(18),
                          color: Colors.white)),
                ),
              );
            }),
            const SizedBox(width: 10),
          ],
        ),
        floatingActionButton: Obx(() {
          if (_authController.user.value != null &&
              (connectivityController.connectivityResult.value != null &&
                  connectivityController.connectivityResult.value!.name !=
                      'none')) {
            return FloatingActionButton(
              onPressed: () {
                Get.toNamed('/add-word');
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
                      style: const TextStyle(fontSize: 24),
                    ),
                    const LinearProgressIndicator(),
                  ],
                ),
              ),
            );
          } else if (_wordsService.filteredProverbs.isEmpty) {
            if (_wordsService.searchedWord.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("no word or expression found from searched term".tr),
                    if (_authController.isAuthenticated())
                      OutlinedButton(
                          onPressed: () {
                            _wordsService.suggestAddingWord();
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
                _traas = _translations.map((t) => t.translation).toList();
              }
              return Card(
                elevation: 0,
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
                          fontSize: getShortSide(16),
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
                                  fontSize: getShortSide(14),
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
            itemCount: _wordsService.filteredProverbs.length,
          );
        }), onRefresh: () async {
          _wordsService.getAll();
          await 3.delay();
        }),
      ),
    );
  }
}
