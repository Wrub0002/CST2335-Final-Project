import 'package:floor/floor.dart';
import 'airplane.dart';

@entity
class AirplaneEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id; // Make ID nullable and auto-generate

  final String type;
  final int numberOfPassengers;
  final double maxSpeed;
  final double range;

  AirplaneEntity({
    this.id, // ID is now optional and will be auto-generated
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });

  // Convert to DTO
  Airplane toAirplane() {
    return Airplane(
      id: id ?? 0, // Provide a fallback value if ID is null
      type: type,
      numberOfPassengers: numberOfPassengers,
      maxSpeed: maxSpeed,
      range: range,
    );
  }

  // Convert from DTO
  static AirplaneEntity fromAirplane(Airplane airplane) {
    return AirplaneEntity(
      type: airplane.type,
      numberOfPassengers: airplane.numberOfPassengers,
      maxSpeed: airplane.maxSpeed,
      range: airplane.range,
    );
  }
}
