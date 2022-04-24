import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/system/configs/configs.dart';

import '../../../system/helpers/helpers.dart';
import '../../../system/helpers/sizes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> user = {
    'name': '',
    'email': '',
    'password': '',
    'c_password': '',
  };

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('register'.tr),
        actions: [
          IconButton(
            onPressed: () {
              _authController.register(user);
            },
            icon: const Icon(Icons.person_add_alt),
          ).paddingOnly(right: getShortSide(10)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "register to the dictionnary to be able to contribute to the community with your precious knowledge"
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getShortSide(14),
              ),
            ).paddingOnly(top: getShortSide(20), bottom: getShortSide(20)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: user['name'],
                onChanged: (value) {
                  user['name'] = value;
                },
                decoration: roundedTextInputDecoration(labelText: 'name'.tr),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: user['email'],
                onChanged: (value) {
                  user['email'] = value;
                },
                decoration: roundedTextInputDecoration(labelText: 'email'.tr),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: user['password'],
                onChanged: (value) {
                  user['password'] = value;
                },
                decoration:
                    roundedTextInputDecoration(labelText: 'password'.tr),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: user['c_password'],
                onChanged: (value) {
                  user['c_password'] = value;
                },
                decoration: roundedTextInputDecoration(
                    labelText: 'confirm password'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
