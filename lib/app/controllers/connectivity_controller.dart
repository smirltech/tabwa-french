import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../system/helpers/log_cat.dart';

class ConnectivityController extends GetxController {
  late StreamSubscription<ConnectivityResult> _subscription;
  var connectivityResult = Rxn<ConnectivityResult>();

  @override
  void onInit() {
    super.onInit();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      logcat('Connectivity change: ${result.name}');
      connectivityResult.value = result;
    });
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
