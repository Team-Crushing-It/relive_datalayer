import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class ReliveDataLayer {
  Future<dynamic> upload(
      File file, StreamController<String> progressStreamController) async {
    Dio dio = Dio();
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      Response response = await dio.post(
        "https://quizzical-darkness-42347.pktriot.net/api/v0/add",
        data: formData,
        onSendProgress: (received, total) {
          if (total != -1) {
            String progress = '${(received / total * 100).toStringAsFixed(0)}%';
            progressStreamController.add(progress);
            print('${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );
    progressStreamController.close();
    Map<String, dynamic> ipfsFileData = jsonDecode(response.data);
    ipfsFileData["share link"] =
        "https://relive-sharelink.herokuapp.com/preview?cid=${ipfsFileData["Hash"]}";
    return jsonDecode(response.data);
    } on DioError catch (e) {
      if(e.response != null){
      return e.response?.data;
      }
    }
  }

  
}
