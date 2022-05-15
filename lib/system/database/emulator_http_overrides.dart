import 'dart:io';

import 'package:tabwa_french/system/database/configs.dart';

class EmulatorHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  EmulatorHttpOverrides() {
    if (ON_EMULATOR) HttpOverrides.global = this;
  }
}
