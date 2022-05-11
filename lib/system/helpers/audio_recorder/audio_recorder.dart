import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/audio_controller.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';

import '../helpers.dart';
import 'components/sound_player.dart';
import 'components/sound_recorder.dart';

class AudioRecorder extends StatefulWidget {
  AudioRecorder(
      {Key? key,
      required this.section,
      required this.section_id,
      required this.textBody})
      : super(key: key);
  final String section;
  final int section_id;
  final String textBody;

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  final soundRecorder = SoundRecorder();
  final soundPlayer = SoundPlayer();
  late Timer _timer;
  String _timerText = '00:00';
  String fileSize = '0';

  @override
  void initState() {
    deleteCurrentAudioFile();
    super.initState();

    soundRecorder.init();
    soundPlayer.init();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
    _timer.cancel();
  }

  deleteCurrentAudioFile() async {
    final fdel = FilePath.deleteFile;
    logcat("current file deleted = $fdel");
  }

  timerToggle() {
    if (!_timer.isActive)
      _startTimer();
    else
      _endTimer();
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timerText =
            '${(_timer.tick ~/ 60).toString().padLeft(2, '0')}:${(_timer.tick % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  _endTimer() {
    _timer.cancel();
    // _timerText = '00:00';
  }

  @override
  void dispose() {
    soundRecorder.dispose();
    soundPlayer.dispose();
    deleteCurrentAudioFile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 20),
                    buildTextPreview(),
                    const Spacer(),
                    buildUpCounter(),
                    const Spacer(),
                    const SizedBox(height: 20),
                    buildRecordButton(),
                    const SizedBox(height: 20),
                    buildPlayButton(),
                    const SizedBox(height: 40),
                    buildActionButtons(),
                    const SizedBox(height: 20),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showFileSize() {
    return Text("File size: $fileSize");
  }

  Widget buildTextPreview() {
    return Card(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${widget.textBody}',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            )));
  }

  Widget buildUpCounter() {
    final isRecording = soundRecorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = _timerText;
    final subText = isRecording ? 'Press Stop'.tr : 'Press Start'.tr;
    return CircleAvatar(
        radius: 70,
        backgroundColor: Colors.white,
        child: CircleAvatar(
            radius: 67,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30, color: Colors.white),
                const SizedBox(height: 10),
                Text(text,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(subText,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ))));
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            minimumSize: const Size(150, 50),
          ),
          child: Text('cancel'.tr,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            Get.find<AudioController>().addAudio({
              "section": widget.section,
              "section_id": widget.section_id.toString(),
            }, () {
              Get.back();
              toastItSuccess(msg: 'recorded successfully'.tr);
            });
            //  Get.back();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            minimumSize: const Size(150, 50),
          ),
          child: Text('confirm'.tr,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  ElevatedButton buildRecordButton() {
    final isRecording = soundRecorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP'.tr : 'START'.tr;
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          primary: primary,
          onPrimary: onPrimary,
        ),
        onPressed: soundPlayer.isPlaying
            ? null
            : () async {
                await soundRecorder.toggleRecording();
                File file = File(await FilePath.pathToSaveAudio);
                if (file.existsSync()) {
                  double ff = file.lengthSync() / 1024;
                  fileSize = ff.toStringAsFixed(2) + " KB";
                  log('File size: $fileSize');
                }
                setState(() {});
                timerToggle();
              },
        icon: Icon(icon),
        label: Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
  }

  ElevatedButton buildPlayButton() {
    final isPlaying = soundPlayer.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying
        ? 'stop playing'.tr.toUpperCase()
        : 'start playing'.tr.toUpperCase();
    final primary = isPlaying ? Colors.red : Colors.white;
    final onPrimary = isPlaying ? Colors.white : Colors.black;
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          primary: primary,
          onPrimary: onPrimary,
        ),
        onPressed: soundRecorder.isRecording
            ? null
            : () async {
                // final isRecording = soundRecorder.toggleRecording();
                await soundPlayer.togglePlaying(whenFinished: () {
                  setState(() {});
                });
                File file = File(await FilePath.pathToSaveAudio);
                if (file.existsSync())
                  log("File pathing: " + file.path);
                else
                  log("File not found");
                setState(() {});
              },
        icon: Icon(icon),
        label: Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
  }
}
