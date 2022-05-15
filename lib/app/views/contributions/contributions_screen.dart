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
                    style: TextStyle(fontSize: getTextSize(20)))
                .paddingOnly(bottom: getShortSide(10.0)),
            SizedBox(height: getShortSide(20)),
            Expanded(child: Obx(() {
              return EasyTable<Buggy>(
                _wordsService.contributionModel.value,
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
