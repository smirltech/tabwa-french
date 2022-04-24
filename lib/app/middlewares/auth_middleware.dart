import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/routes/routes.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';

import '../controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 10;

  bool isAuthenticated = true;

  @override
  RouteSettings? redirect(String? route) {
    isAuthenticated = Get.find<AuthController>().isAuthenticated();
    if (!isAuthenticated) {
      //  snackItOld("you're not logged in".tr);
      return RouteSettings(name: Routes.login);
    }
    return null;
  }
}
