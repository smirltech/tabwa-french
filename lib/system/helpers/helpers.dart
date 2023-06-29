import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../themes/theme_setting.dart';

bool emailValid(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

bool codeValid(String code) =>
    RegExp(r"[a-zA-Z0-9]+\-[a-zA-Z0-9]+").hasMatch(code);

///
/// Loop through this callback at the spacified interval
/// Pass in the function to be called back
///
Future<void> loop(Function callback,
    {Duration duration = const Duration(seconds: 1)}) async {
  while (true) {
    callback();
    await Future.delayed(duration);
  }
}

snackIt(
  String message, {
  String title = "hey",
}) {
  Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
}

snackItOld(
  String message, {
  String title = "hey",
  Color? backgroundColor,
}) {
  SnackBar sb = SnackBar(
    backgroundColor: backgroundColor,
    content: Text(message),
  );
  try {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(sb);
    }
  } on Exception catch (e) {}
}

snackItOldSuccess(
  String message, {
  String title = "hey",
}) {
  snackItOld(message, title: title, backgroundColor: Colors.green);
}

snackItOldError(
  String message, {
  String title = "hey",
}) {
  snackItOld(message, title: title, backgroundColor: Colors.red);
}

snackItOldWarning(
  String message, {
  String title = "hey",
}) {
  snackItOld(message, title: title, backgroundColor: Colors.orange);
}

snackItOldInfo(
  String message, {
  String title = "hey",
}) {
  snackItOld(message, title: title, backgroundColor: Colors.teal);
}

/// using fluttertoast package
toastIt(
    {required String msg,
    gravity = ToastGravity.BOTTOM,
    backgroundColor = Colors.black,
    textColor = Colors.white}) {
  GetPlatform.isDesktop
      ? snackItOld(msg, backgroundColor: backgroundColor)
      : Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: gravity,
          timeInSecForIosWeb: 1,
          backgroundColor: backgroundColor,
          textColor: textColor,
          fontSize: 12.0,
        );
}

toastItError({
  required String msg,
  gravity = ToastGravity.BOTTOM,
}) =>
    GetPlatform.isDesktop
        ? snackItOldError(msg)
        : toastIt(msg: msg, backgroundColor: Colors.red);

toastItSuccess({
  required String msg,
  gravity = ToastGravity.BOTTOM,
}) =>
    GetPlatform.isDesktop
        ? snackItOldSuccess(msg)
        : toastIt(msg: msg, backgroundColor: Colors.green);

toastItWarning({
  required String msg,
  gravity = ToastGravity.BOTTOM,
}) =>
    GetPlatform.isDesktop
        ? snackItOldWarning(msg)
        : toastIt(msg: msg, backgroundColor: Colors.orange);

toastItInfo({
  required String msg,
  gravity = ToastGravity.BOTTOM,
}) =>
    GetPlatform.isDesktop
        ? snackItOldInfo(msg)
        : toastIt(msg: msg, backgroundColor: Colors.teal);

InputDecoration roundedTextInputDecoration(
    {String? hintText, String? labelText, Color? borderColor}) {

  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
     borderSide:  BorderSide(color: borderColor ?? Colors.transparent),
    ),
  );
}

void showCredit(
    BuildContext context, String title, String adder, String editor) {
  Get.snackbar(
    title,
    '',
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: ThemeSetting.small,
              ),
              children: [
                TextSpan(
                    text: 'added by'.tr + ': ',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: adder,
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: ThemeSetting.small,
              ),
              children: [
                TextSpan(
                    text: 'last modified by'.tr + ': ',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: editor,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    snackPosition: SnackPosition.BOTTOM,
  );
}
