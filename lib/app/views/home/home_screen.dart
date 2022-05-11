import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smirl_version_checker/nv/version_checker.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/app/views/home/components/main_menu.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../controllers/connectivity_controller.dart';
import '../../models/translation.dart';
import '../../models/word.dart';
import '../../routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  final ConnectivityController connectivityController =
      Get.find<ConnectivityController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final AuthController _authController = Get.find<AuthController>();

  initState() {
    super.initState();

    final newVersion = VersionChecker(
      iOSId: 'org.smirl.tabwa_french',
      androidId: 'org.smirl.tabwa_french',
    );

    const simpleBehavior = false;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }
  }

  basicStatusCheck(VersionChecker newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(VersionChecker newVersion) async {
    final status = await newVersion.getVersionStatus();

    if (status != null && status.canUpdate) {
      final releaseNotes = status.releaseNotes!.replaceAll(";", ";\n");
      // debugPrint(status.releaseNotes);
      // debugPrint(status.appStoreLink);
      // debugPrint(status.localVersion);
      // debugPrint(status.storeVersion);
      // debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        //  allowDismissal: false,
        dialogTitle: "Nouvelle version disponible : ${status.storeVersion}",
        dialogText: "NOTES:\n${releaseNotes}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
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
              return Badge(
                badgeContent:
                    Text(cntStr, style: const TextStyle(color: Colors.white))
                        .paddingSymmetric(
                  horizontal: 2,
                ),
                badgeColor: Theme.of(context).primaryColor,
                position: BadgePosition.topEnd(top: 0, end: -5),
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
          } else if (_wordsService.filteredWords.isEmpty) {
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
                  Text('no words or expressions yet'.tr),
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
            itemCount: _wordsService.filteredWords.length,
          );
        }), onRefresh: () async {
          _wordsService.getAll();
          await 3.delay();
        }),
      ),
    );
  }
}
