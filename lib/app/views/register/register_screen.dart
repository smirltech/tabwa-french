import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/system/configs/configs.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> user = {
    'name': 'francis',
    'email': 'francis@smirl.org',
    'password': '123456',
    'c_password': '123456',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('register'.tr),
      ),
      body: Center(
        child: Column(
          children: [
            Text(APP_NAME),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: user['name'],
                onChanged: (value) {
                  user['name'] = value;
                },
                decoration: InputDecoration(
                  labelText: 'name'.tr,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: user['email'],
                onChanged: (value) {
                  user['email'] = value;
                },
                decoration: InputDecoration(
                  labelText: 'email'.tr,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: user['password'],
                onChanged: (value) {
                  user['password'] = value;
                },
                decoration: InputDecoration(
                  labelText: 'password'.tr,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: user['c_password'],
                onChanged: (value) {
                  user['c_password'] = value;
                },
                decoration: InputDecoration(
                  labelText: 'confirm password'.tr,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                child: Text('register'.tr),
                onPressed: () {
                  _authController.register(user);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
