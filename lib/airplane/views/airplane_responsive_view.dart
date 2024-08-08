import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../services/airplane_service.dart';
import 'airplane_list_view.dart';
import 'airplane_details_view.dart';

class AirplaneResponsiveView extends StatefulWidget {
  final AirplaneService airplaneService;

  AirplaneResponsiveView({required this.airplaneService});

  @override
  _AirplaneResponsiveViewState createState() => _AirplaneResponsiveViewState();
}

class _AirplaneResponsiveViewState extends State<AirplaneResponsiveView> {
  Airplane? _selectedAirplane;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane Management'),
      ),
      body: isMobile
          ? AirplaneListView(
        airplaneService: widget.airplaneService,
        onAirplaneSelected: (airplane) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AirplaneDetailsView(
                airplane: airplane,
                airplaneService: widget.airplaneService,
                onAirplaneUpdated: _updateAirplaneList,
              ),
            ),
          );
        },
      )
          : Row(
        children: [
          Expanded(
            flex: 1,
            child: AirplaneListView(
              airplaneService: widget.airplaneService,
              onAirplaneSelected: (airplane) {
                setState(() {
                  _selectedAirplane = airplane;
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: _selectedAirplane != null
                ? AirplaneDetailsView(
              airplane: _selectedAirplane!,
              airplaneService: widget.airplaneService,
              onAirplaneUpdated: _updateAirplaneList,
            )
                : Center(child: Text('Select an airplane')),
          ),
        ],
      ),
    );
  }

  void _updateAirplaneList() {
    setState(() {
      // Refresh the airplane list or update any necessary state
    });
  }
}
