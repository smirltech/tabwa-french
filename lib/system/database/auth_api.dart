import 'package:get/get.dart';
import 'package:tabwa_french/system/database/configs.dart';

import '../../app/models/word.dart';

class AuthApi {
  static final GetConnect _gc = GetConnect();

  static Future<dynamic> login(Map<String, dynamic> creds) =>
      _gc.post(LOGIN, creds, headers: headers());

  static Future<dynamic> register(Map<String, dynamic> user) =>
      _gc.post(REGISTER, user, headers: headers());

  static Future<dynamic> forgotPassword(Map<String, dynamic> user) =>
      _gc.post(FORGOT_PASSWORD_URL, user, headers: headers());

  static Future<dynamic> passwordResetConfirmCode(Map<String, dynamic> user) =>
      _gc.post(PASSWORD_RESET_CONFIRM_CODE_URL, user, headers: headers());

  static Future<dynamic> forgotPasswordReset(Map<String, dynamic> user) =>
      _gc.post(FORGOT_PASSWORD_RESET_URL, user, headers: headers());
}
