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

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

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
            ElevatedButton.icon(
              onPressed: _navigateToFlightListPage,
              icon: const Icon(Icons.flight),
              label: const Text('Go to Flight List Page'),
            ),
            // Add more buttons for other pages if needed
          ],
        ),
      ),
    );
  }

  void _navigateToFlightListPage() async {
    final database = await $FloorFlightDatabase.databaseBuilder('flight_database.db').build();
    final flightDao = database.flightDao;
    final encryptedPrefs = EncryptedPreferences();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightListPage(
          flightDao: flightDao,
          encryptedPrefs: encryptedPrefs,
        ),
      ),
    );
  }
}

