import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabwa_french/app/views/proverb/plateforms/desktop_screen.dart';
import 'package:tabwa_french/app/views/proverb/plateforms/mobile_screen.dart';
import 'package:tabwa_french/system/helpers/sizes.dart';


class ProverbScreen extends StatefulWidget {
  const ProverbScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProverbScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProverbScreen> {

  @override
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
