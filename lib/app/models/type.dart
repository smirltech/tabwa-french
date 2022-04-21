import 'dart:convert';

import 'dart:developer';

class Type {
  int id;
  String type;
  String abbrev;

  Type({
    this.id = 0,
    this.type = '',
    this.abbrev = '',
  });

  factory Type.fromMap(dynamic map) {
    // if (null == map) return null;
    // var temp;
    return Type(
      id: int.parse("${map['id']}"),
      type: map['type'].toString(),
      abbrev: map['abbrev'].toString(),
    );
  }

  static List<Type> listFromMap(String string) {
    List<Type> _l = [];
    List ll = jsonDecode(string);
    ll.forEach((e) {
      _l.add(Type.fromMap(e));
    });
    return _l;
  }
}
