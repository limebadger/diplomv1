import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../provider/chartSampleData.dart';
import '../provider/charts.dart';

class ChartItem extends StatelessWidget {
  int index;
  ChartItem({required this.index});

  @override
  Widget build(BuildContext context) {
    print("--------------index:----------------");
    print(index);

    var charts = Provider.of<Charts>(context, listen: false);
    var time = charts.getTime(index);
    return Theme(
      data: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightGreen.shade200,
          fontFamily: 'ZTGatha'),
      child: ClipRRect(
        child: GridTile(
          child: Container(
            height: 10000,
            width: 500,
            //color: Color.fromRGBO(0, 0, 0, 0.78),
            child: SfCartesianChart(
              backgroundColor: Colors.white,
              borderColor: Colors.black,
              title: ChartTitle(text: time),
              primaryXAxis: DateTimeAxis(
                  title: AxisTitle(text: 'Time'),
                  majorGridLines: MajorGridLines(width: 0),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  intervalType: DateTimeIntervalType.auto),
              primaryYAxis:
                  NumericAxis(title: AxisTitle(text: 'Movement Intensity')),
              series: <ChartSeries<ChartSampleData, DateTime>>[
                LineSeries<ChartSampleData, DateTime>(
                  dataSource: charts.getData(index),
                  xValueMapper: (ChartSampleData sales, _) => sales.x,
                  yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                  name: 'Sales',
                )
              ],
            ),
            //Text(time, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
