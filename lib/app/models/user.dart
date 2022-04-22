import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/system/database/auth_api.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';

import '../../system/helpers/log_cat.dart';

class User {
  int? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }

  static Future<User?> login(Map<String, dynamic> creds) async {
    Response response = await AuthApi.login(creds);
    if (response.body['statusCode'] == 200) {
      // logcat('login response: ${response.body['data']}');
      snackItOld(response.body['message']);
      GetStorage().write('token', response.body['data']['token']);

      User u = User.fromMap(response.body['data']);
      GetStorage().write('user', u.toMap());
      return u;
    } else {
      //  logcat('User login failed');
      snackItOld(response.body['message']);
      return null;
    }
  }

  static Future<User?> register(Map<String, dynamic> user) async {
    Response response = await AuthApi.register(user);
    //logcat('register response 0 : ${response.body}');
    if (response.body['statusCode'] == 200) {
      // logcat('register response: ${response.body['data']}');
      snackItOld(response.body['message']);
      GetStorage().write('token', response.body['data']['token']);

      User u = User.fromMap(response.body['data']);
      GetStorage().write('user', u.toMap());
      return u;
    } else {
      // logcat('User registration failed');
      //snackItOld("ERROR : ${response.body['data']}");
      snackItOld(
          "ERROR : soit l'email est pris, soit les mots de passe ne sont pas identiques");
      return null;
    }
  }
}
