import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tabwa_french/app/views/home/plateforms/desktop_screen.dart';
import 'package:tabwa_french/app/views/home/plateforms/mobile_screen.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  // final ConnectivityController connectivityController =
  //     Get.find<ConnectivityController>();
  // final WordsService _wordsService = Get.find<WordsService>();
  // final AuthController _authController = Get.find<AuthController>();

  initState() {
    super.initState();

/*    final newVersion = VersionChecker(
      iOSId: 'org.smirl.tabwa_french',
      androidId: 'org.smirl.tabwa_french',
    );

    const simpleBehavior = false;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }*/
  }

/*
  basicStatusCheck(VersionChecker newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(VersionChecker newVersion) async {
    final status = await newVersion.getVersionStatus();

    if (status != null && status.canUpdate) {
      final releaseNotes = status.releaseNotes!.replaceAll(";", ";\n");
      // debugPrint(status.releaseNotes);
      // debugPrint(status.appStoreLink);
      // debugPrint(status.localVersion);
      // debugPrint(status.storeVersion);
      // debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        //  allowDismissal: false,
        dialogTitle: "Nouvelle version disponible : ${status.storeVersion}",
        dialogText: "NOTES:\n${releaseNotes}",
      );
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return isMobile() ? MobileScreen() : DesktopScreen();
  }
}
