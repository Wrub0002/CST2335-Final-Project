import 'package:flutter/material.dart';
import '../models/airplane.dart';

class AirplaneDetailScreen extends StatelessWidget {
  final Airplane airplane;

  AirplaneDetailScreen({required this.airplane});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${airplane.type} Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${airplane.type}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Passengers: ${airplane.numberOfPassengers}'),
            Text('Max Speed: ${airplane.maxSpeed} km/h'),
            Text('Range: ${airplane.range} km'),
          ],
        ),
      ),
    );
  }
}
