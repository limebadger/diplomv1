import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

class UserLogin with ChangeNotifier {
  final userData = GetStorage();

  void setUserID(int userID) {
    userData.write('userID', userID);
  }

  int get getUserID {
    return userData.read('userID');
  }

  void userLogout() {
    userData.write('userID', 0);
  }
}
