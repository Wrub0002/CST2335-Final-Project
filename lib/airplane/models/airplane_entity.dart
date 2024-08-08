import 'package:floor/floor.dart';
import 'airplane.dart';

@entity
class AirplaneEntity {
  @primaryKey
  final int id;
  final String type;
  final int numberOfPassengers;
  final double maxSpeed;
  final double range;

  AirplaneEntity({
    required this.id,
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });

  // Convert to DTO (Data Transfer Object)
  Airplane toAirplane() {
    return Airplane(
      id: id,
      type: type,
      numberOfPassengers: numberOfPassengers,
      maxSpeed: maxSpeed,
      range: range,
    );
  }

  // Convert from DTO
  static AirplaneEntity fromAirplane(Airplane airplane) {
    return AirplaneEntity(
      id: airplane.id,
      type: airplane.type,
      numberOfPassengers: airplane.numberOfPassengers,
      maxSpeed: airplane.maxSpeed,
      range: airplane.range,
    );
  }
}
