import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/system/themes/theme_setting.dart';

import '../../../../../system/helpers/helpers.dart';
import '../../../../../system/helpers/sizes.dart';
import '../../../../controllers/auth_controller.dart';

class PasswordRecoveryConfirmScreen extends StatelessWidget {
  PasswordRecoveryConfirmScreen({Key? key}) : super(key: key) {
    if (GetStorage().hasData("reset-email")) {
      creds["email"] = GetStorage().read("reset-email");
    }
  }

  //final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> creds = {
    'email': '',
    'code': '',
  };

  final canRequest = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).hintColor),
        title: Text('confirm code'.tr,
            style: TextStyle(fontSize: ThemeSetting.large)),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "if you have received a code, enter it below".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ThemeSetting.big,
              ),
            ).paddingAll(getShortSide(20)),
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
                    return 'please enter your code'.tr;
                  }
                  if (value.length != 7) {
                    return 'please enter a valid length code'.tr;
                  }
                  if (!codeValid(value)) {
                    return 'please enter a valid code'.tr;
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
                return AuthController.of.isRequestForgotPassword.isFalse
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
                            AuthController.of.passwordResetConfirmCode(creds);
                          },
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: ThemeSetting.normal)),
                    child: Text("check the code".tr));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
