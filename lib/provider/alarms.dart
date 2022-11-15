import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/alarmGrid.dart';
import 'alarm.dart';

class Alarms with ChangeNotifier {
  List<Alarm> _items = [
    Alarm(
      time1: {12, 12},
      time2: {1, 1},
      weekdays: {1, 0, 0, 0, 0, 0, 0},
    ),
  ];

  List<Alarm> get items {
    return [..._items];
  }

  int get length {
    return _items.length;
  }

  /* Alarm findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  } */

  void addAlarm(var _time1, var _time2, var _weekdays) {
    _items.add(Alarm(time1: _time1, time2: _time2, weekdays: _weekdays));
    notifyListeners();
  }
}
