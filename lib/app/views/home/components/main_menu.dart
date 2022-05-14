import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/routes.dart';

class MainMenu extends StatelessWidget {
  MainMenu({Key? key}) : super(key: key);
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('menu'.tr, style: TextStyle(fontSize: getTextSize(16))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                Icons.home,
                size: getShortSide(30),
              ),
              title:
                  Text('home'.tr, style: TextStyle(fontSize: getTextSize(14))),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                size: getShortSide(30),
              ),
              title: Text('proverbs'.tr,
                  style: TextStyle(fontSize: getTextSize(14))),
              onTap: () {
                Get.back();
                Get.find<WordsService>().loadProverbsScreen();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: getShortSide(30),
              ),
              title: Text('profile'.tr,
                  style: TextStyle(fontSize: getTextSize(14))),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.profile);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: getShortSide(30),
              ),
              title: Text('settings'.tr,
                  style: TextStyle(fontSize: getTextSize(14))),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.settings);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.privacy_tip_outlined,
                size: getShortSide(30),
              ),
              title: Text('privacy policy'.tr,
                  style: TextStyle(fontSize: getTextSize(14))),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.privacy);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                size: getShortSide(30),
              ),
              title:
                  Text('about'.tr, style: TextStyle(fontSize: getTextSize(14))),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.about);
              },
            ),
            const Spacer(),
            Divider(
              thickness: 0.8,
              color: Theme.of(context).primaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Builder(builder: (context) {
                  if (_authController.user.value != null) {
                    return Flexible(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.back();
                          _authController.logout();
                        },
                        style: OutlinedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        icon: Icon(
                          Icons.logout,
                          size: getShortSide(30),
                        ),
                        label: Text('logout'.tr,
                            style: TextStyle(fontSize: getTextSize(14))),
                      ),
                    );
                  } else {
                    return Flexible(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(Routes.login);
                        },
                        icon: Icon(
                          Icons.login,
                          size: getShortSide(30),
                        ),
                        label: Text('login'.tr,
                            style: TextStyle(fontSize: getTextSize(14))),
                      ),
                    );
                  }
                }),
                if (_authController.user.value == null)
                  Flexible(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Get.back();
                        Get.toNamed(Routes.register);
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      icon: Icon(
                        Icons.person_add_alt,
                        size: getShortSide(30),
                      ),
                      label: Text('register'.tr,
                          style: TextStyle(fontSize: getTextSize(14))),
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
