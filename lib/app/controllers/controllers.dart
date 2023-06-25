import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/controllers/connectivity_controller.dart';
import 'package:tabwa_french/app/controllers/translations_controller.dart';
import 'package:tabwa_french/app/controllers/types_controller.dart';

import 'audio_controller.dart';

class Controllers {
  /*
  * Append all the controllers inside init() for them to be initialized
  */
  static Future<void> init() async {
    Get.put<ConnectivityController>(ConnectivityController());
    AuthController.init();
    Get.put<TypesController>(TypesController());
    Get.put<TranslationsController>(TranslationsController());
    Get.put<AudioController>(AudioController());
  }
}
