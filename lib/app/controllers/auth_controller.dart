import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

import '../models/user.dart';

class AuthController extends GetxController {
  var user = Rxn<User>();

  login(Map<String, dynamic> creds) async {
    User? u = await User.login(creds);
    if (u != null) Get.back();
  }

  register(Map<String, dynamic> user) async {
    User? u = await User.register(user);
    if (u != null) Get.back();
  }

  void logout() {
    user.value = null;
    GetStorage().remove('token');
    GetStorage().remove('user');
    Get.offAllNamed('/');
  }

  prelogin() async {
    snackItOld("user initiate login successfully".tr);
    var storage = GetStorage();
    var token;
    try {
      token = await storage.read('token');
    } on Exception catch (e) {
      // TODO
    }
    var _user;
    try {
      _user = await storage.read('user');
    } on Exception catch (e) {
      // TODO
    }
    if (token != null && _user != null) {
      user.value = User.fromMap(_user);
      logcat('User found in storage');
      snackItOld("user is connected now".tr);
    } else {
      snackItOld("user connection failed".tr);
    }
  }

  @override
  void onInit() {
    super.onInit();

    GetStorage().listenKey('token', (value) {
      //   logcat("token: $value");
    });
    GetStorage().listenKey('user', (value) {
      try {
        if (value != null) user.value = User.fromMap(value);
      } on Exception catch (e) {}
      // logcat("user: ${user.value.toString()}");
    });
    prelogin();
  }

  @override
  void onReady() {
    super.onReady();
    prelogin();
  }

  bool isAuthenticated() {
    return user.value != null;
  }
}
