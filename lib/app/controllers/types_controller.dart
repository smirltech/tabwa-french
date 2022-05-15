import 'package:get/get.dart';
import 'package:tabwa_french/app/models/type.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

import '../../system/helpers/helpers.dart';

class TypesController extends GetxController {
  var types = <Type>[].obs;

  void getAll() async {
    if (types.isEmpty) types.value = await Type.getAll();
    // logcat("types: ${types.value.length}");
  }

  @override
  void onInit() {
    getAll();
    loop(getAll, duration: const Duration(seconds: 5));
    super.onInit();
  }
}
