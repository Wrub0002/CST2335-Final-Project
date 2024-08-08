import 'package:cst2335_final_project/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'airplane/services/airplane_service.dart';
import 'airplane/initializers/app_initializer.dart';
import 'airplane/layout/responsive_layout.dart';
import 'package:cst2335_final_project/CustomerListPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/pageOne' : (context) => const MyHomePage(title: 'Home Page'),
        '/pageTwo' : (context) {return const CustomerListPage();}
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/pageTwo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


  // Initialize the airplane service using the AppInitializer class
  final airplaneService = await AppInitializer.initializeAirplaneService();


  runApp(MyApp(airplaneService: airplaneService));
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false, // Add this line to remove the DEBUG banner
      home: ResponsiveLayout(airplaneService: airplaneService),
    );
  }
}