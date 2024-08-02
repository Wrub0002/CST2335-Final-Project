import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../widgets/airplane_list_item.dart';
import 'add_airplane_screen.dart';
import 'airplane_detail_screen.dart';

/// A screen that displays a list of airplanes and allows users to add, update, or delete airplanes.
class AirplaneListScreen extends StatefulWidget {
  @override
  _AirplaneListScreenState createState() => _AirplaneListScreenState();
}

class _AirplaneListScreenState extends State<AirplaneListScreen> {
  final List<Airplane> airplanes = [];

  /// Adds a new airplane to the list and updates the state.
  void _addNewAirplane(Airplane airplane) {
    setState(() {
      airplanes.add(airplane);
    });
  }

  /// Updates an existing airplane in the list and updates the state.
  void _updateAirplane(Airplane updatedAirplane) {
    setState(() {
      final index = airplanes.indexWhere((airplane) => airplane.type == updatedAirplane.type);
      if (index != -1) {
        airplanes[index] = updatedAirplane;
      }
    });
  }

  /// This method is called when an airplane is deleted via the [AirplaneDetailScreen].
  /// It removes the airplane from the list based on its type.
  void _deleteAirplane(Airplane airplane) {
    setState(() {
      airplanes.removeWhere((a) => a.type == airplane.type);
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
