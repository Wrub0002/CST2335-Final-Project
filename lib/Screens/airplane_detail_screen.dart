import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../validators/type_validator.dart';
import '../validators/passengers_validator.dart';
import '../validators/max_speed_validator.dart';
import '../validators/range_validator.dart';

/// A screen that displays the details of an existing airplane and allows the user to update or delete it.
class AirplaneDetailScreen extends StatefulWidget {
  final Airplane airplane;
  final Function(Airplane) onUpdateAirplane;
  final Function(Airplane) onDeleteAirplane;
  /// Constructs an [AirplaneDetailScreen] with the required [airplane], [onUpdateAirplane], and [onDeleteAirplane] parameters.
  AirplaneDetailScreen({
    required this.airplane,
    required this.onUpdateAirplane,
    required this.onDeleteAirplane,
  });

  @override
  _AirplaneDetailScreenState createState() => _AirplaneDetailScreenState();
}

class _AirplaneDetailScreenState extends State<AirplaneDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _typeController;
  late TextEditingController _passengersController;
  late TextEditingController _maxSpeedController;
  late TextEditingController _rangeController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.airplane.type);
    _passengersController = TextEditingController(text: widget.airplane.numberOfPassengers.toString());
    _maxSpeedController = TextEditingController(text: widget.airplane.maxSpeed.toString());
    _rangeController = TextEditingController(text: widget.airplane.range.toString());
  }

  /// Validates the form and updates the airplane if validation is successful.
  void _updateAirplane() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedAirplane = Airplane(
        type: _typeController.text,
        numberOfPassengers: int.parse(_passengersController.text),
        maxSpeed: int.parse(_maxSpeedController.text),
        range: int.parse(_rangeController.text),
      );

      widget.onUpdateAirplane(updatedAirplane);
      Navigator.of(context).pop();
    }
  }
  /// Deletes the airplane by invoking the [onDeleteAirplane] callback and closes the screen.
  void _deleteAirplane() {
    widget.onDeleteAirplane(widget.airplane);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.airplane.type} Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Airplane'),
                  content: Text('Are you sure you want to delete this airplane?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _deleteAirplane();
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('No'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                onPressed: _updateAirplane,
                child: Text('Update Airplane'),
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
