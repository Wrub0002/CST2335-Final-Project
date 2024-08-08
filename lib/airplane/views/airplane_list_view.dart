import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../services/airplane_service.dart';
import '../widgets/custom_snackbar.dart';
import 'airplane_details_view.dart';
import 'airplane_add_view.dart';

class AirplaneListView extends StatefulWidget {
  final AirplaneService airplaneService;
  final Function(Airplane) onAirplaneSelected; // Callback function for selection

  AirplaneListView({
    required this.airplaneService,
    required this.onAirplaneSelected,
  });

  @override
  _AirplaneListViewState createState() => _AirplaneListViewState();
}

class _AirplaneListViewState extends State<AirplaneListView> {
  late Future<List<Airplane>> _airplanesFuture;

  @override
  void initState() {
    super.initState();
    _loadAirplanes();
  }

  void _loadAirplanes() {
    setState(() {
      _airplanesFuture = widget.airplaneService.getAllAirplanes();
    });
  }

  Future<void> _navigateToAddAirplane() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AirplaneAddView(airplaneService: widget.airplaneService),
      ),
    );
    _loadAirplanes();
  }

  void _deleteAirplane(Airplane airplane) async {
    await widget.airplaneService.deleteAirplane(airplane.id);
    CustomSnackbar.show(context, 'Airplane deleted successfully.');
    _loadAirplanes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplanes'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInstructions,
          ),
        ],
      ),
      body: FutureBuilder<List<Airplane>>(
        future: _airplanesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading airplanes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No airplanes available'));
          }

          final airplanes = snapshot.data!;

          return ListView.builder(
            itemCount: airplanes.length,
            itemBuilder: (context, index) {
              final airplane = airplanes[index];
              return ListTile(
                title: Text(airplane.type),
                subtitle: Text('Passengers: ${airplane.numberOfPassengers}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteAirplane(airplane),
                    ),
                  ],
                ),
                onTap: () => widget.onAirplaneSelected(airplane), // Trigger callback on selection
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddAirplane,
        child: Icon(Icons.add),
        tooltip: 'Add Airplane',
      ),
    );
  }

  void _showInstructions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Instructions'),
        content: Text(
          '1. Add a new airplane by tapping the "+" button.\n'
              '2. View airplane details by tapping on an airplane in the list.\n'
              '3. Edit airplane details on the edit page.\n'
              '4. Delete an airplane using the trash icon next to the airplane name in the list.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
