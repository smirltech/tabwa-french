import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/system/database/audio_api.dart';
import 'package:tabwa_french/system/helpers/audio_recorder/components/sound_recorder.dart';

import '../../system/helpers/log_cat.dart';

class AudioController extends GetxController {
  static AudioController get of=> Get.find<AudioController>();
  static AudioController init()=> Get.put<AudioController>(AudioController());
  void addAudio(Map<String, String> map, VoidCallback callback) async {
    String token = GetStorage().read("token");
    String f = await FilePath.pathToSaveAudio;
    logcat("AudioController, addAudio, file path: ${f}");
    http.StreamedResponse ddd = await AudioApi.addAudio(token, f, map);
    logcat("ddd: ${ddd.statusCode}, ${ddd.toString()}");
    if (ddd.statusCode == 200) {
      callback();
    } else {
      Get.snackbar(
        "Error",
        "Error adding audio",
      );
    }
  }
}
