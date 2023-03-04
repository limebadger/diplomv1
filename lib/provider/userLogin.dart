import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

import 'alarms.dart';

class UserLogin with ChangeNotifier {
  final userData = GetStorage();

  void setUserID(int userID) {
    userData.write('userID', userID);
  }

  int get getUserID {
    //userData.getKeys();
    if (userData.read('userID') != null) {
      return userData.read('userID');
    } else {
      return 0;
    }
  }

  void userLogout(context) {
    userData.write('userID', 0);
    final alarms = Provider.of<Alarms>(context, listen: false);
    alarms.erase();
  }
}
