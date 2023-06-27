import 'package:get/get.dart';
import 'package:tabwa_french/app/models/translation.dart';
import 'package:tabwa_french/app/services/words_service.dart';

class TranslationsController extends GetxController {
  static TranslationsController get of=> Get.find<TranslationsController>();
  static TranslationsController init()=> Get.put<TranslationsController>(TranslationsController());
  void addTranslation(Map<String, dynamic> translation) async {
    await Translation.add(translation);
    WordsService.of.updateActiveWord();
    Get.back();
  }

  void editTranslation(Map<String, dynamic> translation) async {
    //  logcat(translation.toString());
    await Translation.edit(translation, translation['id']);
    WordsService.of.updateActiveWord();
    WordsService.of.getAll();
    Get.back();
  }
}
