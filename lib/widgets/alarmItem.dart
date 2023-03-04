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
    var hour = alarm.ringTime;
    var ringTimeIO = alarm.ringTimeIO;
    return ClipRRect(
      child: GridTile(
        child: Container(
          child: Row(
            children: <Widget>[
              Text('$hour'),
              Spacer(),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Increase volume by 10',
                onPressed: () {
                  setState(() {
                    alarms.removeAlarm('$hour');
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
                    alarms.toggleAlarm(hour, context);
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
