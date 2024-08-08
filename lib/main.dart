import 'package:flutter/material.dart';
import 'CustomerListPage.dart';
import 'flight_list_dao.dart';
import 'flight_list_db.dart';
import 'flight_list_page.dart';
import 'encrypted_preferences.dart';
import 'package:cst2335_final_project/airplane/initializers/database_initializer.dart';
import 'package:cst2335_final_project/airplane/services/airplane_service.dart';
import 'package:cst2335_final_project/airplane/views/airplane_responsive_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the flight database
  final flightDatabase = await $FloorFlightDatabase.databaseBuilder('flight_database.db').build();
  final flightDao = flightDatabase.flightDao;

  // Initialize encrypted preferences
  final encryptedPrefs = EncryptedPreferences();

  // Initialize the airplane service
  final airplaneService = await DatabaseInitializer.initializeAirplaneService();

  runApp(MyApp(
    flightDao: flightDao,
    encryptedPrefs: encryptedPrefs,
    airplaneService: airplaneService,
  ));
}

class MyApp extends StatelessWidget {
  final FlightDao flightDao;
  final EncryptedPreferences encryptedPrefs;
  final AirplaneService airplaneService;

  MyApp({
    required this.flightDao,
    required this.encryptedPrefs,
    required this.airplaneService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airplane Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        flightDao: flightDao,
        encryptedPrefs: encryptedPrefs,
        airplaneService: airplaneService,
      ),
      routes: {
        '/customerList': (context) => const CustomerListPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FlightDao flightDao;
  final EncryptedPreferences encryptedPrefs;
  final AirplaneService airplaneService;

  MyHomePage({
    required this.flightDao,
    required this.encryptedPrefs,
    required this.airplaneService,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home Page'),
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
            ElevatedButton.icon(
              onPressed: _navigateToCustomerListPage,
              icon: const Icon(Icons.people),
              label: const Text('Go to Customer List Page'),
            ),
            ElevatedButton.icon(
              onPressed: _navigateToAirplanePage,
              icon: const Icon(Icons.airplanemode_active),
              label: const Text('Go to Airplane Management'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCustomerListPage() {
    Navigator.pushNamed(context, '/customerList');
  }

  void _navigateToFlightListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightListPage(
          flightDao: widget.flightDao,
          encryptedPrefs: widget.encryptedPrefs,
        ),
      ),
    );
  }

  void _navigateToAirplanePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AirplaneResponsiveView(
          airplaneService: widget.airplaneService,
        ),
      ),
    );
  }
}
