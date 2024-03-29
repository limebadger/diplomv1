import 'package:diplomv1/provider/myAlarm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//this is the right version!!!!!!

import '../provider/alarms.dart';
import 'alarmItem.dart';
import 'pickTime.dart';
import '../provider/alarms.dart';

class AlarmGrid extends StatefulWidget {
  @override
  State<AlarmGrid> createState() => _AlarmGridState();
}

class _AlarmGridState extends State<AlarmGrid> {
  @override
  Widget build(BuildContext context) {
    final alarmsData = Provider.of<Alarms>(context);
    final alarms = alarmsData.items;
    String? _selectedTime;

    Future<void> _show() async {
      final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, childWidget) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: childWidget!);
        },
      );
      if (result != null) {
        setState(
          () {
            _selectedTime = result.format(context);
            print("hello alarmgrid");
            print(result.hour);
            alarmsData.addAlarm(result);
          },
        );
      }
    }

/*     @override
    void initState() {
      final alarms = Provider.of<Alarms>(context, listen: false);
      alarms.initAlarmsFuture();
    } */

    return Stack(
      children: <Widget>[
        FutureBuilder(
          future: alarmsData.initAlarmsFuture(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Positioned(
                  right: 15,
                  bottom: 15,
                  child: FloatingActionButton(
                    onPressed: () => _show(),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey,
                    child: Icon(Icons.add),
                  ),
                  //child: Icon(Icons.add),
                  //backgroundColor: Colors.red,
                );
              } else {
                return Stack(children: <Widget>[
                  GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: alarms.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: alarms[i],
                      child: AlarmItem(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 6 / 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
                  Positioned(
                    right: 15,
                    bottom: 15,
                    child: FloatingActionButton(
                      onPressed: () => _show(),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                      child: Icon(Icons.add),
                    ),
                    //child: Icon(Icons.add),
                    //backgroundColor: Colors.red,
                  ),
                ]);
              } /* else {
                return const Text('Empty data');
              } */
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ],
    );
  }
}
