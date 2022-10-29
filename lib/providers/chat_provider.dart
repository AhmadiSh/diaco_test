import 'dart:io';

import 'package:diaco_test/data/models/allMessage.dart';
import 'package:diaco_test/data/models/message.dart';
import 'package:diaco_test/data/resource_data/repositories/all_message_repo.dart';
import 'package:diaco_test/data/resource_data/response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class ChatProvider extends ChangeNotifier {
  AllMessages? allMessages;

  final AllMessageRepository _repository = AllMessageRepository();
  late ResponseModel responseModel;
  TextEditingController chatController = TextEditingController();
  File? file;
  List<Message> messages = [];
  bool isEdit = false;
  int idEdit = -1;
  bool uploadState = false;
  bool hasText = false;
  bool selectFile = false;
  final count = 35;

  ChatProvider() {
    getAllMessages(count);
  }

  //ui update for icon send
  checkTextController() {
    chatController.text.isEmpty ? hasText = false : hasText = true;
    notifyListeners();
  }
  //for update a message
  changeText(String text, int id) {
    chatController.text = text;
    isEdit = true;
    idEdit = id;
    hasText = true;
    notifyListeners();
  }
  initText() {
    isEdit = false;
    hasText = false;
    notifyListeners();
  }

  changeStateUploadFile(){
    uploadState=false;
    notifyListeners();
  }
  Future pickImage() async {
    selectFile = !selectFile;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      file = File(image.path);
      chatController.text = file!.path.toString();
      checkTextController();
      uploadState = true;
      notifyListeners();
    } on PlatformException catch (e) {
      notifyListeners();
    }
  }



  Future<dynamic> getAllMessages(count) async {
    responseModel = ResponseModel.loading("Loading...");
    try {
      allMessages = await _repository.fetchCallAllMessage(count);
      if (allMessages!.status == true) {
        for (int i = 0; i < allMessages!.data!.length; i++) {
          messages.addAll([Message.fromJson(allMessages!.data![i])]);
        }
        notifyListeners();
      }
      responseModel = ResponseModel.completed(allMessages!);
      notifyListeners();
    } catch (e) {
      responseModel = ResponseModel.failed("check your connection.");
      notifyListeners();
    }
  }



  sendMessage({required username, required text}) async {
    try {
      AllMessages _allMessages;
      _allMessages = await _repository.createMessage(
          username: username, text: text);

      if (_allMessages.status == true) {
        Message message = Message(
            userName: username, text: text, file: file);
        messages.add(message);
        notifyListeners();
      }
    } catch (e) {
      return e;
    }
  }



  updateMessage(String text, int id) async {
    try {
      AllMessages response =
          await _repository.updateMessage(id: id, text: chatController.text);
      if (response.status == true) {
        for (var element in messages) {
          if (element.id == id) {
            element.text = text;
            print(element.text);
            notifyListeners();
          }
        }
      }
    } catch (e) {
      return e;
    }
  }

  deleteMessage(int id) async {
    try {
      AllMessages allMessages = await _repository.deleteMessage(id: id);
      if (allMessages.status == true) {
        for (var element in messages) {
          if (element.id == id) {
            messages.remove(element);
            notifyListeners();
          }
        }
      }

      await getAllMessages(count);
      notifyListeners();
    } catch (e) {
      return e;
    }
  }

  uploadMessage(File file, {required username}) async {
    try {
      AllMessages allMessages =
          await _repository.uploadMessage(filePath: file.path);
      if (allMessages.status == true) {
        Message message =
            Message(userName: username, file: file, text: file.path);
        messages.add(message);
        notifyListeners();
      }
    } catch (e) {
      return e;
    }
  }
}
