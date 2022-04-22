import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/system/configs/configs.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> creds = {
    'email': 'francis@smirl.org',
    'password': '123456',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'.tr),
      ),
      body: Center(
        child: Column(
          children: [
            Text(APP_NAME),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: creds['email'],
                onChanged: (value) {
                  creds['email'] = value;
                },
                decoration: InputDecoration(
                  labelText: 'email'.tr,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: creds['password'],
                onChanged: (value) {
                  creds['password'] = value;
                },
                decoration: InputDecoration(
                  labelText: 'password'.tr,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                child: Text('login'.tr),
                onPressed: () {
                  _authController.login(creds);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
