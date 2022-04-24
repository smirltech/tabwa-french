import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';

import '../../../system/helpers/sizes.dart';

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
      appBar: AppBar(
        title: Text('login'.tr),
        actions: [
          IconButton(
            onPressed: () {
              _authController.login(creds);
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
                onChanged: (value) {
                  creds['password'] = value;
                },
                decoration:
                    roundedTextInputDecoration(labelText: 'password'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
