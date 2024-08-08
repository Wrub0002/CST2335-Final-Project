import 'package:flutter/material.dart';
import 'CustomerListPage.dart';
import 'flight_list_dao.dart';
import 'flight_list_db.dart';
import 'flight_list_page.dart';  // Make sure you import the correct flight_list_page file
import 'encrypted_preferences.dart'; // Import the EncryptedPreferences class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  final database = await $FloorFlightDatabase.databaseBuilder('flight_database.db').build();
  final flightDao = database.flightDao;

  // Initialize encrypted preferences
  final encryptedPrefs = EncryptedPreferences();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airplane Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      routes: {

        '/customerList': (context) => const CustomerListPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
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
            ),ElevatedButton.icon(
                onPressed: _navigateToCustomerListPage,
                icon: const Icon(Icons.people),
                label: const Text('Go to Customer List Page'),
            ),
          ],
        ),
      ),
    );
  }
  void _navigateToCustomerListPage() {
    Navigator.pushNamed(context, '/customerList');
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
