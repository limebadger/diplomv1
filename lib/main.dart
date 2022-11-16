import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/userLogin.dart';
import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/registerScreen.dart';
import 'mockData/userData.dart';
import 'provider/alarm.dart';
import 'provider/alarms.dart';

void main() => runApp(MyApp());

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SleepAnalyzer',
        home: HomeScreen(),
        //home: LoginScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
