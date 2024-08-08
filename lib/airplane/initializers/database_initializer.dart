import '../repositories/airplane_repository.dart';
import '../services/airplane_service.dart';
import '../repositories/database.dart';

/// A utility class responsible for initializing the database and related services.
class DatabaseInitializer {
  static Future<AirplaneService> initializeAirplaneService() async {
    final database = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build();

    final airplaneDao = database.airplaneDao;
    final airplaneRepository = AirplaneRepository(airplaneDao);

    return AirplaneService(airplaneRepository);
  }
}
