import 'dart:async';

import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _luxString = '20';
  late Light _light;
  late StreamSubscription _subscription;
  var chartData = [
    _ChartData('Akshit', 90000, Colors.red),
  ];

  void onData(int luxValue) async {
    print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black87,
      // appBar: new AppBar(
      //   title: const Text('Light Example App'),
      // ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_luxString'),
            Container(
                child: SfCircularChart(
                    // backgroundColor: Colors.black,
                    series: <CircularSeries>[
                  // RADIAL | DOUGHNUT SERIES
                  RadialBarSeries<_ChartData, String>(
                      maximumValue: 100,
                      // trackColor: Colors.grey.shade800,
                      dataSource: chartData,
                      xValueMapper: (_ChartData data, _) => '',
                      yValueMapper: (_ChartData data, _) =>
                          num.parse(_luxString),
                      pointColorMapper: (_ChartData data, _) => data.color,
                      cornerStyle: CornerStyle.bothCurve,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      radius: '100%',
                      innerRadius: '80%'),
                ])),
            //      Container(
            //   child: SfRadialGauge(axes: <RadialAxis>[
            //     RadialAxis(
            //         annotations: <GaugeAnnotation>[
            //           GaugeAnnotation(
            //               widget: Container(
            //                   child: Text('$_luxString',
            //                       style: TextStyle(
            //                           fontSize: 25,
            //                           fontWeight: FontWeight.bold))),
            //               angle: 90,
            //               positionFactor: 0.5)
            //         ],
            //         startAngle: 270,
            //         endAngle: 270,
            //         axisLineStyle: AxisLineStyle(
            //           thickness: 0.1,
            //           thicknessUnit: GaugeSizeUnit.factor,
            //           gradient: const SweepGradient(
            //             colors: <Color>[Colors.yellow, Colors.amber],
            //             // stops: <double>[0.25, 0.75]
            //           ),
            //         )),
            //   ]),
            // ),
            // Text(
            //   '$_luxString',
            //   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            // )
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);
  final String x;
  final num y;
  final Color color;
}
