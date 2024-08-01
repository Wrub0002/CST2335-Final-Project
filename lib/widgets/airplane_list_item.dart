import 'package:flutter/material.dart';
import '../models/airplane.dart';

class AirplaneListItem extends StatelessWidget {
  final Airplane airplane;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  AirplaneListItem({
    required this.airplane,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                airplane.type,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('Passengers: ${airplane.numberOfPassengers}'),
              Text('Max Speed: ${airplane.maxSpeed} km/h'),
              Text('Range: ${airplane.range} km'),
            ],
          ),
        ),
      ),
    );
  }
}
