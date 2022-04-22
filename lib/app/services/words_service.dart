import 'package:get/get.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import '../../system/helpers/log_cat.dart';
import '../models/word.dart';

class WordsService extends GetxService {
  var words = <Word>[].obs;

  @override
  void onInit() {
    // getAll();
    loop(getAll, duration: const Duration(seconds: 3));
    super.onInit();
  }

  void getAll() async {
    // logcat("You are in WordsService");
    words.value = await Word.getAll();
  }
}
