import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../crud/airplane_database_service.dart';
import '../widgets/airplane_list_item.dart';
import 'add_airplane_screen.dart';
import 'airplane_detail_screen.dart';

class AirplaneListScreen extends StatefulWidget {
  @override
  _AirplaneListScreenState createState() => _AirplaneListScreenState();
}

class _AirplaneListScreenState extends State<AirplaneListScreen> {
  late final AirplaneDatabase _database;
  late final AirplaneDao _airplaneDao;
  List<Airplane> airplanes = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await $FloorAirplaneDatabase.databaseBuilder('airplane_database.db').build();
    _airplaneDao = _database.airplaneDao;
    _loadAirplanes();
  }

  Future<void> _loadAirplanes() async {
    final loadedAirplanes = await _airplaneDao.findAllAirplanes();
    setState(() {
      airplanes = loadedAirplanes;
    });
  }

  Future<void> _addNewAirplane(Airplane airplane) async {
    await _airplaneDao.insertAirplane(airplane);
    setState(() {
      airplanes.add(airplane);
    });
  }

  Future<void> _updateAirplane(Airplane updatedAirplane) async {
    await _airplaneDao.updateAirplane(updatedAirplane);
    _loadAirplanes();
  }

  Future<void> _deleteAirplane(Airplane airplane) async {
    await _airplaneDao.deleteAirplane(airplane);
    setState(() {
      airplanes.removeWhere((a) => a.id == airplane.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
      ),
      body: ListView.builder(
        itemCount: airplanes.length,
        itemBuilder: (context, index) {
          return AirplaneListItem(
            airplane: airplanes[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AirplaneDetailScreen(
                    airplane: airplanes[index],
                    onUpdateAirplane: _updateAirplane,
                    onDeleteAirplane: _deleteAirplane,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddAirplaneScreen(
                onAddAirplane: _addNewAirplane,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
