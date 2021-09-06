import 'dart:async';

import 'package:flutter/material.dart';
import 'package:light/light.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
            Container(
              child: SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                    radiusFactor: 1,
                    maximum: 500,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                              child: Text('$_luxString',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                          angle: 90,
                          positionFactor: 0.4)
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        gradient: const SweepGradient(
                          colors: <Color>[Colors.yellow, Colors.amber],
                          stops: <double>[0.25, 0.75],
                        ),
                        value: double.parse(_luxString),
                        cornerStyle: CornerStyle.bothCurve,
                        width: 24,
                      )
                    ],
                    startAngle: 270,
                    endAngle: 270,
                    axisLineStyle: AxisLineStyle(
                      cornerStyle: CornerStyle.bothCurve,
                      thickness: 24,
                      thicknessUnit: GaugeSizeUnit.logicalPixel,
                    )),
              ]),
            ),
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
