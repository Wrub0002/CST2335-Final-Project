import 'package:flutter/material.dart';
import '../models/airplane.dart';
import 'airplane_edit_view.dart';
import '../services/airplane_service.dart';
import '../localization/app_localizations.dart';

class AirplaneDetailsView extends StatelessWidget {
  final Airplane airplane;
  final AirplaneService airplaneService;
  final VoidCallback onAirplaneUpdated;

  AirplaneDetailsView({
    required this.airplane,
    required this.airplaneService,
    required this.onAirplaneUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(airplane.type),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => AirplaneEditView(
                  airplane: airplane,
                  airplaneService: airplaneService,
                  onAirplaneUpdated: onAirplaneUpdated,
                ),
              ))
                  .then((_) => onAirplaneUpdated());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context)?.translate('airplane_type')}: ${airplane.type}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('${AppLocalizations.of(context)?.translate('number_of_passengers')}: ${airplane.numberOfPassengers}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('${AppLocalizations.of(context)?.translate('max_speed')}: ${airplane.maxSpeed} km/h', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('${AppLocalizations.of(context)?.translate('range')}: ${airplane.range} km', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
