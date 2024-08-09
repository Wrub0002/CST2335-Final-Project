import 'package:flutter/material.dart';
import 'package:cst2335_final_project/airplane/initializers/database_initializer.dart';
import 'package:cst2335_final_project/airplane/services/airplane_service.dart';
import 'package:cst2335_final_project/airplane/views/airplane_responsive_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final airplaneService = await DatabaseInitializer.initializeAirplaneService();

  runApp(MyApp(airplaneService: airplaneService));
}

class MyApp extends StatelessWidget {
  final AirplaneService airplaneService;

  MyApp({required this.airplaneService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airplane Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: AirplaneResponsiveView(airplaneService: airplaneService),
    );
  }
}
