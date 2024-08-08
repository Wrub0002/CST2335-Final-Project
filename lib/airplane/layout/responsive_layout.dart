import 'package:flutter/material.dart';
import '../models/airplane.dart';
import '../views/airplane_details_view.dart';
import '../views/airplane_list_view.dart';
import '../services/airplane_service.dart';

class ResponsiveLayout extends StatefulWidget {
  final AirplaneService airplaneService;

  ResponsiveLayout({required this.airplaneService});

  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  Airplane? _selectedAirplane;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 720;

    return Scaffold(
      appBar: AppBar(
        title: Text('Airplanes'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: AirplaneListView(
              airplaneService: widget.airplaneService,
              onAirplaneSelected: (airplane) {
                setState(() {
                  _selectedAirplane = airplane;
                });
                if (!isLargeScreen) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AirplaneDetailsView(
                        airplane: airplane,
                        airplaneService: widget.airplaneService,
                        onAirplaneUpdated: () {},
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          if (isLargeScreen && _selectedAirplane != null)
            Expanded(
              flex: 2,
              child: AirplaneDetailsView(
                airplane: _selectedAirplane!,
                airplaneService: widget.airplaneService,
                onAirplaneUpdated: () {},
              ),
            ),
        ],
      ),
    );
  }
}
