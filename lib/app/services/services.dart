import 'package:get/get.dart';
import 'package:tabwa_french/app/services/words_service.dart';

class Services {
  /*
  * Append all the services inside init() for them to be initialized
  */
  static Future<void> init() async {
    Get.put<WordsService>(WordsService());
  }
}
