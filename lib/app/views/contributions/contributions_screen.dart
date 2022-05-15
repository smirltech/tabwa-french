import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/system/configs/configs.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../../main.dart';
import '../../models/buggy.dart';

class ContributionsScreen extends StatelessWidget {
  ContributionsScreen({Key? key}) : super(key: key);
  final WordsService _wordsService = Get.find<WordsService>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('contributions'.tr),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
                    "We are grateful to announce the list of people who have contributed passionately to this community dictionary"
                        .tr,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: getTextSize(20)))
                .paddingOnly(bottom: getShortSide(10.0)),
            Expanded(child: Obx(() {
              return EasyTable<Buggy>(
                EasyTableModel<Buggy>(
                    rows: _wordsService.contributions.value,
                    columns: [
                      EasyTableColumn(
                        name: 'name'.tr,
                        stringValue: (row) => row.name,
                        weight: 4,
                        // width: Get.width * 0.4,
                        // resizable: true,
                      ),
                      EasyTableColumn(
                          name: 'words'.tr,
                          intValue: (row) => row.wa,
                          // width: Get.width * 0.15,
                          alignment: Alignment.center),
                      EasyTableColumn(
                          name: 'edition'.tr,
                          intValue: (row) => row.wm,
                          //width: Get.width * 0.15,
                          alignment: Alignment.center),
                      EasyTableColumn(
                          name: 'translations'.tr,
                          intValue: (row) => row.ta,
                          // width: Get.width * 0.15,
                          alignment: Alignment.center),
                      EasyTableColumn(
                          name: 'edition'.tr,
                          intValue: (row) => row.tm,
                          // width: Get.width * 0.15,
                          alignment: Alignment.center)
                    ]),
                columnsFit: true,
              );
            })),
            SizedBox(height: getShortSide(10)),
          ],
        ),
      ).paddingAll(10.0),
    );
  }
}
