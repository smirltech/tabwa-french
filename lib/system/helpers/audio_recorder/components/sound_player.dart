import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart' show Level;
import 'package:http/http.dart' as http;
import 'package:tabwa_french/system/helpers/audio_recorder/components/sound_recorder.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';

//final pathToReadAudio = "audio_example.aac";

class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;

  bool get isPlaying => _audioPlayer!.isPlaying;

  Future init() async {
    _audioPlayer = FlutterSoundPlayer(logLevel: Level.error);
    await _audioPlayer!.openAudioSession();
  }

  void dispose() {
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
    await _audioPlayer!.startPlayer(
      fromURI: await FilePath.pathToSaveAudio,
      // fromURI: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      //  codec: Codec.mp3,
      whenFinished: whenFinished,
    );
  }

  Future playFromNet(String soundurl,
      {required VoidCallback whenFinished, required VoidCallback error}) async {
    http.Response ress = await http.get(Uri.parse(soundurl));
    if (ress.statusCode != 200) {
      error();
      return;
    } else {
      // whenFinished();
      toastItInfo(msg: 'playing'.tr);
    }
    await _audioPlayer!.startPlayer(
      // fromURI: await FilePath.pathToSaveAudio,
      fromURI: soundurl,
      codec: Codec.aacMP4,
      whenFinished: whenFinished,
    );
  }

  getAudioPath() async {
    return _audioPlayer!.getResourcePath();
  }

  Future _stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if (_audioPlayer!.isStopped) {
      await _play(whenFinished);
    } else {
      await _stop();
    }
  }
}
