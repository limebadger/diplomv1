import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/alarms.dart';
import 'alarmItem.dart';

class AlarmGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final alarms = Provider.of<Alarms>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: alarms.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: alarms,
        child: AlarmItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
