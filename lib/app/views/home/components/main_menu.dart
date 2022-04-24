import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/routes.dart';

class MainMenu extends StatelessWidget {
  MainMenu({Key? key}) : super(key: key);
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('menu'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: Text('home'.tr),
              onTap: () {
                // Navigator.pushNamed(context, '/home');
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text('profile'.tr),
              onTap: () {
                // Navigator.pushNamed(context, '/home');
                Get.back();
                Get.toNamed(Routes.profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('settings'.tr),
              onTap: () {
                // Navigator.pushNamed(context, '/home');
                Get.back();
                Get.toNamed(Routes.settings);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text('about'.tr),
              onTap: () {
                // Navigator.pushNamed(context, '/home');
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Builder(builder: (context) {
                  if (_authController.user.value != null) {
                    return Flexible(
                      child: IconButton(
                        tooltip: "logout".tr,
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          logcat("dododod");
                          _authController.logout();
                        },
                      ),
                    );
                  } else {
                    return Flexible(
                      child: IconButton(
                        tooltip: "login".tr,
                        icon: const Icon(Icons.login),
                        onPressed: () {
                          // Get.back();
                          logcat("heheheh");
                          Get.toNamed(Routes.login);
                        },
                      ),
                    );
                  }
                }),
                if (_authController.user.value == null)
                  Flexible(
                    child: IconButton(
                      tooltip: "register".tr,
                      icon: const Icon(Icons.person_add_alt),
                      onPressed: () {
                        Get.toNamed(Routes.register);
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
