import 'dart:convert';

import 'dart:developer';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/app/models/type.dart';
import 'package:tabwa_french/system/database/translations_api.dart';

class Translation {
  int id;
  String translation;
  String example;
  String example_translation;

  String created_at;
  String updated_at;
  String user;
  String updater;
  String type;
  String type_id;

  Translation({
    this.id = 0,
    this.translation = '',
    this.example = '',
    this.example_translation = '',
    this.created_at = '',
    this.updated_at = '',
    this.user = '',
    this.updater = '',
    this.type = '',
    this.type_id = '',
  });

  factory Translation.fromMap(dynamic map) {
    //  if (null == map) return null;
    // var temp;
    var t = map['type'] is Map ? map['type']['type'] : '';
    var ti = map['type'] is Map ? map['type']['id'] : '';
    var n =
        (map['user'] != null && map['user'] is Map) ? map['user']['name'] : '';
    var u = (map['updater'] != null && map['updater'] is Map)
        ? map['updater']['name']
        : '';

    return Translation(
      id: int.parse("${map['id']}"),
      translation: map['translation'].toString(),
      example: map['example'].toString(),
      example_translation: map['example_translation'].toString(),
      created_at: map['created_at'].toString(),
      updated_at: map['updated_at'].toString(),
      user: n.toString(),
      updater: u.toString(),
      type: t.toString(),
      type_id: ti.toString(),
    );
  }

  static List<Translation> listFromJson(String string) {
    List<Translation> _l = [];
    List ll = jsonDecode(string);
    ll.forEach((e) {
      _l.add(Translation.fromMap(e));
    });
    return _l;
  }

  static List<Translation> listFromMap(List list) {
    List<Translation> _l = <Translation>[];
    List ll = list;
    ll.forEach((e) {
      _l.add(Translation.fromMap(e));
    });
    return _l;
  }

  static Future<Translation?> add(Map<String, dynamic> translation) async {
    // logcat(word.toString());
    String token = GetStorage().read("token");
    Response ddd = await TranslationsApi.add(token, translation);
    // logcat(ddd.body.toString());
    // logcat(ddd.body['data'].toString());

    return null;
  }

  static Future<Translation?> edit(
      Map<String, dynamic> translation, int id) async {
    // logcat(word.toString());
    String token = GetStorage().read("token");
    Response ddd = await TranslationsApi.edit(token, translation, id);
    // logcat(ddd.body.toString());
    // logcat(ddd.body['data'].toString());

    return null;
  }
}
