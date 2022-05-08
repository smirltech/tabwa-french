import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
}) {
  SnackBar sb = SnackBar(
    content: Text(message),
  );
  try {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(sb);
    }
  } on Exception catch (e) {}
}

/// using fluttertoast package
toastIt(
    {required String msg,
    gravity = ToastGravity.BOTTOM,
    backgroundColor = Colors.black,
    textColor = Colors.white}) {
  Fluttertoast.showToast(
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
    toastIt(msg: msg, backgroundColor: Colors.red);

toastItSuccess({
  required String msg,
  gravity = ToastGravity.BOTTOM,
}) =>
    toastIt(msg: msg, backgroundColor: Colors.green);

toastItWarning({
  required String msg,
  gravity = ToastGravity.BOTTOM,
}) =>
    toastIt(msg: msg, backgroundColor: Colors.orange);

toastItInfo({
  required String msg,
  gravity = ToastGravity.BOTTOM,
}) =>
    toastIt(msg: msg, backgroundColor: Colors.teal);

InputDecoration roundedTextInputDecoration(
    {String? hintText, String? labelText}) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
