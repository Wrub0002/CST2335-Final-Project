import 'package:floor/floor.dart';
import '../models/airplane_entity.dart';

@dao
abstract class AirplaneDao {
  @Query('SELECT * FROM AirplaneEntity')
  Future<List<AirplaneEntity>> findAllAirplanes();

  @Query('SELECT * FROM AirplaneEntity WHERE id = :id')
  Future<AirplaneEntity?> findAirplaneById(int id);

  @insert
  Future<void> insertAirplane(AirplaneEntity airplane);

  @update
  Future<void> updateAirplane(AirplaneEntity airplane);

  @delete
  Future<void> deleteAirplane(AirplaneEntity airplane);
}
