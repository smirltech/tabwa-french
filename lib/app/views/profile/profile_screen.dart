import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../../system/themes/theme_setting.dart';
import '../../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).hintColor),
        title: Text('my profile'.tr,
            style: TextStyle(color: Theme.of(context).hintColor)),
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
            Expanded(
              child: ListView(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: getShortSide(100),
                  ).paddingSymmetric(vertical: getShortSide(20)),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: Text(_authController.user.value!.name!,
                        style: TextStyle(
                            fontSize: ThemeSetting.large,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text('name'.tr,
                        style: TextStyle(fontSize: ThemeSetting.normal)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(_authController.user.value!.email!,
                        style: TextStyle(
                            fontSize: ThemeSetting.large,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text('email'.tr,
                        style: TextStyle(fontSize: ThemeSetting.normal)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text('edit email'.tr,),
                  ),
                ),
               const SizedBox(width: 10,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text('edit password'.tr),
                  ),
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
