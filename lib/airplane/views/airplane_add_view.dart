import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../services/airplane_service.dart';
import '../validators/airplane_validator.dart';
import '../widgets/custom_snackbar.dart';

class AirplaneAddView extends StatefulWidget {
  final AirplaneService airplaneService;

  AirplaneAddView({required this.airplaneService});

  @override
  _AirplaneAddViewState createState() => _AirplaneAddViewState();
}

class _AirplaneAddViewState extends State<AirplaneAddView> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _passengersController = TextEditingController();
  final _speedController = TextEditingController();
  final _rangeController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _passengersController.dispose();
    _speedController.dispose();
    _rangeController.dispose();
    super.dispose();
  }

  void _saveAirplane() async {
    if (_formKey.currentState!.validate()) {
      final airplane = Airplane(
        id: 0, // Assuming id is auto-generated
        type: _typeController.text,
        numberOfPassengers: int.parse(_passengersController.text),
        maxSpeed: double.parse(_speedController.text),
        range: double.parse(_rangeController.text),
      );
      await widget.airplaneService.addAirplane(airplane);
      CustomSnackbar.show(context, 'Airplane added successfully.');
      Navigator.of(context).pop();
    } else {
      CustomSnackbar.show(context, 'Please correct the errors and try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Airplane'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: AirplaneValidator.validateType,
              ),
              TextFormField(
                controller: _passengersController,
                decoration: InputDecoration(labelText: 'Number of Passengers'),
                keyboardType: TextInputType.number,
                validator: AirplaneValidator.validatePassengers,
              ),
              TextFormField(
                controller: _speedController,
                decoration: InputDecoration(labelText: 'Maximum Speed (km/h)'),
                keyboardType: TextInputType.number,
                validator: AirplaneValidator.validateSpeed,
              ),
              TextFormField(
                controller: _rangeController,
                decoration: InputDecoration(labelText: 'Range (km)'),
                keyboardType: TextInputType.number,
                validator: AirplaneValidator.validateRange,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAirplane,
                child: Text('Save Airplane'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
