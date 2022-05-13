import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/app/routes/routes.dart';

import '../../../../../system/helpers/helpers.dart';
import '../../../../../system/helpers/sizes.dart';
import '../../../../controllers/auth_controller.dart';

class PasswordRecoveryRequestScreen extends StatelessWidget {
  PasswordRecoveryRequestScreen({Key? key}) : super(key: key) {
    if (GetStorage().hasData("reset-email")) {
      creds["email"] = GetStorage().read("reset-email");
      canRequest.value = emailValid(creds["email"]);
    }
  }

  final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> creds = {
    'email': '',
  };

  final canRequest = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('password recovery'.tr,
            style: TextStyle(fontSize: getShortSide(16))),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "if you have forgotten your password, just enter your valid email to request for a password reset. An email will be sent to that address"
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getShortSide(14),
              ),
            ).paddingAll(getShortSide(20)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: creds['email'],
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  creds['email'] = value;
                  canRequest.value =
                      creds['email'].isNotEmpty && emailValid(creds['email']);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email'.tr;
                  }
                  if (!emailValid(value)) {
                    return 'please enter a valid email'.tr;
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                decoration: roundedTextInputDecoration(
                    labelText: 'enter your valid email'.tr),
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
                            _authController.forgotPassword(creds);
                          },
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: getShortSide(12))),
                    child: Text("request for the code".tr));
              }),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text.rich(
                TextSpan(
                    text: "if you received the code already".tr + ',',
                    children: [
                      TextSpan(
                        text: " " + "enter it here".tr + " ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.orange,
                          color: Colors.black,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.pass_recovery_confirm);
                          },
                      ),
                    ]),
                style: TextStyle(
                  fontSize: getShortSide(11),
                ),
              ), //Text("I have got the code"),
            ),
          ],
        ),
      ),
    );
  }
}
