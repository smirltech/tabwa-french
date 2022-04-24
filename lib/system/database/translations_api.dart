import 'package:get/get.dart';
import 'package:tabwa_french/system/database/configs.dart';

import '../../app/models/word.dart';

class TranslationsApi {
  static final GetConnect _gc = GetConnect();

  static Future<dynamic> getAll() => _gc.get(TRANSLATIONS_URL);

  static Future<dynamic> add(String token, Map<String, dynamic> translation) =>
      _gc.post(TRANSLATIONS_URL, translation, headers: headers(token: token));

  static Future<dynamic> edit(
          String token, Map<String, dynamic> translation, int id) =>
      _gc.put(TRANSLATIONS_URL + "/$id", translation,
          headers: headers(token: token));
}
