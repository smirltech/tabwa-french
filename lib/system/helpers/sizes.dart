import 'package:flutter/material.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double screenShortSide;
  static late double defaultSize;
  static late double devicePixelRatio;
  static late Orientation orientation;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    screenShortSide = _mediaQueryData.size.shortestSide;
    orientation = _mediaQueryData.orientation;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
  }
}

double getAppropriateSize(double small, double medium, double large) {
  return isMobile()
      ? small
      : isTablet()
          ? medium
          : large;
}

bool isMobile() {
  return SizeConfig.screenWidth <= 640;
  //return SizeConfig.screenWidth < 850;
}

bool isTablet() {
  return SizeConfig.screenWidth < 1008 && SizeConfig.screenWidth > 640;
  // return SizeConfig.screenWidth < 1100 && SizeConfig.screenWidth >= 850;
}

bool isDesktop() {
  return SizeConfig.screenWidth >= 1008;
  //return SizeConfig.screenWidth >= 1100;
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  final rate = 1 / SizeConfig.devicePixelRatio;
  return (inputHeight / 812.0) * screenHeight * rate;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  final rate = 1 / SizeConfig.devicePixelRatio;
  return (inputWidth / 375.0) * screenWidth * rate;
}

// Get the proportionate side as per screen short size
double getShortSide(double inputSide) {
  double screenShortSide = SizeConfig.screenShortSide;
  // 375 is the layout width that designer use
  // logcat("devicePixelRatio: ${SizeConfig.devicePixelRatio}");
  // final rate = 1 / SizeConfig.devicePixelRatio;
  return (inputSide / 375.0) * screenShortSide;
}

// Get the proportionate side as per screen short size
double getTextSize(double inputSide) {
  double screenShortSide = SizeConfig.screenShortSide;
  // 375 is the layout width that designer use
  logcat("devicePixelRatio: ${SizeConfig.devicePixelRatio}");
  final rate = SizeConfig.devicePixelRatio;
  final multiplier = rate > 1.5
      ? 375
      : rate > 1
          ? 640
          : 750;
  return (inputSide / multiplier) * screenShortSide;
}
