import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alarm/alarm.dart';

import '../widgets/alarmGrid.dart';
import 'myAlarm.dart';

class Alarms with ChangeNotifier {
  final ringTimes = GetStorage();

  var items = <MyAlarm>[];

  Future<int> initAlarmsFuture() async {
    var values = ringTimes.getKeys();
    //values.removeWhere((item) => item == 'userID');
    if (items.isEmpty) {
      for (var i = 0; i < values.length; i++) {
        var timeInt = int.parse(values.elementAt(i));
        items.add(MyAlarm(ringTime: timeInt, ringTimeIO: true));
      }

      items.sort((a, b) {
        return a.ringTime.compareTo(b.ringTime);
      });
    }
    return 1;
  }

  List<MyAlarm> get getRingTimes {
    return [...items];
  }

  int get length {
    return items.length;
  }

  void initAlarms() {
    print('hello hihi');
    if (ringTimes.read('userID') != null) {
      //ringTimes.write('9999', '9999');
      var values = ringTimes.getKeys();
      items.clear();
      if (items.isEmpty) {
        for (var i = 0; i < values.length; i++) {
          if (values.elementAt(i) !=
                  'userID' /*  &&
              values.elementAt(i) != '9999'*/
              ) {
            var timeInt = int.parse(values.elementAt(i));
            items.add(MyAlarm(
                ringTime: timeInt,
                ringTimeIO: ringTimes.read(values.elementAt(i))));
          }
        }

        items.sort((a, b) {
          return a.ringTime.compareTo(b.ringTime);
        });
      }
    } else
      //(ringTimes.write('9999', '9999'));
      notifyListeners();
  }

  void addAlarm(var selTime) {
    var values = ringTimes.getKeys();

    var timeStrHr = selTime.hour.toString();
    var timeStrMin = selTime.minute.toString();
    if (timeStrHr.length == 0) {
      timeStrHr = "00";
    } else if (timeStrHr.length < 2) {
      timeStrHr = "0" + timeStrHr;
    }
    if (timeStrMin.length < 2) {
      timeStrMin = "0" + timeStrMin;
    }

    var timeStr = timeStrHr + timeStrMin;

    if (values.contains(timeStr)) {
      print('nothing happens');
    } else {
      ringTimes.write(timeStr, true);
      print("-------------addAlarm-------------------");
      print("timeStr:");
      print(timeStr);
      var timeInt = int.parse(timeStr);
      items.add(MyAlarm(ringTime: timeInt, ringTimeIO: false));
      items.sort((a, b) {
        return a.ringTime.compareTo(b.ringTime);
      });
      notifyListeners();
    }
  }

  void toggleAlarm(var selTime, context) {
    var values = ringTimes.getKeys();
    //values.removeWhere((item) => item == 'userID');
    var buffer = items.firstWhere((item) => item.ringTime == selTime);
    if (buffer.ringTimeIO == false) {
      ringAlarm(selTime, context);
      buffer.ringTimeIO = true;
      ringTimes.write('$selTime', true);
      print("your in buffer.ringTimeIO == false");
    } else if (buffer.ringTimeIO == true) {
      buffer.ringTimeIO = false;
      ringTimes.write('$selTime', false);
      print("your in buffer.ringtTimeIO == true");
    }
    print("Time of day:");
    print(DateTime.now());
  }

  void erase() {
    ringTimes.erase();
    items.clear();
  }

  Future<void> ringAlarm(var selTimeInt, context) async {
    await Alarm.init();
    String selTime = selTimeInt.toString();
    var timeFormat;
    var hour;
    var minute;
    if (selTime.length == 4) {
      var b0 = selTime[0];
      var b1 = selTime[1];
      var b2 = selTime[2];
      var b3 = selTime[3];
      hour = b0 + b1;
      minute = b2 + b3;
    } else if (selTime.length == 3) {
      var b0 = selTime[0];
      var b1 = selTime[1];
      var b2 = selTime[2];
      hour = b0;
      minute = b1 + b2;
    } else if (selTime.length == 2) {
      var b0 = selTime[0];
      var b1 = selTime[1];
      hour = b0;
      minute = b1;
    } else if (selTime.length == 1) {
      hour = "0";
      minute = "0";
    }

    var now = DateTime.now();
    var hourStr = hour.toString();
    hourStr = checkIf2(hourStr);
    var minuteStr = minute.toString();
    minuteStr = checkIf2(minuteStr);
    var yearStr = now.year.toString();
    var monthStr = now.month.toString();
    monthStr = checkIf2(monthStr);
    var dayStr = now.day.toString();
    dayStr = checkIf2(dayStr);
    var secondStr = "00";

    var buffer = yearStr +
        "-" +
        monthStr +
        "-" +
        dayStr +
        " " +
        hourStr +
        ":" +
        minuteStr +
        ":" +
        secondStr;
    //"Z";
    print("buffer");
    print(buffer);
    timeFormat = DateTime.parse(buffer);

    print("This is ringday Function result:");
    print(ringDay(timeFormat));

    if (ringDay(timeFormat) == 'tomorrow')
      timeFormat = timeFormat.add(const Duration(days: 1));

    var alarmSettings = AlarmSettings(
      dateTime: timeFormat,
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      notificationTitle: null,
      notificationBody: null,
      enableNotificationOnKill: true,
    );

    print("dateTime: timeFormat");
    print(timeFormat);

    await Alarm.set(settings: alarmSettings);

    /*   for (var i = 0; i < items.length; i++) {
      var buffer = items.firstWhere((item) => item.ringTimeIO == true);
      if (buffer.ringTime != selTime) {
        toggleAlarm(selTime);
      }
    } */
/*     var i = 0;
    while (i < items.length) {
      if(items.firstWhere((item) => item.ringTimeIO == true)!=null){
        var buffer = items.firstWhere((item) => item.ringTimeIO == true);
        if (buffer.ringTime.toString() != selTime) {
        toggleAlarm(selTime);
      }
      }
    } */
    Alarm.ringStream.stream.listen((_) => alarmPopUp(context));
  }

  String ringDay(selectedTime) {
    final now = TimeOfDay.now();

    if (selectedTime!.hour > now.hour) return 'today';
    if (selectedTime!.hour < now.hour) return 'tomorrow';

    if (selectedTime!.minute > now.minute) return 'today';
    if (selectedTime!.minute < now.minute) return 'tomorrow';

    return 'tomorrow';
  }

  String checkIf2(String buffer1) {
    String buffer2 = "";
    if (buffer1.length == 0) {
      buffer2 = "00";
    } else if (buffer1.length == 1) {
      buffer2 = "0" + buffer1;
    } else if (buffer1.length == 2) {
      buffer2 = buffer1;
    } else {
      print("There is something wrong:");
      print(buffer1);
    }
    return buffer2;
  }

  Future<void> alarmPopUp(context) async {
    print("------------------------youve made it!!!---------------------");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
                yourOnRingCallback();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> yourOnRingCallback() async {
    await Alarm.stop();
  }

  void removeAlarm(var selTime) {
    var values = ringTimes.getKeys();
    //values.removeWhere((item) => item == 'userID');
    print(values);
    print("Youre at ringTimes.remove");
    ringTimes.remove(selTime);
    var newValues = ringTimes.getKeys();
    print(newValues);

    //items.removeWhere((item) => item.ringTime == selTime);
    initAlarms();

    items.sort(
      (a, b) {
        return a.ringTime.compareTo(b.ringTime);
      },
    );
    notifyListeners();
  }
}
