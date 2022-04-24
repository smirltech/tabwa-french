import 'dart:convert';

import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/app/models/translation.dart';
import 'package:tabwa_french/system/database/words_api.dart';

import '../../system/helpers/log_cat.dart';

class Word {
  late int id;
  late String word;
  late String categorie;
  late String created_at;
  late String updated_at;
  late String user;
  late String updater;
  List<Translation> translations = <Translation>[];

  Word({
    this.id = 0,
    this.word = '',
    this.categorie = '',
    this.created_at = '',
    this.updated_at = '',
    this.user = '',
    this.updater = '',
    this.translations = const [],
  });

  @override
  String toString() {
    return 'Word{id: $id, word: $word, categorie: $categorie, created_at: $created_at, updated_at: $updated_at, user: $user, updater: $updater, translations: $translations}';
  }

  factory Word.fromMap(dynamic map) {
    // if (null == map) return null;
    // var temp;
    var n =
        (map['user'] != null && map['user'] is Map) ? map['user']['name'] : '';
    var u = (map['updater'] != null && map['updater'] is Map)
        ? map['updater']['name']
        : '';
    return Word(
      id: int.parse("${map['id']}"),
      word: map['word'].toString(),
      categorie: map['categorie'].toString(),
      created_at: map['created_at'].toString(),
      updated_at: map['updated_at'].toString(),
      user: n.toString(),
      updater: u.toString(),
      translations: Translation.listFromMap(map['translations']),
    );
  }

  static List<Word> listFromJson(String string) {
    List<Word> _l = [];
    //log(string);
    try {
      List ll = jsonDecode(string);
      ll.forEach((e) {
        _l.add(Word.fromMap(e));
      });
      return _l;
    } catch (ew) {
      logcat("WORD-listFromJson: ${ew.toString()}");
      return _l;
    }
  }

  static List<Word> listFromMap(List list) {
    List<Word> _l = [];
    //log(string);
    try {
      List ll = list;
      ll.forEach((e) {
        _l.add(Word.fromMap(e));
      });
      return _l;
    } catch (ew) {
      logcat("WORD-listFromMap: ${ew.toString()}");
      return _l;
    }
  }

  static List<Word>? listFromCategorie(
      List<Word> list, String categorie, String searchKey) {
    if (categorie == null || categorie.length == 0) {
      return <Word>[];
    }
    if (searchKey == null || searchKey.length == 0) {
      return <Word>[];
    }
    List<Word> _l = [];
    list.forEach((wr) {
      if (wr.categorie == categorie) {
        if (wr.word.toLowerCase().contains(searchKey.toLowerCase())) {
          _l.add(wr);
        }
      }
    });
    return _l;
  }

  static Future<List<Word>> getAll() async {
    List<Word> vv = [];
    Response ddd = await WordsApi.getAll();
    //logcat("DODODOD : " + ddd.body.toString());
    // logcat(ddd.body['data'].toString());
    try {
      if (ddd.body != null) vv = Word.listFromMap(ddd.body?['data']);
    } on Exception catch (e) {
      logcat("WORD GETALL => " + e.toString());
    }
    if (vv.isNotEmpty) {
      vv.sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));
      GetStorage().write('words', ddd.body?['data']);
    } else {
      vv = Word.listFromMap(GetStorage().read('words'));
      vv.sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));
    }

    return vv;
  }

  static Future<Word?> add(Map<String, dynamic> word) async {
    // logcat(word.toString());
    String token = GetStorage().read("token");
    Response ddd = await WordsApi.add(token, word);
    // logcat(ddd.body.toString());
    // logcat(ddd.body['data'].toString());

    return null;
  }

  static Future<Word?> edit(Map<String, dynamic> word, int id) async {
    // logcat(word.toString());
    String token = GetStorage().read("token");
    Response ddd = await WordsApi.edit(token, word, id);
    // logcat(ddd.body.toString());
    // logcat(ddd.body['data'].toString());

    return null;
  }
}
