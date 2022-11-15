import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class Alarm with ChangeNotifier {
  var time1 = {0, 0};
  var time2 = {0, 0};
  var weekdays = {0, 0, 0, 0, 0, 0, 0};

  Alarm({
    required this.time1,
    required this.time2,
    required this.weekdays,
  });
}
