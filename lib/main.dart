import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterlux/home.dart';
import 'package:flutterlux/models/provider.dart';
import 'dart:async';
import 'package:light/light.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => DataProvider(),
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(fontFamily: 'DMSans', brightness: Brightness.dark),
            debugShowCheckedModeBanner: false,
            home: Home()));
    // );
  }
}
