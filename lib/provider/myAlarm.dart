import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

//class Alarm with ChangeNotifier {
class MyAlarm with ChangeNotifier {
  var ringTime = 0;
  bool ringTimeIO = false;

  MyAlarm({required this.ringTime, required this.ringTimeIO});
}
