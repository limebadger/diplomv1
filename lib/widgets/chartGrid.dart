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
        RefreshIndicator(
          color: Colors.transparent,
          backgroundColor: Colors.transparent,
          onRefresh: () {
            return Future(() {
              setState(() {});
            });
          },
          child: FutureBuilder(
            future: charts.fetchData(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: charts.length,
                    itemBuilder: (context, index) =>
                        ChartItem(index: (charts.length - index - 1)),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  );
                } /* else {
                  return const Text('Empty data');
                } */
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ],
    );
  }
}
