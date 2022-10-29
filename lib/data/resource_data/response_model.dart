import 'package:diaco_test/data/models/allMessage.dart';

class ResponseModel<T>{
   late T? data;
   late String message;
   late Status status;

   ResponseModel.loading(this.message):status=Status.LOADING;
   ResponseModel.completed(this.data):status=Status.COMPLETED;
   ResponseModel.failed(this.message):status=Status.FAILED;

}

enum Status{
  LOADING,
   COMPLETED,
   FAILED
}