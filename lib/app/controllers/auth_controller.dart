import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

import '../models/user.dart';

class AuthController extends GetxController {
  var user = Rxn<User>();

  login(Map<String, dynamic> creds) async {
    await User.login(creds);
  }

  register(Map<String, dynamic> user) async {
    await User.register(user);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetStorage().listenKey('token', (value) {
      logcat("token: $value");
    });
    GetStorage().listenKey('user', (value) {
      user.value = User.fromMap(value);
      logcat("user: ${user.value.toString()}");
    });
  }
}
