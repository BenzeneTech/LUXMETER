import 'dart:async';

import 'package:flutter/material.dart';
import 'package:light/light.dart';

class DataProvider extends ChangeNotifier {
  int lux = 0;
  late Light _light;
  late StreamSubscription _subscription;
  List<ChartData> values = [];
  int time = 0;
  bool start = false;

  void onData(int luxValue) async {
    lux = luxValue;
    values.add(ChartData(lux, time++));
    if (values.length > 40) {
      values.removeAt(0);
    }
    notifyListeners();
  }

  void stopListening() {
    start = !start;
    _subscription.cancel();
    notifyListeners();
  }

  void startListening() {
    start = !start;
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
    notifyListeners();
  }
}

class ChartData {
  ChartData(
    this.lux,
    this.time,
  );
  final int lux, time;
}
