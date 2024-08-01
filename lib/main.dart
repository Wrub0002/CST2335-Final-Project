import 'package:flutter/material.dart';
import 'screens/airplane_list_screen.dart';

void main() {
  runApp(AirplaneApp());
}

class AirplaneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airplane Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AirplaneListScreen(),
    );
  }
}
