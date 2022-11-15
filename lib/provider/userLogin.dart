import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLogin with ChangeNotifier {
  var _loggedIn = false;
  var _userName = "";
  var _pw = "";

  bool get loggedIn {
    return _loggedIn;
  }

  void logInOut(bool loginBool) {
    _loggedIn = loginBool;
    notifyListeners();
  }

  void setUserCreds(String userName, String pw) {
    _userName = userName;
    _pw = pw;
  }
}
