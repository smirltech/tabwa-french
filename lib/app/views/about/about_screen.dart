import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../../main.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about'.tr),
      ),
      body: Center(
        child: Column(
          children: [
            Text(APP_NAME.tr, style: TextStyle(fontSize: getShortSide(20)))
                .paddingOnly(bottom: getShortSide(10.0)),
            Text("Version ${PACKAGE_INFO.version}(${PACKAGE_INFO.buildNumber})",
                    style: TextStyle(fontSize: getShortSide(16)))
                .paddingOnly(bottom: getShortSide(10.0)),
            SizedBox(height: getShortSide(20)),
            Text('about this app statement'.tr,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: getShortSide(16))),
            Text.rich(
              TextSpan(text: "the app currently contains".tr, children: [
                TextSpan(
                    text: ' ${Get.find<WordsService>().words.value.length} ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                TextSpan(
                    text: 'words'.tr +
                        " " +
                        "and it can grow as quickly as you want in a very short period of time"
                            .tr)
              ]),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: getShortSide(16)),
            ).paddingOnly(top: getShortSide(10.0)),
            const Spacer(),
            Text('conceived and developed by'.tr + " $APP_AUTHOR",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: getShortSide(12))),
            Text(
                "Copyright © ${DateTime.now().year} SmirlTech, All rights reserved.",
                style: TextStyle(fontSize: getShortSide(12))),
            SizedBox(height: getShortSide(10)),
          ],
        ),
      ).paddingAll(10.0),
    );
  }
}
