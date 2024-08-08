import '../models/airplane.dart';
import '../repositories/airplane_repository.dart';
import '../models/airplane_entity.dart';

class AirplaneService {
  final AirplaneRepository airplaneRepository;

  AirplaneService(this.airplaneRepository);

  Future<List<Airplane>> getAllAirplanes() async {
    final entities = await airplaneRepository.getAllAirplanes();
    return entities.map((entity) => entity.toAirplane()).toList();
  }

  Future<Airplane?> getAirplaneById(int id) async {
    final entity = await airplaneRepository.getAirplaneById(id);
    return entity?.toAirplane();
  }

  Future<void> addAirplane(Airplane airplane) async {
    final entity = AirplaneEntity.fromAirplane(airplane);
    await airplaneRepository.insertAirplane(entity);
  }

  Future<void> updateAirplane(Airplane airplane) async {
    final entity = AirplaneEntity(
      id: airplane.id,
      type: airplane.type,
      numberOfPassengers: airplane.numberOfPassengers,
      maxSpeed: airplane.maxSpeed,
      range: airplane.range,
    );
    await airplaneRepository.updateAirplane(entity);
  }

  Future<void> deleteAirplane(int id) async {
    final airplane = await getAirplaneById(id);
    if (airplane != null) {
      final entity = AirplaneEntity.fromAirplane(airplane);
      await airplaneRepository.deleteAirplane(entity);
    }
  }
}
