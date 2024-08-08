import 'package:flutter/material.dart';
import 'flight_entity.dart';

class FlightDetailPage extends StatelessWidget {
  final FlightEntity flight;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  FlightDetailPage({
    required this.flight,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Departure: ${flight.departureCity} -> Arrival: ${flight.arrivalCity}'),
            Text('Departure Time: ${DateTime.fromMillisecondsSinceEpoch(flight.departureTime)}'),
            Text('Arrival Time: ${DateTime.fromMillisecondsSinceEpoch(flight.arrivalTime)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onUpdate,
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: onDelete,
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
