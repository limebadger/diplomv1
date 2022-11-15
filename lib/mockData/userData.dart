import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/homeScreen.dart';

class UserData with ChangeNotifier {
  var _username = 'a';
  var _password = 'a';

  bool _isValidUser = false;

  void isUser(String un, String pw) {
    if ((_username == un) && (_password == pw)) {
      _isValidUser = true;
      //Navigator.of(context).pushNamed(HomeScreen.routeName);
    } else {
      _isValidUser = false;
    }
    notifyListeners();
  }

  bool get isValidUser {
    return _isValidUser;
  }
}
