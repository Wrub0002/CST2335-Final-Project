import 'package:floor/floor.dart';
import 'airplane.dart';

@entity
class AirplaneEntity {
  @primaryKey
  final int? id; // Make ID nullable to allow auto-increment
  final String type;
  final int numberOfPassengers;
  final double maxSpeed;
  final double range;

  AirplaneEntity({
    this.id, // ID is nullable, so the database can auto-generate it
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });

  // Convert to DTO (Data Transfer Object)
  Airplane toAirplane() {
    return Airplane(
      id: id ?? 0, // Ensure a valid ID is returned
      type: type,
      numberOfPassengers: numberOfPassengers,
      maxSpeed: maxSpeed,
      range: range,
    );
  }

  // Convert from DTO
  static AirplaneEntity fromAirplane(Airplane airplane) {
    return AirplaneEntity(
      id: airplane.id > 0 ? airplane.id : null, // If the ID is 0, allow the database to auto-generate it
      type: airplane.type,
      numberOfPassengers: airplane.numberOfPassengers,
      maxSpeed: airplane.maxSpeed,
      range: airplane.range,
    );
  }
}
