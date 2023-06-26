import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

import '../models/user.dart';
import '../routes/routes.dart';

class AuthController extends GetxController {
  static AuthController get of=> Get.find<AuthController>();
  static AuthController init()=> Get.put<AuthController>(AuthController());
  var user = Rxn<User>();
  var themy = "system".obs;
  var isRequestForgotPassword = false.obs;
  var isConnecting = false.obs;

  void storeTheme(String theme) {
    // themy.value = theme;
    GetStorage().write("themy", theme);
  }

  login(Map<String, dynamic> creds) async {
    isConnecting.value = true;
    User? u = await User.login(creds);
    isConnecting.value = false;
    if (u != null) Get.back();
  }

  register(Map<String, dynamic> user) async {
    isConnecting.value = true;
    User? u = await User.register(user);
    isConnecting.value = false;
    if (u != null) Get.back();
  }

  void logout() {
    user.value = null;
    GetStorage().remove('token');
    GetStorage().remove('user');
    Get.offAllNamed('/');
  }

  prelogin() async {
    toastItInfo(msg: "user initiate login successfully".tr);
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
      toastItSuccess(msg: "user is connected now".tr);
    } else {
      toastItError(msg: "user connection failed".tr);
    }
  }

  initOnlineLogin() async {

    var storage = GetStorage();
    var token;
    try {
      token = await storage.read('token');
    } on Exception catch (e) {
      // TODO
    }
    var _user;

    if (token != null) {
      Response? response = await User.authTest(token);
      log(response?.statusCode.toString()??'');

     // user.value = User.fromMap(_user);
      //logcat('User found in storage');
     // toastItSuccess(msg: "user is connected now".tr);
    } else {
      //toastItError(msg: "user connection failed".tr);
    }
  }

  @override
  void onInit() {
    super.onInit();
    GetStorage().writeIfNull('themy', themy.value);
    themy.value = GetStorage().read('themy');
    GetStorage().listenKey('themy', (value) {
      themy.value = value;
      Get.changeThemeMode(value == 'dark'
          ? ThemeMode.dark
          : value == 'light'
              ? ThemeMode.light
              : ThemeMode.system);
    });

    GetStorage().listenKey('token', (value) {
      //   logcat("token: $value");
    });
    GetStorage().listenKey('user', (value) {
      try {
        if (value != null) user.value = User.fromMap(value);
      } on Exception catch (e) {}
      // logcat("user: ${user.value.toString()}");
    });
    // prelogin();
  }

  @override
  void onReady() {
    super.onReady();
    prelogin();
  }

  bool isAuthenticated() {
    return user.value != null;
  }

// todo: password resetting implementation
  forgotPassword(Map<String, dynamic> creds) async {
    isRequestForgotPassword.value = true;
    Response response = await User.forgotPassword(creds);
    if (response.statusCode == 200) {
      logcat(response.body.toString());
      Map<String, dynamic> body = response.body;
      if (body['status'] == 200) {
        GetStorage().write('reset-email', creds['email']);
        snackItOldSuccess(body['message']);
        Get.toNamed(Routes.pass_recovery_confirm);
      } else {
        snackItOldError(body['message']);
      }
    } else {
      snackItOldWarning("password reset failed".tr);
    }
    isRequestForgotPassword.value = false;
  }

  passwordResetConfirmCode(Map<String, dynamic> creds) async {
    isRequestForgotPassword.value = true;
    Response response = await User.passwordResetConfirmCode(creds);
    if (response.statusCode == 200) {
      logcat(response.body.toString());
      Map<String, dynamic> body = response.body;
      if (body['status'] == 200) {
        GetStorage().write('reset-code', creds['code']);
        snackItOldSuccess(body['message']);
        Get.toNamed(Routes.pass_recovery_reset);
      } else {
        snackItOldError(body['message']);
      }
    } else {
      snackItOldWarning("password reset failed".tr);
    }
    isRequestForgotPassword.value = false;
  }

  forgotPasswordReset(Map<String, dynamic> creds) async {
    isRequestForgotPassword.value = true;
    Response response = await User.forgotPasswordReset(creds);
    if (response.statusCode == 200) {
      logcat(response.body.toString());
      Map<String, dynamic> body = response.body;
      if (body['status'] == 200) {
        GetStorage().remove('reset-code');
        GetStorage().remove('reset-email');

        GetStorage().write('token', response.body['data']['token']);

        User u = User.fromMap(response.body['data']);
        GetStorage().write('user', u.toMap());
        user.value = u;

        snackItOldSuccess(body['message']);
        Get.offAndToNamed(Routes.home);
      } else {
        snackItOldError(body['message']);
      }
    } else {
      snackItOldWarning("password reset failed".tr);
    }
    isRequestForgotPassword.value = false;
  }
}
