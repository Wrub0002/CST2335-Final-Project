import 'package:floor/floor.dart';

@entity
class FlightEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String departureCity;
  final String arrivalCity;
  final int departureTime;
  final int arrivalTime;

  FlightEntity(
      this.id,
      this.departureCity,
      this.arrivalCity,
      this.departureTime,
      this.arrivalTime,
      );
}
