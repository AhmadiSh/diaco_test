import 'package:dio/dio.dart';

class APICaller {
  final Dio _dio = Dio();

  callAllMessage(int count) async {
    var response = await _dio.get('https://front-challenge.devliom.ir?',
        queryParameters: {'from': count});
    return response;
  }

  createMessage({required username, required text, String? filePath}) async {
    var response = await _dio.post('https://front-challenge.devliom.ir?',
        data: {'username': username, 'text': text, 'file': filePath});
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

  uploadMessage({required String filePath}) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath),
    });
    var response = await _dio.post('https://front-challenge.devliom.ir/upload',
        data: formData);
    return response;
  }
}
