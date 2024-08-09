import 'package:flutter/material.dart';
import '../models/airplane.dart';
import 'airplane_edit_view.dart';
import '../services/airplane_service.dart';

class AirplaneDetailsView extends StatelessWidget {
  final Airplane airplane;
  final AirplaneService airplaneService;
  final VoidCallback onAirplaneUpdated;

  AirplaneDetailsView({
    required this.airplane,
    required this.airplaneService,
    required this.onAirplaneUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(airplane.type),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => AirplaneEditView(
                  airplane: airplane,
                  airplaneService: airplaneService,
                  onAirplaneUpdated: onAirplaneUpdated, // Pass the callback here
                ),
              ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${airplane.type}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Passengers: ${airplane.numberOfPassengers}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Max Speed: ${airplane.maxSpeed} km/h', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Range: ${airplane.range} km', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
