import 'package:get/get.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

import '../models/word.dart';

class WordsController extends GetxController {
  var words = <Word>[].obs;

  @override
  void onInit() {
    getAll();
    super.onInit();
  }

  void getAll() async {
    //logcat("You are in WordsController");
    words.value = await Word.getAll();
  }
}
