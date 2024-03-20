import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/screens/home.dart';
import 'package:flutter_ble_sample/util/constant.dart';

void main() {
  runApp(const FlutterBLESampleApp());
}

class FlutterBLESampleApp extends StatelessWidget {
  const FlutterBLESampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: false,
      ),
      home: const HomeScreen(),
    );
  }
}
