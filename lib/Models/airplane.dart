import 'package:floor/floor.dart';

@entity
class Airplane {
  @primaryKey
  final int? id;
  final String type;
  final int numberOfPassengers;
  final int maxSpeed;
  final int range;

  Airplane({
    required this.id,
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });
}
