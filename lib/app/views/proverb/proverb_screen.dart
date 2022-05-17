import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabwa_french/app/controllers/auth_controller.dart';
import 'package:tabwa_french/app/services/words_service.dart';
import 'package:tabwa_french/app/views/proverb/plateforms/desktop_screen.dart';
import 'package:tabwa_french/app/views/proverb/plateforms/mobile_screen.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';

import '../../controllers/connectivity_controller.dart';
import '../../models/translation.dart';
import '../../models/word.dart';
import '../../routes/routes.dart';

class ProverbScreen extends StatefulWidget {
  const ProverbScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProverbScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProverbScreen> {
  final ConnectivityController connectivityController =
      Get.find<ConnectivityController>();
  final WordsService _wordsService = Get.find<WordsService>();
  final AuthController _authController = Get.find<AuthController>();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return isMobile() ? MobileScreen() : DesktopScreen();
    //return GetPlatform.isMobile ? MobileScreen() : DesktopScreen();
  }
}
