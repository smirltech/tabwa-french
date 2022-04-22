import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

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
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('settings'.tr),
              onTap: () {
                // Navigator.pushNamed(context, '/home');
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
              children: [
                Flexible(
                  child: ListTile(
                    leading: const Icon(Icons.login),
                    title: Text('login'.tr),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.login);
                    },
                  ),
                ),
                Flexible(
                  child: ListTile(
                    leading: const Icon(Icons.person_add_alt),
                    title: Text('register'.tr),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.register);
                    },
                  ),
                ),
                Flexible(
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text('logout'.tr),
                    onTap: () {
                      // Navigator.pushNamed(context, '/home');
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
