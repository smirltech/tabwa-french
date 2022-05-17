import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';
import 'package:tabwa_french/system/themes/theme_setting.dart';

import '../../../main.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).hintColor),
        title: Text('about'.tr,
            style: TextStyle(color: Theme.of(context).hintColor)),
      ),
      body: Center(
        child: Column(
          children: [
            Text(APP_NAME.tr, style: TextStyle(fontSize: ThemeSetting.large))
                .paddingOnly(bottom: getShortSide(10.0)),
            Text("Version ${PACKAGE_INFO.version}(${PACKAGE_INFO.buildNumber})",
                    style: TextStyle(fontSize: ThemeSetting.big))
                .paddingOnly(bottom: getShortSide(10.0)),
            SizedBox(height: getShortSide(20)),
            Text('about this app statement'.tr,
                textAlign: TextAlign.justify,
                style: GoogleFonts.courgette(fontSize: ThemeSetting.big)),
            Text.rich(
              TextSpan(text: "the app currently contains".tr, children: [
                TextSpan(
                    text: ' ${Get.find<WordsService>().words.value.length} ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error)),
                TextSpan(
                    text: 'words'.tr +
                        " " +
                        "and it can grow as quickly as you want in a very short period of time"
                            .tr)
              ]),
              textAlign: TextAlign.left,
              style: GoogleFonts.courgette(fontSize: ThemeSetting.big),
            ).paddingOnly(top: getShortSide(10.0)),
            const Spacer(),
            Text('conceived and developed by'.tr + " $APP_AUTHOR",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: ThemeSetting.small)),
            Text(
                "Copyright © ${DateTime.now().year} SmirlTech, All rights reserved.",
                style: TextStyle(fontSize: ThemeSetting.small)),
            SizedBox(height: getShortSide(10)),
          ],
        ),
      ).paddingAll(10.0),
    );
  }
}
