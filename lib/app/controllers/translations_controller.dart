import 'package:get/get.dart';
import 'package:tabwa_french/app/models/translation.dart';
import 'package:tabwa_french/app/models/type.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

class TranslationsController extends GetxController {
  static TranslationsController get of=> Get.find<TranslationsController>();
  static TranslationsController init()=> Get.put<TranslationsController>(TranslationsController());
  void addTranslation(Map<String, dynamic> translation) async {
    await Translation.add(translation);
    Get.find<WordsService>().updateActiveWord();
    Get.back();
  }

  void editTranslation(Map<String, dynamic> translation) async {
    //  logcat(translation.toString());
    await Translation.edit(translation, translation['id']);
    Get.find<WordsService>().updateActiveWord();
    Get.find<WordsService>().getAll();
    Get.back();
  }
}
