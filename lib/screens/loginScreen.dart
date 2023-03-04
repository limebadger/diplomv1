import 'dart:convert';
import 'package:diplomv1/screens/registerScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'homeScreen.dart';
import 'registerScreen.dart';
import '../provider/userLogin.dart';
import '../provider/alarms.dart';

class LoginScreen extends StatefulWidget {
  @override
  static const routeName = '/login';
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginScreen> {
  String errormsg = '';
  bool error = false, showprogress = false;
  String username = '', password = '';

  var _username = TextEditingController();
  var _password = TextEditingController();

  startLogin() async {
    print(
        "----------------------------------try get data------------------------");
    String apiurl = "http://sleepanalyzer.dns.army/read.php";
    print(username);
    print(password);
    final userLogin = Provider.of<UserLogin>(context, listen: false);

    var response = await http.post(Uri.parse(apiurl), body: {
      'us_name': username, //get the username text
      'us_password': password //get password text
    });
    print("var response = await ");
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      var jsondata = json.decode(response.body);
      print(jsondata);
      if (jsondata["error"]) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
          print("error47");
        });
      } else {
        if (jsondata["success"]) {
          print("success54");
          setState(() {
            error = false;
            showprogress = false;
          });
          Navigator.of(context).pushNamed(HomeScreen.routeName);
          userLogin.setUserID(int.parse(jsondata["userID"]));
          print(
              "===========================hold up===============================");
          print(userLogin.getUserID);
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    final userLogin = Provider.of<UserLogin>(context, listen: false);
    final alarms = Provider.of<Alarms>(context, listen: false);

    alarms.initAlarms();
    //final userLogin2 = Provider.of<UserLogin>(context);
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    /* if (userLogin.getUserID != 0) {
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } */

    print("Your are in initState!");
    print(userLogin.getUserID);

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userLogin = Provider.of<UserLogin>(context, listen: false);
    if (userLogin.getUserID != 0) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
        print("you're logged in");
      });
    }
    print(
        "-------------------------------------hallo--------------------------------------");
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height
                //set minimum height equal to 100% of VH
                ),
        width: MediaQuery.of(context).size.width,
        //make width of outer wrapper to 100%
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.indigo.shade100,
              Colors.blue.shade100,
              Colors.teal.shade200,
              Colors.green.shade200,
            ],
          ),
        ), //show linear gradient background of page

        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Text(
              "Welcome back!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ), //title text
          ),
          Container(
            //show error message here
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(10),
            child: error ? errmsg(errormsg) : Container(),
            //if error == true then show error message
            //else set empty container as child
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _username, //set username controller
              style: TextStyle(color: Colors.black, fontSize: 20),
              decoration: myInputDecoration(
                label: "Username",
                icon: Icons.person,
              ),
              onChanged: (value) {
                //set username  text on change
                username = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _password, //set password controller
              style: TextStyle(color: Colors.black, fontSize: 20),
              obscureText: true,
              decoration: myInputDecoration(
                label: "Password",
                icon: Icons.lock,
              ),
              onChanged: (value) {
                // change password text
                password = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    //show progress indicator on click
                    showprogress = true;
                  });
                  startLogin();
                },
                child: showprogress
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.orange[100],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepOrangeAccent),
                        ),
                      )
                    : Text(
                        "LOGIN NOW",
                        style: TextStyle(fontSize: 20),
                      ),
                // if showprogress == true then show progress indicator
                // else show "LOGIN NOW" text
                /* colorBrightness: Brightness.dark,
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                    //button corner radius
                    ), */
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: InkResponse(
                onTap: () {
                  Navigator.of(context).pushNamed(RegisterScreen.routeName);
                },
                child: Text(
                  "No Account? Register",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ]),
      )),
    );
  }

  InputDecoration myInputDecoration(
      {String label = '', IconData icon = Icons.airplanemode_on}) {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle:
          TextStyle(color: Colors.black38, fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: Colors.black38,
          )
          //padding and icon for prefix
          ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.black54, width: 1)), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: Colors.black54, width: 1)), //focus border

      fillColor: Colors.white54,
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color: Colors.red, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}
