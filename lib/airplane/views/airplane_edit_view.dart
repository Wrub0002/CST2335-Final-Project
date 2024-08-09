import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../services/airplane_service.dart';
import '../validators/airplane_validator.dart';
import '../widgets/custom_snackbar.dart';

class AirplaneEditView extends StatefulWidget {
  final Airplane airplane;
  final AirplaneService airplaneService;
  final VoidCallback onAirplaneUpdated;

  AirplaneEditView({
    required this.airplane,
    required this.airplaneService,
    required this.onAirplaneUpdated,
  });

  @override
  _AirplaneEditViewState createState() => _AirplaneEditViewState();
}

class _AirplaneEditViewState extends State<AirplaneEditView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _typeController;
  late TextEditingController _passengersController;
  late TextEditingController _speedController;
  late TextEditingController _rangeController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.airplane.type);
    _passengersController = TextEditingController(text: widget.airplane.numberOfPassengers.toString());
    _speedController = TextEditingController(text: widget.airplane.maxSpeed.toString());
    _rangeController = TextEditingController(text: widget.airplane.range.toString());
  }

  @override
  void dispose() {
    _typeController.dispose();
    _passengersController.dispose();
    _speedController.dispose();
    _rangeController.dispose();
    super.dispose();
  }

  void _updateAirplane() async {
    if (_formKey.currentState!.validate()) {
      final updatedAirplane = Airplane(
        id: widget.airplane.id,
        type: _typeController.text,
        numberOfPassengers: int.parse(_passengersController.text),
        maxSpeed: double.parse(_speedController.text),
        range: double.parse(_rangeController.text),
      );
      await widget.airplaneService.updateAirplane(updatedAirplane);
      CustomSnackbar.show(context, 'Airplane updated successfully.');
      widget.onAirplaneUpdated();  // Refresh the list
      Navigator.of(context).pop();  // Go back to the list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Airplane'),
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
                onPressed: _updateAirplane,
                child: Text('Update Airplane'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
