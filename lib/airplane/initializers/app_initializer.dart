import '../services/airplane_service.dart';
import 'database_initializer.dart';

/// A utility class responsible for initializing the application's services.
class AppInitializer {
  static Future<AirplaneService> initializeAirplaneService() async {
    return await DatabaseInitializer.initializeAirplaneService();
  }
}
