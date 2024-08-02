import 'package:flutter/material.dart';
import 'screens/airplane_list_screen.dart';

/// The entry point of the Airplane Manager application.
void main() {
  runApp(AirplaneApp());
}

/// The root widget of the Airplane Manager application.
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
