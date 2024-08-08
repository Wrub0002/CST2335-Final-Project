import '../models/airplane.dart';
import '../services/airplane_service.dart';

class AirplaneController {
  final AirplaneService airplaneService;

  AirplaneController({required this.airplaneService});

  Future<List<Airplane>> getAllAirplanes() {
    return airplaneService.getAllAirplanes();
  }

  Future<void> addAirplane(Airplane airplane) {
    return airplaneService.addAirplane(airplane);
  }

  Future<void> updateAirplane(Airplane airplane) {
    return airplaneService.updateAirplane(airplane);
  }

  Future<void> deleteAirplane(int id) {
    return airplaneService.deleteAirplane(id);
  }
}
