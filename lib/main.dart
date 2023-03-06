import 'package:diplomv1/provider/chartSampleData.dart';
import 'package:diplomv1/provider/charts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alarm/alarm.dart';

import 'provider/userLogin.dart';
import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/registerScreen.dart';
import 'mockData/userData.dart';
import 'provider/myAlarm.dart';
import 'provider/alarms.dart';

void main() async {
  await GetStorage.init();
  await Alarm.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserLogin(),
        ),
        ChangeNotifierProvider.value(
          value: UserData(),
        ),
        ChangeNotifierProvider.value(
          value: Alarms(),
        ),
        ChangeNotifierProvider.value(
          value: Charts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SleepAnalyzer',
        //home: HomeScreen(),
        home: LoginScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
