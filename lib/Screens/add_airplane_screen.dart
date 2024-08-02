import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../validators/type_validator.dart';
import '../validators/passengers_validator.dart';
import '../validators/max_speed_validator.dart';
import '../validators/range_validator.dart';

/// A screen that allows users to add a new airplane to the list.
class AddAirplaneScreen extends StatefulWidget {
  final Function(Airplane) onAddAirplane;

  AddAirplaneScreen({required this.onAddAirplane});

  @override
  _AddAirplaneScreenState createState() => _AddAirplaneScreenState();
}

class _AddAirplaneScreenState extends State<AddAirplaneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _passengersController = TextEditingController();
  final _maxSpeedController = TextEditingController();
  final _rangeController = TextEditingController();

  /// Validates the form and submits the data if validation is successful.
  void _submitData() {
    if (_formKey.currentState?.validate() ?? false) {
      final newAirplane = Airplane(
        type: _typeController.text,
        numberOfPassengers: int.parse(_passengersController.text),
        maxSpeed: int.parse(_maxSpeedController.text),
        range: int.parse(_rangeController.text),
      );

      widget.onAddAirplane(newAirplane);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Airplane'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: TypeValidator.validate,
              ),
              TextFormField(
                controller: _passengersController,
                decoration: InputDecoration(labelText: 'Number of Passengers'),
                keyboardType: TextInputType.number,
                validator: PassengersValidator.validate,
              ),
              TextFormField(
                controller: _maxSpeedController,
                decoration: InputDecoration(labelText: 'Max Speed (km/h)'),
                keyboardType: TextInputType.number,
                validator: MaxSpeedValidator.validate,
              ),
              TextFormField(
                controller: _rangeController,
                decoration: InputDecoration(labelText: 'Range (km)'),
                keyboardType: TextInputType.number,
                validator: RangeValidator.validate,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Add Airplane'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _typeController.dispose();
    _passengersController.dispose();
    _maxSpeedController.dispose();
    _rangeController.dispose();
    super.dispose();
  }
}
