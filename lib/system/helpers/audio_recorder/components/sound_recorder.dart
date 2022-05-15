import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePath {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static get pathToSaveAudio async => await localPath + "/audio_example.aac";

  static get fileExists async => await File(await pathToSaveAudio).exists();

  static get deleteFile async {
    if (await fileExists) {
      return await File(await pathToSaveAudio).delete();
    } else {
      return false;
    }
  }
}

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;

  bool get isRecording => _audioRecorder!.isRecording;

  // bool get isPlaying => _audioRecorder!.;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
  }

  void dispose() {
    if (_isRecorderInitialized) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  Future _record() async {
    await _audioRecorder!.startRecorder(
      toFile: await FilePath.pathToSaveAudio,
      codec: Codec.aacMP4,
    );
  }

  Future _stop() async {
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
