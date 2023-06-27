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
  //final WordsService _wordsService = Get.find<WordsService>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).hintColor),
        title: Text('contributions'.tr,
            style: TextStyle(color: Theme.of(context).hintColor)),
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
              return ListView.builder(
                  itemCount: WordsService.of.contributions.length,
                  itemBuilder: (_, index) {
                    Buggy buggy = WordsService.of.contributions[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text((index + 1).toString()),
                      ),
                      title: Text(buggy.name),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(text: '${'words'.tr} : ', children: [
                                    TextSpan(
                                        text: buggy.wa.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ]),
                                ),
                                Text.rich(
                                  TextSpan(text: '${'edition'.tr} : ', children: [
                                    TextSpan(
                                        text: buggy.wm.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ]),
                                ),
                              ],
                            ).paddingOnly(right: 5),
                          ),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(text: '${'translations'.tr} : ', children: [
                                    TextSpan(
                                        text: buggy.ta.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ]),
                                ),
                                Text.rich(
                                  TextSpan(text: '${'edition'.tr} : ', children: [
                                    TextSpan(
                                        text: buggy.tm.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ]),
                                ),
                              ],
                            ).paddingOnly(left: 5),
                          ),
                        ],
                      ),
                    ).paddingOnly(bottom: 10);
                  });
            })),
            /*Expanded(child: Obx(() {
              return EasyTable<Buggy>(
                EasyTableModel<Buggy>(
                    rows: WordsService.of.contributions.value,
                    columns: [
                      EasyTableColumn(
                        name: 'name'.tr,
                        stringValue: (row) => row.name,
                        //  weight: 4,
                        // width: Get.width * 0.4,
                        // resizable: true,
                      ),
                      EasyTableColumn(
                          name: 'words'.tr,
                          intValue: (row) => row.wa,
                          // width: Get.width * 0.15,
                          cellAlignment: Alignment.center),
                      EasyTableColumn(
                          name: 'edition'.tr,
                          intValue: (row) => row.wm,
                          //width: Get.width * 0.15,
                          cellAlignment: Alignment.center),
                      EasyTableColumn(
                          name: 'translations'.tr,
                          intValue: (row) => row.ta,
                          // width: Get.width * 0.15,
                          cellAlignment: Alignment.center),
                      EasyTableColumn(
                          name: 'edition'.tr,
                          intValue: (row) => row.tm,
                          // width: Get.width * 0.15,
                          cellAlignment: Alignment.center)
                    ]),
                //  columnsFit: true,
              );
            })),*/
            SizedBox(height: getShortSide(10)),
          ],
        ),
      ).paddingAll(10.0),
    );
  }
}
