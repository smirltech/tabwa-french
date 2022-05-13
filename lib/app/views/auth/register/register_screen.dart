import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';

import '../../../../system/helpers/helpers.dart';
import '../../../../system/helpers/sizes.dart';
import '../../../routes/routes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final AuthController _authController = Get.find<AuthController>();
  Map<String, dynamic> user = {
    'name': '',
    'email': '',
    'password': '',
    'c_password': '',
  };

  var _visibility = true.obs;
  var _accept = false.obs;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('register'.tr),
        actions: [
          Obx(() {
            return IconButton(
              onPressed: _accept.isFalse
                  ? null
                  : () {
                      _authController.register(user);
                    },
              icon: const Icon(Icons.person_add_alt),
            );
          }).paddingOnly(right: getShortSide(10)),
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
                keyboardType: TextInputType.emailAddress,
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
                obscureText: true,
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
                obscureText: true,
                onChanged: (value) {
                  user['c_password'] = value;
                },
                decoration: roundedTextInputDecoration(
                    labelText: 'confirm password'.tr),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Obx(() {
                return Row(
                  children: [
                    Checkbox(
                      value: _accept.value,
                      onChanged: (value) {
                        _accept.value = value!;
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text:
                              "En soumettant ce formulaire, je confirme ayant lu et j'accepte les ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "termes et conditions d'utilisation",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(Routes.privacy);
                                },
                            ),
                          ],
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                );
              }),
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
              child: Obx(() {
                return OutlinedButton(
                    onPressed: _accept.isFalse
                        ? null
                        : () {
                            _authController.register(user);
                          },
                    child: Text('register'.tr,
                        style: TextStyle(fontSize: getShortSide(12))));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
