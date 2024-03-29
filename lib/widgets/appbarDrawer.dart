import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/userLogin.dart';
import '../screens/loginScreen.dart';
import '../provider/userLogin.dart';
import '../provider/darkMode.dart';

class AppbarDrawer extends StatefulWidget {
  const AppbarDrawer({super.key});

  @override
  State<AppbarDrawer> createState() => _AppbarDrawerState();
}

class _AppbarDrawerState extends State<AppbarDrawer> {
  @override
  Widget build(BuildContext context) {
    var userLogin = Provider.of<UserLogin>(context, listen: false);
    var darkMode = Provider.of<DarkMode>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            /* decoration: BoxDecoration(
              color: Colors.grey,
            ), */
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                userLogin.userLogout(context);
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }),
          /* ListTile(
              leading: Icon(Icons.logout),
              title: Text('Change Theme'),
              onTap: () {
                darkMode.toggleTheme();
              }), */
          /* ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ), */
        ],
      ),
    );
  }
}
