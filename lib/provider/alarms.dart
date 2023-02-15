import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/alarmGrid.dart';
import 'alarm.dart';

class Alarms with ChangeNotifier {
  final ringTimes = GetStorage();

  List<Alarm> _items = [
    Alarm(
      ringTime: [12, 12],
    ),
    Alarm(
      ringTime: [13, 12],
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

  void addAlarm(var selTime) {
    print("alarms hello");
    print(selTime);
    List<int> _time1 = [selTime.hour, selTime.minute];
    _items.add(Alarm(ringTime: _time1));
    notifyListeners();
  }

  /*  Alarm findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  } */
}
