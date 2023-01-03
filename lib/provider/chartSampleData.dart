import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class ChartSampleData with ChangeNotifier {
  ChartSampleData({this.x, this.yValue});

  final DateTime? x;
  final double? yValue;
}
