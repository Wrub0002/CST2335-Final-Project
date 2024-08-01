import 'package:floor/floor.dart';

@entity
class FlightEntity {
  //Initialise ID so there is never a null id
  static int ID = 1;

  late final String departureCity;
  late final String arrivalCity;

  //We store departure and arrival times as ints because floor does not accept Date.Time as a column
  //"Column type is not supported for DateTime."
  late final int departureTime;
  late final int arrivalTime;

  // Helper methods to convert timestamps back to DateTime
  DateTime get departureDateTime => DateTime.fromMillisecondsSinceEpoch(departureTime);
  DateTime get arrivalDateTime => DateTime.fromMillisecondsSinceEpoch(arrivalTime);

  @primaryKey
  final int id;

  FlightEntity(this.id, this.departureCity, this.arrivalCity, this.departureTime, this.arrivalTime) {
    if (id > ID) {
      ID = id + 1;
    }
  }

  // A factory constructor to create a new flight with an auto-incremented ID.
  factory FlightEntity.create(String departureCity, String arrivalCity, DateTime departureTime, DateTime arrivalTime) {
    return FlightEntity(
        ID++,
        departureCity,
        arrivalCity,
        departureTime.millisecondsSinceEpoch, // Convert DateTime to timestamp Int.
        arrivalTime.millisecondsSinceEpoch // Convert DateTime to timestamp Int.
    );
  }
}
