import 'dart:io';

class Message {
  Message(
      {int? id, String? userName, String? text, String? date, String? file,int? replyId}) {
    _id = id;
    _username=userName;
    _text=text;
    _data=date;
    _file=file;
    _replyId=replyId;
  }

  int? _id;
  String? _username;
  String? _text;
  String? _data;
  String? _file;
  int ?_replyId;

  int? get id => _id;
  String? get username => _username;
  String? get text => _text;

  String? get date => _data;

  String? get file => _file;

  int? get replyId=>_replyId;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        userName: json['username'],
        text: json['text'],
        date: json['date'],
        file: json['file'],
      replyId: json['replyId']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = _id;
    map['username'] = _username;
    map['text'] = _text;
    map['date'] = _data;
    map['file'] = _file;
    map['replyId']=replyId;
    return map;
  }

  set text(String ?value) {
    _text = value;
  }

  set file(String? value) {
    _file = value;
  }
}
