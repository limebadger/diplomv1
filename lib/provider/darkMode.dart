import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alarm/alarm.dart';

class DarkMode with ChangeNotifier {
  bool darkMode = false;

  void toggleTheme() {
    if (darkMode == false) {
      darkMode == true;
    } else if (darkMode == true) {
      darkMode == false;
    }
    notifyListeners();
  }

  bool get getDarkMode {
    notifyListeners();
    return darkMode;
  }
}
