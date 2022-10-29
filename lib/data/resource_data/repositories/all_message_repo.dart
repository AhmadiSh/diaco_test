import 'package:diaco_test/data/models/allMessage.dart';
import 'package:diaco_test/data/resource_data/remote/api_call.dart';
import 'package:dio/dio.dart';

class AllMessageRepository {
  final APICaller _apiCaller = APICaller();
  AllMessages? dataModel;

  Future<AllMessages?> fetchCallAllMessage(int count) async {
    Response response = await _apiCaller.callAllMessage(count);
    dataModel = AllMessages.fromJson(response.data);

    return dataModel;
  }

  Future<dynamic> createMessage(
      {required username, required text}) async {
    Response response = await _apiCaller.createMessage(
        username: username, text: text);
    dataModel = AllMessages.fromJson(response.data);
    return dataModel;
  }

  Future<dynamic> updateMessage({required int id, required String text}) async {
    Response response = await _apiCaller.updateMessage(id: id, text: text);
    dataModel = AllMessages.fromJson(response.data);
    return dataModel;
  }

  Future<dynamic> deleteMessage({required int id}) async {
    Response response = await _apiCaller.deleteMessage(id: id);
    dataModel = AllMessages.fromJson(response.data);
    return dataModel;
  }

  Future<dynamic> uploadMessage({required filePath}) async {
    Response response = await _apiCaller.uploadMessage(filePath: filePath);
    dataModel = AllMessages.fromJson(response.data);
    return dataModel;
  }
}
