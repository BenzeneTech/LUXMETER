import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutterlux/models/provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiveChartWidget extends StatefulWidget {
  @override
  _LiveChartWidgetState createState() => _LiveChartWidgetState();
}

class _LiveChartWidgetState extends State<LiveChartWidget> {
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Consumer<DataProvider>(
                builder: (context, model, child) => SfCartesianChart(
                    margin: EdgeInsets.all(10),
                    title: ChartTitle(text: 'Lux Value vs Time'),
                    series: <LineSeries<ChartData, int>>[
                      LineSeries<ChartData, int>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: model.values,
                        color: Colors.amber,
                        xValueMapper: (ChartData data, _) => data.time,
                        yValueMapper: (ChartData data, _) => data.lux,
                      )
                    ],
                    primaryXAxis: NumericAxis(
                        // isVisible: false,
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 10,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: 'Lux Value'))))));
  }
}
