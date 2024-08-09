import '../repositories/airplane_repository.dart';
import '../services/airplane_service.dart';
import '../repositories/database.dart';

class DatabaseInitializer {
  static Future<AirplaneService> initializeAirplaneService() async {
    // Initialize the database
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    // Initialize the DAO and repository
    final airplaneDao = database.airplaneDao;
    final airplaneRepository = AirplaneRepository(airplaneDao);

    // Initialize and return the service
    return AirplaneService(airplaneRepository);
  }
}
