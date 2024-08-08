import '../models/airplane_entity.dart';
import '../repositories/airplane_dao.dart';

class AirplaneRepository {
  final AirplaneDao _dao;

  AirplaneRepository(this._dao);

  // Insert a new airplane into the database
  Future<void> insertAirplane(AirplaneEntity airplane) async {
    await _dao.insertAirplane(airplane);
  }

  // Retrieve all airplanes from the database
  Future<List<AirplaneEntity>> getAllAirplanes() async {
    return await _dao.findAllAirplanes();
  }

  // Retrieve a specific airplane by its ID
  Future<AirplaneEntity?> getAirplaneById(int id) async {
    return await _dao.findAirplaneById(id);
  }

  // Update an existing airplane in the database
  Future<void> updateAirplane(AirplaneEntity airplane) async {
    await _dao.updateAirplane(airplane);
  }

  // Delete an airplane from the database
  Future<void> deleteAirplane(AirplaneEntity airplane) async {
    await _dao.deleteAirplane(airplane);
  }
}
