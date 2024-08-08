import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'localization/app_localizations.dart';  // Import localization
import 'airplane/views/airplane_list_view.dart';
import 'airplane/repositories/airplane_dao.dart';
import 'airplane/repositories/airplane_repository.dart';
import 'airplane/services/airplane_service.dart';
import 'airplane/models/airplane_entity.dart';
import 'airplane/repositories/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();

  // Initialize the DAO and repository
  final airplaneDao = database.airplaneDao;
  final airplaneRepository = AirplaneRepository(airplaneDao);

  // Initialize the service
  final airplaneService = AirplaneService(airplaneRepository);

  runApp(MyApp(airplaneService: airplaneService));
}

class MyApp extends StatefulWidget {
  final AirplaneService airplaneService;

  MyApp({required this.airplaneService});

  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLanguage(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: [
        Locale('en', ''),
        Locale('pt', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Airplane Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AirplaneListView(airplaneService: widget.airplaneService),
    );
  }
}
