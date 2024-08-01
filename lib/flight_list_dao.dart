
import 'package:floor/floor.dart';
import 'flight_entity.dart';

@dao
abstract class FlightDao {
  @Query('SELECT * FROM FlightEntity')
  Future<List<FlightEntity>> findAllFlights();

  @Query('SELECT * FROM FlightEntity WHERE id = :id')
  Stream<FlightEntity?> findFlightById(int id);

  @insert
  Future<void> insertFlight(FlightEntity flight);

  @update
  Future<void> updateFlight(FlightEntity flight);

  @delete
  Future<void> deleteFlight(FlightEntity flight);
}