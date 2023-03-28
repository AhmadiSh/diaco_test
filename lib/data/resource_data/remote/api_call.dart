
import 'dart:io';

import 'package:dio/dio.dart';

class APICaller {
  final Dio _dio = Dio();

  callAllMessage(int count) async {
    var response = await _dio.get('https://front-challenge.devliom.ir?',
        queryParameters: {'from': count});
    return response;
  }

  createMessage({required username, required text, String? link}) async {
    var response = await _dio.post('https://front-challenge.devliom.ir?',
        data: {'username': username, 'text': text, 'link': link});
    return response;
  }

  updateMessage({required id, required text}) async {
    FormData formData = FormData.fromMap({
      "id": id,
      "text": text,
    });
    var response =
        await _dio.post('https://front-challenge.devliom.ir/update?', data: {
      'id': id,
      'text': text,
    });
    return response;
  }

  deleteMessage({required id}) async {
    var response =
        await _dio.post('https://front-challenge.devliom.ir/delete?', data: {
      'id': id,
    });
    return response;
  }

  uploadMessage({required File file}) async {
    FormData formData = FormData.fromMap({
      "file": file,
    });
    var response = await _dio.post('https://front-challenge.devliom.ir/upload',
        data: formData);
    return response;
  }
}
