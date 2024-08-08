import '../models/airplane.dart';
import '../models/airplane_entity.dart';
import '../repositories/airplane_repository.dart';

class AirplaneService {
  final AirplaneRepository _repository;

  AirplaneService(this._repository);

  // Add a new airplane
  Future<void> addAirplane(Airplane airplane) async {
    final entity = AirplaneEntity(
      type: airplane.type,
      numberOfPassengers: airplane.numberOfPassengers,
      maxSpeed: airplane.maxSpeed,
      range: airplane.range,
    );
    await _repository.insertAirplane(entity);
  }

  // Get all airplanes
  Future<List<Airplane>> getAllAirplanes() async {
    final entities = await _repository.getAllAirplanes();
    return entities.map((entity) => entity.toAirplane()).toList();
  }

  // Get a specific airplane by its ID
  Future<Airplane?> getAirplaneById(int id) async {
    final entity = await _repository.getAirplaneById(id);
    return entity?.toAirplane();
  }

  // Update an existing airplane
  Future<void> updateAirplane(Airplane airplane) async {
    final entity = AirplaneEntity(
      id: airplane.id,
      type: airplane.type,
      numberOfPassengers: airplane.numberOfPassengers,
      maxSpeed: airplane.maxSpeed,
      range: airplane.range,
    );
    await _repository.updateAirplane(entity);
  }

  // Delete an airplane
  Future<void> deleteAirplane(Airplane airplane) async {
    final entity = AirplaneEntity(
      id: airplane.id,
      type: airplane.type,
      numberOfPassengers: airplane.numberOfPassengers,
      maxSpeed: airplane.maxSpeed,
      range: airplane.range,
    );
    await _repository.deleteAirplane(entity);
  }
}
