import 'package:flutter/material.dart';
import 'flight_list_page.dart';
import 'flight_list_dao.dart';
import 'flight_list_db.dart';
import 'encrypted_preferences.dart'; // Import the EncryptedPreferences class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  final database = await $FloorFlightDatabase.databaseBuilder('flight_database.db').build();
  final flightDao = database.flightDao;

  // Initialize encrypted preferences
  final encryptedPrefs = EncryptedPreferences();

  runApp(MyApp(flightDao: flightDao, encryptedPrefs: encryptedPrefs));
}

class MyApp extends StatelessWidget {
  final FlightDao flightDao;
  final EncryptedPreferences encryptedPrefs;

  const MyApp({super.key, required this.flightDao, required this.encryptedPrefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flight Management', flightDao: flightDao, encryptedPrefs: encryptedPrefs),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FlightDao flightDao;
  final EncryptedPreferences encryptedPrefs;

  const MyHomePage({super.key, required this.title, required this.flightDao, required this.encryptedPrefs});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Your content here
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _flightPage,
        tooltip: 'Flights',
        child: const Icon(Icons.flight),
      ),
    );
  }

  void _flightPage() {
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
}
