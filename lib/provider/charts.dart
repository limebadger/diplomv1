import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import '../widgets/chartGrid.dart';
import 'chartSampleData.dart';
import 'userLogin.dart';

class Charts with ChangeNotifier {
  List<ChartSampleData> chartData = <ChartSampleData>[];
  var jsondata;

  fetchData(var context) async {
    final userLogin = Provider.of<UserLogin>(context);
    String apiurl = "http://192.168.178.34/get_biosignal.php";
    print("Data is fetched!!!!!");
    var response = await http
        .post(Uri.parse(apiurl), body: {'us_name': userLogin.getUserID});
    if (response.statusCode == 200) {
      jsondata = json.jsonDecode(response.body);
    }
  }

  List<ChartSampleData> getData(x) {
    chartData.clear();
    print("-------get Data-----------");

    for (var i = 0; i < jsondata[0][x].length; i++) {
      var mytime = DateTime.parse(jsondata[0][x][i]);
      var myVal = double.parse(jsondata[2][x][i]);

      chartData.add(ChartSampleData(x: mytime, yValue: myVal));
    }
    return chartData;
  }

  int get length {
    return jsondata[0].length;
  }
}
