import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../provider/myAlarm.dart';
import '../provider/alarms.dart';

class AlarmItem extends StatefulWidget {
  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  //const AlarmItem({super.key});
  bool light = true;

  @override
  Widget build(BuildContext context) {
    final alarm = Provider.of<MyAlarm>(context, listen: false);
    final alarms = Provider.of<Alarms>(context, listen: false);
    var time = alarm.ringTime;
    var timeStr = time.toString();
    var ringTimeIO = alarm.ringTimeIO;
    var hour;
    var minute;
    var finalTime;
    var timeToRemove;

    if (timeStr.length == 4) {
      hour = timeStr[0] + timeStr[1];
      minute = timeStr[2] + timeStr[3];
      finalTime = hour + ":" + minute;
      timeToRemove = hour + minute;
    } else if (timeStr.length == 3) {
      hour = "0" + timeStr[0];
      minute = timeStr[1] + timeStr[2];
      finalTime = hour + ":" + minute;
      timeToRemove = hour + minute;
    }

    return ClipRRect(
      child: GridTile(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: const Color(0x88000000),
          ),
          child: Row(
            children: <Widget>[
              Text('                  '),
              Text(finalTime,
                  style: TextStyle(color: Colors.white, fontSize: 25)),
              Spacer(),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Increase volume by 10',
                onPressed: () {
                  setState(() {
                    alarms.removeAlarm(timeToRemove);
                  });
                },
              ),
              Switch(
                // This bool value toggles the switch.
                value: ringTimeIO,
                activeColor: Colors.black54,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    ringTimeIO = value;
                    alarms.toggleAlarm(time, context);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
