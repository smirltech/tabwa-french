import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../system/helpers/sizes.dart';
import '../../../../../../system/themes/theme_setting.dart';
import '../../../../../models/translation.dart';
import '../../../../../models/word.dart';
import '../../../../../routes/routes.dart';
import '../../../../../services/words_service.dart';

class ItemCard extends StatelessWidget {
  ItemCard({Key? key, required this.word}) : super(key: key) {
    _translations = word.translations;
    _traas = [];
    if (_translations.isNotEmpty) {
      _traas =
          _translations.map((t) => "[${t.type_ab}] ${t.translation}").toList();
    }
  }

  final Word word;
  late List<Translation> _translations;
  late List<String> _traas;

  @override
  Widget build(BuildContext context) {
    return Card(
       elevation: 0.2,
      child: InkWell(
        onTap: () {
          WordsService.of.setActiveWord(word);
          Get.toNamed(Routes.showWord);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word.word,
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold,
                fontSize: ThemeSetting.large,
              ),
            ),
            Wrap(
              children: [
                ..._traas.map(
                  (tra) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    color: Theme.of(context).highlightColor,
                    child: Text(
                      tra,
                      style: GoogleFonts.oswald(
                        fontSize: ThemeSetting.big,
                      ),
                    ),
                  ).paddingSymmetric(
                      horizontal: getShortSide(2), vertical: getShortSide(2)),
                ),
              ],
            ),
          ],
        ).paddingAll(getShortSide(5.0)),
      ),
    );
  }
}
