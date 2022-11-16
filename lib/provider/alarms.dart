import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/alarmGrid.dart';
import 'alarm.dart';

class Alarms with ChangeNotifier {
  List<Alarm> _items = [
    Alarm(
      time1: [12, 12],
      time2: [1, 1],
    ),
    Alarm(
      time1: [13, 12],
      time2: [1, 1],
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

  void addAlarm(var result) {
    print("alarms hello");
    print(result);
    List<int> _time1 = [result.hour, result.minute];
    _items.add(Alarm(time1: _time1, time2: _time1));
    notifyListeners();
  }

  /*  Alarm findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  } */
}
