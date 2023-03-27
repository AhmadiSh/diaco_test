import 'package:diaco_test/data/resource_data/locale/base_box.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  factory LoginProvider() => _instance;
  static final LoginProvider _instance = LoginProvider._init();

  LoginProvider._init();

  String username='';

  final BaseBox<String> userBox = BaseBox<String>('user-box');

  Future<void> init() async {
    await userBox.open();
  }

  Future<void> getUsername() async {
    if (userBox.isNotEmpty) {
   username = await userBox.first()??'';

    }
    notifyListeners();
  }

  Future<void> setUsername(String userName) async {
    userBox.clear();
    userBox['userName']=userName;
    username=userName;
    notifyListeners();
  }

  @override
  void dispose() {
    userBox.close();
    super.dispose();
  }
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
