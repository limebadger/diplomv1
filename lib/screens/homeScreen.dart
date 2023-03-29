import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/appbarDrawer.dart';
import '../provider/userLogin.dart';
import 'loginScreen.dart';
import '../widgets/dataGridview1.dart';
import '../widgets/alarmGrid.dart';
import '../widgets/chartGrid.dart';
import '../provider/charts.dart';
import '../provider/darkMode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    /* const Text(
      'Index 0',
      style: optionStyle,
    ), */
    ChartGrid(),
    AlarmGrid(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userLogin = Provider.of<UserLogin>(context);
    final darkMode = Provider.of<DarkMode>(context, listen: true);
    var mode = darkMode.getDarkMode;
    return Theme(
      data: ThemeData(
          brightness: mode ? Brightness.light : Brightness.dark,
          primaryColor: mode ? Colors.lightGreen.shade200 : Colors.black54,
          fontFamily: 'ZTGatha'),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/surreal.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('SleepAnalyzer'),
            backgroundColor: Colors.black54,
          ),
          drawer: AppbarDrawer(),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.black54),
            child: BottomNavigationBar(
              showUnselectedLabels: false,
              unselectedItemColor: Colors.white54,
              items: const <BottomNavigationBarItem>[
                /* BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ), */
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Charts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarm),
                  label: 'Alarm',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white70,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
