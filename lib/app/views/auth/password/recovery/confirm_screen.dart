import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../system/helpers/helpers.dart';
import '../../../../../system/helpers/sizes.dart';
import '../../../../controllers/auth_controller.dart';

class PasswordRecoveryConfirmScreen extends StatelessWidget {
  PasswordRecoveryConfirmScreen({Key? key}) : super(key: key) {
    if (GetStorage().hasData("reset-email")) {
      creds["email"] = GetStorage().read("reset-email");
    }
  }

  final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> creds = {
    'email': '',
    'code': '',
  };

  final canRequest = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm assword recovery code',
            style: TextStyle(fontSize: getShortSide(16))),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "if you have received a code, enter it below".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getShortSide(14),
              ),
            ).paddingOnly(top: getShortSide(20), bottom: getShortSide(20)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (value) {
                  creds['code'] = value;
                  canRequest.value =
                      creds['code'].isNotEmpty && creds['code'].length == 7;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your code';
                  }
                  if (value.length != 7) {
                    return 'Please enter a valid length code';
                  }
                  if (!codeValid(value)) {
                    return 'Please enter a valid code';
                  }
                  return null;
                },
                maxLength: 7,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: roundedTextInputDecoration(
                    labelText: 'enter the valid code'.tr),
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
                            _authController.passwordResetConfirmCode(creds);
                          },
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: getShortSide(12))),
                    child: Text("Check the code".tr));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
