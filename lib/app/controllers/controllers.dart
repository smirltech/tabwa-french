import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';

class Controllers {
  /*
  * Append all the controllers inside init() for them to be initialized
  */
  static Future<void> init() async {
    Get.put<AuthController>(AuthController());
  }
}
