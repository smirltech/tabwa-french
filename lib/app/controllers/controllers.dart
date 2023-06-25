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
    ConnectivityController.init();
    AuthController.init();
   TypesController.init();
    TranslationsController.init();
    AudioController.init();
  }
}
