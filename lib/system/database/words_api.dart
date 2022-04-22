import 'package:get/get.dart';
import 'package:tabwa_french/system/database/configs.dart';

import '../../app/models/word.dart';

class WordsApi {
  static final GetConnect _gc = GetConnect();

  static Future<dynamic> getAll() => _gc.get(WORDS_URL);

  static Future<dynamic> add(String token, Map<String, dynamic> word) =>
      _gc.post(WORDS_URL, word, headers: headers(token: token));
}
