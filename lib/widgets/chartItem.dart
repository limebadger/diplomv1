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
    return ClipRRect(
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Container(
              height: 500,
              width: 320,
              child: SfCartesianChart(
                backgroundColor: Colors.white,
                primaryXAxis: DateTimeAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    intervalType: DateTimeIntervalType.auto),
                series: <ChartSeries<ChartSampleData, DateTime>>[
                  LineSeries<ChartSampleData, DateTime>(
                    dataSource: charts.getData(index),
                    xValueMapper: (ChartSampleData sales, _) => sales.x,
                    yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                    name: 'Sales',
                  )
                ],
              )),
        ),
      ),
    );
  }
}
