import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../provider/alarm.dart';

class AlarmItem extends StatelessWidget {
  //const AlarmItem({super.key});
  @override
  Widget build(BuildContext context) {
    final alarm = Provider.of<Alarm>(context, listen: false);
    var hour = alarm.time1.elementAt(0);
    var minute = alarm.time1.elementAt(1);
    return ClipRRect(
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          //child: Container(color: Colors.blue),
          child: Text('$hour:$minute'),
        ),
      ),
    );

    return Container();
  }
}
