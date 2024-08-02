import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class SharedPreferencesService {
  final EncryptedSharedPreferences _prefs = EncryptedSharedPreferences();

  /// Save airplane details to EncryptedSharedPreferences
  Future<void> saveAirplane({
    required String type,
    required int numberOfPassengers,
    required int maxSpeed,
    required int range,
  }) async {
    await _prefs.setString('lastType', type);
    await _prefs.setString('lastPassengers', numberOfPassengers.toString());
    await _prefs.setString('lastMaxSpeed', maxSpeed.toString());
    await _prefs.setString('lastRange', range.toString());
  }

  /// Load airplane details from EncryptedSharedPreferences
  Future<Map<String, dynamic>?> loadAirplane() async {
    String? type = await _prefs.getString('lastType');
    String? passengers = await _prefs.getString('lastPassengers');
    String? maxSpeed = await _prefs.getString('lastMaxSpeed');
    String? range = await _prefs.getString('lastRange');

    if (type != null && passengers != null && maxSpeed != null && range != null) {
      return {
        'type': type,
        'numberOfPassengers': int.parse(passengers),
        'maxSpeed': int.parse(maxSpeed),
        'range': int.parse(range),
      };
    }
    return null;
  }

  /// Remove saved airplane details from EncryptedSharedPreferences
  Future<void> removeSavedAirplane() async {
    await _prefs.remove('lastType');
    await _prefs.remove('lastPassengers');
    await _prefs.remove('lastMaxSpeed');
    await _prefs.remove('lastRange');
  }
}
