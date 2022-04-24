import 'dart:convert';

import 'dart:developer';

import 'package:get/get.dart';

import '../../system/database/types_api.dart';
import '../../system/helpers/log_cat.dart';

class Type {
  int id;
  String type;
  String abbrev;

  Type({
    this.id = 0,
    this.type = '',
    this.abbrev = '',
  });

  @override
  String toString() {
    return 'Type{id: $id, type: $type, abbrev: $abbrev}';
  }

  factory Type.fromMap(dynamic map) {
    // if (null == map) return null;
    // var temp;
    return Type(
      id: int.parse("${map['id']}"),
      type: map['type'].toString(),
      abbrev: map['abbrev'].toString(),
    );
  }

  static List<Type> listFromJson(String string) {
    List<Type> _l = [];
    List ll = jsonDecode(string);
    ll.forEach((e) {
      _l.add(Type.fromMap(e));
    });
    return _l;
  }

  static List<Type> listFromMap(List list) {
    List<Type> _l = [];
    List ll = list;
    ll.forEach((e) {
      _l.add(Type.fromMap(e));
    });
    return _l;
  }

  static Future<List<Type>> getAll() async {
    List<Type> vv = [];
    Response ddd = await TypesApi.getAll();
    //logcat(ddd.body.toString());
    // logcat(ddd.body['data'].toString());
    try {
      if (ddd.body != null) vv = Type.listFromMap(ddd.body['data']);
    } on Exception catch (e) {}
    vv.sort((a, b) => a.type.toLowerCase().compareTo(b.type.toLowerCase()));

    return vv;
  }
}
