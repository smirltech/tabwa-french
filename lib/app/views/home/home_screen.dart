import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smirl_version_checker/nv/version_checker.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/app/views/home/components/main_menu.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../models/translation.dart';
import '../../models/word.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
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
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        //  allowDismissal: false,
        dialogTitle: "Nouvelle version disponible : ${status.storeVersion}",
        dialogText: "NOTES:\n${status.releaseNotes}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Get.dialog(MainMenu(), transitionCurve: Curves.linearToEaseOut);
          },
        ),
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
          placeholder: "search".tr,
        ),
        actions: [
          Center(
            child: Obx(() {
              return Text(
                  _wordsService.categorie.value.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      fontSize: getShortSide(18), color: Colors.white));
            }),
          ).paddingOnly(right: 5),
          Center(
            child: Obx(() {
              int cnt = 0;
              try {
                cnt = _wordsService.filteredWords.value.length;
              } on Exception catch (_) {}
              return Text(cnt.toString());
            }),
          ),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: (_authController.user.value == null)
          ? null
          : FloatingActionButton(
              onPressed: () {
                Get.toNamed('/add-word');
              },
              child: const Icon(Icons.add),
            ),
      body: Obx(() {
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('no words or expressions yet'.tr),
                Text('the dictionnary has'.tr +
                    ' ${_wordsService.words.length} ' +
                    '${_wordsService.words.length > 1 ? 'words' : 'word'}'.tr),
              ],
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            Word word = _wordsService.filteredWords[index];
            List<Translation> _translations = word.translations;
            String _traa = "";
            if (_translations.isNotEmpty) {
              _traa = _translations.first.translation;
            }
            return Card(
              elevation: 0,
              child: ListTile(
                title: Text(word.word),
                subtitle: Text(_traa),
                /* trailing: IconButton(
                  icon: const Icon(Icons.bookmark_add),
                  onPressed: () {},
                ),*/
                onTap: () {
                  _wordsService.setActiveWord(word);
                  Get.toNamed('/show-word');
                },
              ),
            );
          },
          itemCount: _wordsService.filteredWords.length,
        );
      }),
    );
  }
}
