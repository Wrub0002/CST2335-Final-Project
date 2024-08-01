import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'flight_entity.dart';
import 'flight_list_dao.dart';
import 'flight_list_db.dart';

class FlightListPage extends StatefulWidget {
  final FlightDao flightDao;

  // Modified constructor to accept FlightDao instance
  FlightListPage({required this.flightDao});

  @override
  _FlightListPageState createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  final TextEditingController _departureCityController = TextEditingController();
  final TextEditingController _arrivalCityController = TextEditingController();
  DateTime? _departureDate;
  DateTime? _arrivalDate;

  String? _departureCityError;
  String? _arrivalCityError;
  String? _departureDateError;
  String? _arrivalDateError;

  List<FlightEntity> _flights = [];

  @override
  void initState() {
    super.initState();
    _loadFlights();
  }

  Future<void> _loadFlights() async {
    final flights = await widget.flightDao.findAllFlights();
    setState(() {
      _flights = flights;
    });
  }

  bool _validateFields() {
    bool isValid = true;

    setState(() {
      if (_departureCityController.text.isEmpty) {
        _departureCityError = 'Please enter the departure city';
        isValid = false;
      } else {
        _departureCityError = null;
      }

      if (_arrivalCityController.text.isEmpty) {
        _arrivalCityError = 'Please enter the arrival city';
        isValid = false;
      } else {
        _arrivalCityError = null;
      }

      if (_departureDate == null) {
        _departureDateError = 'Please select the departure date';
        isValid = false;
      } else {
        _departureDateError = null;
      }

      if (_arrivalDate == null) {
        _arrivalDateError = 'Please select the arrival date';
        isValid = false;
      } else {
        _arrivalDateError = null;
      }
    });

    return isValid;
  }

  Future<void> _showFlightDialog(FlightEntity flight) async {
    TextEditingController _editDepartureCityController = TextEditingController(text: flight.departureCity);
    TextEditingController _editArrivalCityController = TextEditingController(text: flight.arrivalCity);
    DateTime? _editDepartureDate = flight.departureDateTime;
    DateTime? _editArrivalDate = flight.arrivalDateTime;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Flight Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editDepartureCityController,
                decoration: InputDecoration(labelText: 'Departure City'),
              ),
              TextField(
                controller: _editArrivalCityController,
                decoration: InputDecoration(labelText: 'Arrival City'),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Departure Date',
                  hintText: DateFormat('yyyy-MM-dd').format(_editDepartureDate!),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _editDepartureDate!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _editDepartureDate = pickedDate;
                    });
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Arrival Date',
                  hintText: DateFormat('yyyy-MM-dd').format(_editArrivalDate!),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _editArrivalDate!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _editArrivalDate = pickedDate;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                flight.departureCity = _editDepartureCityController.text;
                flight.arrivalCity = _editArrivalCityController.text;
                flight.departureTime = _editDepartureDate!.millisecondsSinceEpoch;
                flight.arrivalTime = _editArrivalDate!.millisecondsSinceEpoch;
                await widget.flightDao.updateFlight(flight);
                _loadFlights();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () async {
                await widget.flightDao.deleteFlight(flight);
                _loadFlights();
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight List Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _departureCityController,
              decoration: InputDecoration(
                labelText: 'Departure City',
                errorText: _departureCityError,
              ),
            ),
            TextField(
              controller: _arrivalCityController,
              decoration: InputDecoration(
                labelText: 'Arrival City',
                errorText: _arrivalCityError,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _departureDate = pickedDate;
                          _departureDateError = null;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Departure Date',
                          errorText: _departureDateError,
                          hintText: _departureDate == null ? '' : DateFormat('yyyy-MM-dd').format(_departureDate!),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _arrivalDate = pickedDate;
                          _arrivalDateError = null;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Arrival Date',
                          errorText: _arrivalDateError,
                          hintText: _arrivalDate == null ? '' : DateFormat('yyyy-MM-dd').format(_arrivalDate!),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_validateFields()) {
                  FlightEntity flight = FlightEntity.create(
                    _departureCityController.text,
                    _arrivalCityController.text,
                    _departureDate!,
                    _arrivalDate!,
                  );
                  // Save the flight information using the provided FlightDao instance
                  await widget.flightDao.insertFlight(flight);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Flight information saved')),
                  );
                  _loadFlights(); // Refresh the list
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _flights.length,
                itemBuilder: (context, index) {
                  final flight = _flights[index];
                  return ListTile(
                    title: Text('${flight.departureCity} to ${flight.arrivalCity}'),
                    subtitle: Text(
                        'Departure: ${DateFormat('yyyy-MM-dd').format(flight.departureDateTime)}\nArrival: ${DateFormat('yyyy-MM-dd').format(flight.arrivalDateTime)}'),
                    onTap: () => _showFlightDialog(flight),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
