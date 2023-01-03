import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/charts.dart';
import '../provider/chartSampleData.dart';
import 'chartItem.dart';

class ChartGrid extends StatefulWidget {
  @override
  State<ChartGrid> createState() => _ChartGridState();
}

class _ChartGridState extends State<ChartGrid> {
  @override
  Widget build(BuildContext context) {
    final charts = Provider.of<Charts>(context);

    return Stack(
      children: <Widget>[
        FutureBuilder(
            future: charts.fetchData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: charts.length,
                itemBuilder: (context, index) => ChartItem(index: index),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              );
            }),
      ],
    );
  }
}
