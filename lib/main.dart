import 'package:flutter/material.dart';
import 'flight_list_page.dart';
import 'flight_list_dao.dart';
import 'flight_list_db.dart';
import 'encrypted_preferences.dart'; // Import the EncryptedPreferences class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Management',
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
