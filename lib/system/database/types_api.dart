import 'package:get/get.dart';
import 'package:tabwa_french/system/database/configs.dart';

import '../../app/models/word.dart';

class TypesApi {
  static final GetConnect _gc = GetConnect();

  static Future<dynamic> getAll() => _gc.get(TYPES_URL);
}
