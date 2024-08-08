import 'package:floor/floor.dart';
import 'airplane.dart';

/// Represents an entity for storing airplane data in the database.
@entity
class AirplaneEntity {
  @primaryKey
  final int id;
  final String type;
  final int numberOfPassengers;
  final double maxSpeed;
  final double range;

  /// Creates a new instance of [AirplaneEntity] with the given parameters.
  AirplaneEntity({
    required this.id,
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });

  /// Converts this [AirplaneEntity] instance to an [Airplane] data model.
  Airplane toAirplane() {
    return Airplane(
      id: id,
      type: type,
      numberOfPassengers: numberOfPassengers,
      maxSpeed: maxSpeed,
      range: range,
    );
  }

  /// Converts an [Airplane] data model to an [AirplaneEntity].
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
