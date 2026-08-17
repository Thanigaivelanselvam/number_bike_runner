import 'package:flutter/material.dart';
import 'package:number_bike_runner/number_runner/screens/start_number_runner_screen.dart';

void main() {
  runApp(const NumberBikeRunnerApp());
}

class NumberBikeRunnerApp extends StatelessWidget {
  const NumberBikeRunnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Bike Runner',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const StartNumberRunnerScreen(),
    );
  }
}
