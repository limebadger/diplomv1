import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

//class Alarm with ChangeNotifier {
class Alarm with ChangeNotifier {
  var ringTime = [0, 0];

  Alarm({
    required this.ringTime,
  });
}
