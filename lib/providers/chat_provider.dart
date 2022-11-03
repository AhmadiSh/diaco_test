import 'dart:io';

import 'package:diaco_test/data/models/allMessage.dart';
import 'package:diaco_test/data/models/message.dart';
import 'package:diaco_test/data/resource_data/repositories/all_message_repo.dart';
import 'package:diaco_test/data/resource_data/response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
  bool fileUploaded = false;

  ChatProvider() {
    getAllMessages();
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

  Future pickImage(source) async {
    try {
      final image = await ImagePicker().pickImage(source:source);
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

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 5,
    );

    return compressedFile!;
  }

  Future<dynamic> getAllMessages() async {
    responseModel = ResponseModel.loading("Loading...");

    try {
      int count = 0;
      List<Message> response = [];
      do {
        allMessages = await _repository.fetchCallAllMessage(count);

        if (allMessages!.status == true) {
          for (int i = 0; i < allMessages!.data!.length; i++) {
            response.add(Message.fromJson(allMessages!.data![i]));
          }
        }
        count += 10;
      } while (allMessages!.data!.length != 0);
      messages.addAll(response);
      notifyListeners();
      responseModel = ResponseModel.completed(allMessages!);
      notifyListeners();
    } catch (e) {
      responseModel = ResponseModel.failed("check your connection.");
      notifyListeners();
    }
  }

  sendMessage({required username, required text,String? filePath}) async {
    try {
      AllMessages allMessages;
      allMessages =
          await _repository.createMessage(username: username, text: text,filePath:filePath);
      if (allMessages.status == true) {
        messages.clear();
        await getAllMessages();
        /*    Message message = Message(
            userName: username, text: text, file: file);
        messages.add(message);*/
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

      await getAllMessages();
      notifyListeners();
    } catch (e) {
      return e;
    }
  }

  uploadMessage({required username}) async {
    final lastIndex = file!.path.lastIndexOf(new RegExp(r'.jp'));
    final splitted = file!.path.substring(0, (lastIndex));
    final outPath = "${splitted}_out${file!.path.substring(lastIndex)}";
    File _file = await compressAndGetFile(file!, outPath);
    try {
      AllMessages allMessages =
          await _repository.uploadMessage(filePath: _file.path);
      if (allMessages.status == true) {
        await sendMessage(username: username, text: _file.path,filePath:_file.path);
     /*   Message message =
            Message(userName: username, file:_file.path, text:_file.path);
        messages.add(message);*/
        fileUploaded = true;
        uploadState = false;
        notifyListeners();
      }
    } catch (e) {
      return e;
    }
  }
}
