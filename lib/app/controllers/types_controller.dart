import 'package:get/get.dart';
import 'package:tabwa_french/app/models/type.dart';

class TypesController extends GetxController {
  var types = <Type>[].obs;

  void getAll() async {
    types.value = await Type.getAll();
  }

  @override
  void onInit() {
    getAll();
    super.onInit();
  }
}
