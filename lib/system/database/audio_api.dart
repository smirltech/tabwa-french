import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tabwa_french/system/database/configs.dart';
import 'package:tabwa_french/system/helpers/log_cat.dart';
import 'package:http_parser/http_parser.dart';

class AudioApi {
  static final GetConnect _gc = GetConnect();

  static Future<dynamic> addAudio(
      String token, String file, Map<String, String> map) async {
    http.MultipartRequest req =
        http.MultipartRequest('POST', Uri.parse(ADD_AUDIO));
    req.files.add(
      await http.MultipartFile.fromPath(
        'audio',
        file,
        filename: file.split('/').last,
        contentType: MediaType('audio', 'aac'),
      ),
    );
    req.fields.addAll(map);

    logcat("req: ${req.fields.toString()}");
    File ff = File(file);
    logcat("ff : ${ff.lengthSync()}");

    return req.send();
/*    MultipartFile audio = MultipartFile(
      File(file).readAsBytesSync(),
      filename: file.split('/').last,
    );
    map['audio'] = audio;

    logcat("AudioApi, addAudio, map: ${map.toString()}");
    FormData data = FormData(map);
    return await _gc.post(ADD_AUDIO, data,
        headers: headers(token: token, contentType: 'multipart/form-data'));*/
  }
}
