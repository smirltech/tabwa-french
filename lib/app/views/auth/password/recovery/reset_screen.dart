import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../system/helpers/helpers.dart';
import '../../../../../system/helpers/sizes.dart';
import '../../../../controllers/auth_controller.dart';

class PasswordRecoveryResetScreen extends StatelessWidget {
  PasswordRecoveryResetScreen({Key? key}) : super(key: key) {
    if (GetStorage().hasData("reset-email")) {
      creds["email"] = GetStorage().read("reset-email");
    }
    if (GetStorage().hasData("reset-code")) {
      creds["code"] = GetStorage().read("reset-code");
    }
  }

  final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> creds = {
    'email': '',
    'code': '',
    'password': '',
  };

  final canRequest = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('change password'.tr,
            style: TextStyle(fontSize: getShortSide(16))),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "your password reset request code was confirmed, you can reset your password now"
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getShortSide(14),
              ),
            ).paddingAll(getShortSide(20)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (value) {
                  creds['password'] = value;
                  canRequest.value = creds['password'].isNotEmpty &&
                      creds['password'].length >= 6;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your new password'.tr;
                  }
                  if (value.length < 6) {
                    return 'please enter a valid length password, minimum 6 characters'
                        .tr;
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: roundedTextInputDecoration(
                    labelText: 'enter new password'.tr),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                return _authController.isRequestForgotPassword.isFalse
                    ? const SizedBox.shrink()
                    : const LinearProgressIndicator();
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                return ElevatedButton(
                    onPressed: canRequest.isFalse
                        ? null
                        : () {
                            _authController.forgotPasswordReset(creds);
                          },
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: getShortSide(12))),
                    child: Text("reset password".tr));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
