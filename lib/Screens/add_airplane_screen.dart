import 'package:flutter/material.dart';
import '../models/airplane.dart';

/// A screen that allows users to add a new airplane to the list.
class AddAirplaneScreen extends StatefulWidget {
  final Function(Airplane) onAddAirplane;

  AddAirplaneScreen({required this.onAddAirplane});

  @override
  _AddAirplaneScreenState createState() => _AddAirplaneScreenState();
}

class _AddAirplaneScreenState extends State<AddAirplaneScreen> {
  final _typeController = TextEditingController();
  final _passengersController = TextEditingController();
  final _maxSpeedController = TextEditingController();
  final _rangeController = TextEditingController();

  void _submitData() {
    final enteredType = _typeController.text;
    final enteredPassengers = int.tryParse(_passengersController.text) ?? 0;
    final enteredMaxSpeed = int.tryParse(_maxSpeedController.text) ?? 0;
    final enteredRange = int.tryParse(_rangeController.text) ?? 0;

    if (enteredType.isEmpty || enteredPassengers <= 0 || enteredMaxSpeed <= 0 || enteredRange <= 0) {
      return;
    }

    final newAirplane = Airplane(
      type: enteredType,
      numberOfPassengers: enteredPassengers,
      maxSpeed: enteredMaxSpeed,
      range: enteredRange,
    );

    widget.onAddAirplane(newAirplane);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Airplane'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: _passengersController,
              decoration: InputDecoration(labelText: 'Number of Passengers'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxSpeedController,
              decoration: InputDecoration(labelText: 'Max Speed (km/h)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _rangeController,
              decoration: InputDecoration(labelText: 'Range (km)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Add Airplane'),
            ),
          ],
        ),
      ),
    );
  }
}
