import 'package:flutter/material.dart';

void main() {
  runApp(AirplaneApp());
}

class AirplaneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AirplaneListPage(),
    );
  }
}

class AirplaneListPage extends StatefulWidget {
  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  final List<String> airplanes = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    airplanes.add(_controller.text);
                    _controller.clear();
                  });
                },
                child: Text('Add Airplane'),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter airplane type',
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: airplanes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      airplanes.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(airplanes[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
