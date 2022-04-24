import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my profile'.tr),
        actions: [
          IconButton(
            onPressed: () {
              _authController.logout();
            },
            icon: const Icon(Icons.logout),
          ).paddingOnly(right: getShortSide(10)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.account_circle,
              size: getShortSide(100),
            ).paddingSymmetric(vertical: getShortSide(20)),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(_authController.user.value!.name!,
                  style: Theme.of(context).textTheme.headline6),
              subtitle: Text('name'.tr),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(_authController.user.value!.email!,
                  style: Theme.of(context).textTheme.headline6),
              subtitle: Text('email'.tr),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text('edit email'.tr),
                  onPressed: () {
                    //_authController.logout();
                  },
                ),
                ElevatedButton(
                  child: Text('edit password'.tr),
                  onPressed: () {
                    //_authController.logout();
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: getShortSide(20)),
            SizedBox(
              height: getShortSide(20),
            ),
          ],
        ),
      ),
    );
  }
}
