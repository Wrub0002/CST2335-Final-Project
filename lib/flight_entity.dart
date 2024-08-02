import 'package:floor/floor.dart';

@entity
class FlightEntity {
  @primaryKey
  final int id;

  late final String departureCity;
  late final String arrivalCity;
  late final int departureTime;
  late final int arrivalTime;

  // Helper methods to convert timestamps back to DateTime
  DateTime get departureDateTime => DateTime.fromMillisecondsSinceEpoch(departureTime);
  DateTime get arrivalDateTime => DateTime.fromMillisecondsSinceEpoch(arrivalTime);

  FlightEntity(
      this.id,
      this.departureCity,
      this.arrivalCity,
      this.departureTime,
      this.arrivalTime,
      );

  // Factory constructor to create a new flight without managing ID
  factory FlightEntity.create(String departureCity, String arrivalCity, DateTime departureTime, DateTime arrivalTime) {
    return FlightEntity(
      1,
      departureCity,
      arrivalCity,
      departureTime.millisecondsSinceEpoch,
      arrivalTime.millisecondsSinceEpoch,
    );
  }
}
