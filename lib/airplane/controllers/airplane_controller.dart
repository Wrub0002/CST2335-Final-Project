import '../models/airplane.dart';
import '../services/airplane_service.dart';

/// A controller for managing airplane-related operations.
///
/// This class provides methods for interacting with the [AirplaneService]
/// to perform CRUD (Create, Read, Update, Delete) operations on airplanes.
class AirplaneController {
  final AirplaneService airplaneService;

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
