import 'dart:developer';

import '../configs/configs.dart';

void logcat(String message) {
  if (DEBUG_MODE == true) {
    log(message);
  }
}

void dialogcat(String message) {
  if (DEBUG_MODE == true) {
    log(message);
  }
}
