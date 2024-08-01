import 'package:flutter/material.dart';
import 'flight_list_dao.dart';
import 'flight_list_page.dart';
import 'flight_list_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database and obtain an instance of FlightDao
  final database = await $FloorFlightDatabase.databaseBuilder('flight_database.db').build();
  final flightDao = database.flightDao;

  runApp(MyApp(flightDao: flightDao));
}

class MyApp extends StatelessWidget {
  final FlightDao flightDao;

  // Modified constructor to accept FlightDao instance
  const MyApp({super.key, required this.flightDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Place holder Main page', flightDao: flightDao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FlightDao flightDao;

  // Modified constructor to accept FlightDao instance
  const MyHomePage({super.key, required this.title, required this.flightDao});
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
      // Pass the FlightDao instance to FlightListPage
      MaterialPageRoute(builder: (context) => FlightListPage(flightDao: widget.flightDao)),
    );
  }
}
