import 'package:diaco_test/data/models/message.dart';

class AllMessages {
  AllMessages({
    bool? status,
    dynamic data,
  }) {
    _status = status;
    _data = data;
  }

  bool? _status;
  dynamic _data;

  bool? get status => _status;

  dynamic get data => _data;

  factory AllMessages.fromJson(Map<String, dynamic> json) {
    return AllMessages(status: json['status'], data: json['data']);
  }
}
