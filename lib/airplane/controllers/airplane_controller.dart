import '../models/airplane.dart';
import '../services/airplane_service.dart';

/// Controller class for managing airplane-related operations.
/// Acts as a bridge between the UI and the service layer.
class AirplaneController {
  final AirplaneService airplaneService;

  /// Constructor for AirplaneController, requires an instance of AirplaneService.
  AirplaneController({required this.airplaneService});

  /// Retrieves a list of all airplanes.
  Future<List<Airplane>> getAllAirplanes() {
    return airplaneService.getAllAirplanes();
  }

  /// Adds a new airplane.
  Future<void> addAirplane(Airplane airplane) {
    return airplaneService.addAirplane(airplane);
  }

  /// Updates an existing airplane.
  Future<void> updateAirplane(Airplane airplane) {
    return airplaneService.updateAirplane(airplane);
  }

  /// Deletes an airplane by its ID.
  Future<void> deleteAirplane(int id) {
    return airplaneService.deleteAirplane(id);
  }
}
