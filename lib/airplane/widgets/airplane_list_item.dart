import 'package:flutter/material.dart';
import '../models/airplane.dart';

class AirplaneListItem extends StatelessWidget {
  final Airplane airplane;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const AirplaneListItem({
    Key? key,
    required this.airplane,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(airplane.type),
      subtitle: Text('Passengers: ${airplane.numberOfPassengers}, Speed: ${airplane.maxSpeed} km/h'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
