import 'package:flutter/material.dart';
import 'flight_entity.dart';
import 'flight_list_dao.dart';
import 'package:intl/intl.dart';

class FlightListPage extends StatefulWidget {
  final FlightDao flightDao;

  FlightListPage({Key? key, required this.flightDao}) : super(key: key);

  @override
  _FlightListPageState createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  final TextEditingController _departureCityController = TextEditingController();
  final TextEditingController _arrivalCityController = TextEditingController();
  final TextEditingController _departureDateController = TextEditingController();
  final TextEditingController _arrivalDateController = TextEditingController();
  DateTime? _selectedDepartureDate;
  DateTime? _selectedArrivalDate;

  @override
  void initState() {
    super.initState();
    _loadFlights();
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _selectedDepartureDate = picked;
          _departureDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          _selectedArrivalDate = picked;
          _arrivalDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  Future<void> _addFlight() async {
    final String departureCity = _departureCityController.text;
    final String arrivalCity = _arrivalCityController.text;

    if (departureCity.isEmpty || arrivalCity.isEmpty || _selectedDepartureDate == null || _selectedArrivalDate == null) {
      // Show an error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill all fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final int departureTime = _selectedDepartureDate!.millisecondsSinceEpoch;
    final int arrivalTime = _selectedArrivalDate!.millisecondsSinceEpoch;

    final flight = FlightEntity(
      null, // Assuming `id` is auto-incremented
      departureCity,
      arrivalCity,
      departureTime,
      arrivalTime,
    );

    await widget.flightDao.insertFlight(flight);

    // Clear the input fields
    _departureCityController.clear();
    _arrivalCityController.clear();
    _departureDateController.clear();
    _arrivalDateController.clear();
    setState(() {
      _selectedDepartureDate = null;
      _selectedArrivalDate = null;
    });

    // Refresh the list of flights
    _loadFlights();
  }

  Future<void> _loadFlights() async {
    setState(() {});
  }

  Future<void> _deleteFlight(FlightEntity flight) async {
    await widget.flightDao.deleteFlight(flight);
    _loadFlights();
  }

  Future<void> _updateFlight(FlightEntity flight) async {
    final String departureCity = _departureCityController.text;
    final String arrivalCity = _arrivalCityController.text;
    final int departureTime = _selectedDepartureDate!.millisecondsSinceEpoch;
    final int arrivalTime = _selectedArrivalDate!.millisecondsSinceEpoch;

    final updatedFlight = FlightEntity(
      flight.id,
      departureCity,
      arrivalCity,
      departureTime,
      arrivalTime,
    );

    await widget.flightDao.updateFlight(updatedFlight);
    _loadFlights();
  }

  void _showFlightDetails(FlightEntity flight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Flight Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Departure: ${flight.departureCity} -> Arrival: ${flight.arrivalCity}'),
            Text('Departure Time: ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(flight.departureTime))}'),
            Text('Arrival Time: ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(flight.arrivalTime))}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => _showUpdateFlightDialog(flight),
            child: Text('Update'),
          ),
          TextButton(
            onPressed: () => _confirmDeleteFlight(flight),
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteFlight(FlightEntity flight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this flight?'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteFlight(flight);
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Close the details dialog
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showUpdateFlightDialog(FlightEntity flight) {
    _departureCityController.text = flight.departureCity;
    _arrivalCityController.text = flight.arrivalCity;
    _selectedDepartureDate = DateTime.fromMillisecondsSinceEpoch(flight.departureTime);
    _selectedArrivalDate = DateTime.fromMillisecondsSinceEpoch(flight.arrivalTime);
    _departureDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDepartureDate!);
    _arrivalDateController.text = DateFormat('yyyy-MM-dd').format(_selectedArrivalDate!);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Flight'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _departureCityController,
              decoration: InputDecoration(labelText: 'Departure City'),
            ),
            TextField(
              controller: _arrivalCityController,
              decoration: InputDecoration(labelText: 'Arrival City'),
            ),
            TextField(
              controller: _departureDateController,
              decoration: InputDecoration(
                labelText: 'Departure Date',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, true),
                ),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, true),
            ),
            TextField(
              controller: _arrivalDateController,
              decoration: InputDecoration(
                labelText: 'Arrival Date',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, false),
                ),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, false),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _updateFlight(flight);
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Close the details dialog
            },
            child: Text('Confirm'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _departureCityController,
                  decoration: InputDecoration(
                    labelText: 'Departure City',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _arrivalCityController,
                  decoration: InputDecoration(
                    labelText: 'Arrival City',
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _departureDateController,
                        decoration: InputDecoration(
                          labelText: 'Departure Date',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context, true),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, true),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _arrivalDateController,
                        decoration: InputDecoration(
                          labelText: 'Arrival Date',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context, false),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, false),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addFlight,
                  child: Text('Add Flight'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<FlightEntity>>(
              future: widget.flightDao.findAllFlights(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No flights available'));
                } else {
                  final flights = snapshot.data!;
                  return ListView.builder(
                    itemCount: flights.length,
                    itemBuilder: (context, index) {
                      final flight = flights[index];
                      return ListTile(
                        title: Text('${flight.departureCity} -> ${flight.arrivalCity}'),
                        subtitle: Text('Departure: ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(flight.departureTime))}'),
                        onTap: () => _showFlightDetails(flight),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
