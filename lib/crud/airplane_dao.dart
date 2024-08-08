import 'package:floor/floor.dart';
import '../models/airplane.dart';

@dao
abstract class AirplaneDao {
  @Query('SELECT * FROM Airplane')
  Future<List<Airplane>> findAllAirplanes();

  @Query('SELECT * FROM Airplane WHERE id = :id')
  Future<Airplane?> findAirplaneById(int id);

  @insert
  Future<int> insertAirplane(Airplane airplane); 

  @update
  Future<void> updateAirplane(Airplane airplane);

  @delete
  Future<void> deleteAirplane(Airplane airplane);
}
