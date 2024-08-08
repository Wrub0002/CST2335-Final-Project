import 'package:flutter/material.dart';
import '../services/airplane_service.dart';
import '../initializers/app_initializer.dart';
import '../layout/responsive_layout.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the airplane service using the AppInitializer class
  final airplaneService = await AppInitializer.initializeAirplaneService();

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
      debugShowCheckedModeBanner: false, // Add this line to remove the DEBUG banner
      home: ResponsiveLayout(airplaneService: airplaneService),
    );
  }
}