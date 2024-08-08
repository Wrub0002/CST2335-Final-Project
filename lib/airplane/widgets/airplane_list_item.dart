import 'package:flutter/material.dart';
import '../models/airplane_entity.dart';
import '../services/airplane_service.dart';

/// A widget that represents an item in the airplane list.
class AirplaneListItem extends StatelessWidget {
  final AirplaneEntity airplane;
  final AirplaneService airplaneService;

  /// Creates an AirplaneListItem widget.
  AirplaneListItem({required this.airplane, required this.airplaneService});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(airplane.type),
      subtitle: Text('Passengers: ${airplane.numberOfPassengers}, Speed: ${airplane.maxSpeed} km/h, Range: ${airplane.range} km'), // Adjusted based on available properties
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Confirm Delete'),
              content: Text('Are you sure you want to delete this airplane?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await airplaneService.deleteAirplane(airplane.id);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Airplane deleted')),
                    );
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/edit',
          arguments: airplane,
        );
      },
    );
  }
}
