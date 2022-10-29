import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  String? userNameError;

 Future<bool> validateUserName(String username) async{
    if (username.isEmpty||username.length<3) {
      userNameError = "username length must be more than 3 letters";
      notifyListeners();
      return false;
    } else {
      userNameError = null;
      notifyListeners();
      return true;
    }
  }


}
