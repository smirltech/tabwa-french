import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../system/configs/configs.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('privacy policy'.tr),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Text(PRIVACY_STATEMENT.tr, style: const TextStyle(fontSize: 14)),
        )),
      ),
    );
  }
}
