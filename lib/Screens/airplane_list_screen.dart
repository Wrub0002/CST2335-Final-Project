import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../widgets/airplane_list_item.dart';
import 'add_airplane_screen.dart';
import 'airplane_detail_screen.dart';

/// A screen that displays a list of airplanes and allows the user to add, view details, and delete airplanes.
class AirplaneListScreen extends StatefulWidget {
  @override
  _AirplaneListScreenState createState() => _AirplaneListScreenState();
}

class _AirplaneListScreenState extends State<AirplaneListScreen> {
  final List<Airplane> airplanes = [];

  void _addNewAirplane(Airplane airplane) {
    setState(() {
      airplanes.add(airplane);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Instructions'),
                  content: Text('Use the "+" button to add a new airplane. Long-press on an airplane to delete it.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: airplanes.length,
        itemBuilder: (context, index) {
          return AirplaneListItem(
            airplane: airplanes[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AirplaneDetailScreen(airplane: airplanes[index]),
                ),
              );
            },
            onLongPress: () {
              setState(() {
                airplanes.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Airplane deleted'),
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
              builder: (context) => AddAirplaneScreen(onAddAirplane: _addNewAirplane),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
