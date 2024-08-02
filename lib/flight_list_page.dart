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

  void _showFlightDetails(FlightEntity flight) {
    // Implement the logic to navigate to the flight details page
    // This could involve opening a new screen showing the details of the selected flight.
    // For demonstration, we'll just show a simple dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Flight Details'),
        content: Text(
            'Departure: ${flight.departureCity} -> Arrival: ${flight.arrivalCity}\n'
                'Departure Time: ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(flight.departureTime))}\n'
                'Arrival Time: ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(flight.arrivalTime))}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
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
