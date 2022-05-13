import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/routes/routes.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';

import '../../../../system/helpers/sizes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> creds = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('login'.tr, style: TextStyle(fontSize: getShortSide(16))),
        actions: [
          IconButton(
            onPressed: () {
              if (creds['email'].isNotEmpty && creds['password'].isNotEmpty) {
                _authController.login(creds);
              } else {
                snackItOldWarning(
                  'email and password are required'.tr,
                );
              }
            },
            icon: const Icon(Icons.login),
          ).paddingOnly(right: getShortSide(10)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "login to be able to contribute to the community dictionnary".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getShortSide(14),
              ),
            ).paddingOnly(top: getShortSide(20), bottom: getShortSide(20)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: creds['email'],
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  creds['email'] = value;
                },
                decoration: roundedTextInputDecoration(labelText: 'email'.tr),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: creds['password'],
                obscureText: true,
                onChanged: (value) {
                  creds['password'] = value;
                },
                decoration:
                    roundedTextInputDecoration(labelText: 'password'.tr),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getShortSide(10)),
              child: Obx(() {
                return _authController.isConnecting.isFalse
                    ? const SizedBox.shrink()
                    : const LinearProgressIndicator();
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                  onPressed: () {
                    if (creds['email'].isNotEmpty &&
                        creds['password'].isNotEmpty) {
                      _authController.login(creds);
                    } else {
                      snackItOldWarning(
                        'email and password are required'.tr,
                      );
                    }
                  },
                  child: Text('login'.tr,
                      style: TextStyle(fontSize: getShortSide(12)))),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(Routes.pass_recovery_request);
                  },
                  child: Text('forgot password'.tr,
                      style: TextStyle(
                          fontSize: getShortSide(12), color: Colors.red))),
            ),
          ],
        ),
      ),
    );
  }
}
