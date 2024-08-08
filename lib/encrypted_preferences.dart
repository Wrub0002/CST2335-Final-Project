import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptedPreferences {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _departureCityKey = 'departureCity';
  static const String _arrivalCityKey = 'arrivalCity';

  Future<void> saveLastDepartureCity(String city) async {
    await _storage.write(key: _departureCityKey, value: city);
  }

  Future<void> saveLastArrivalCity(String city) async {
    await _storage.write(key: _arrivalCityKey, value: city);
  }

  Future<String?> getLastDepartureCity() async {
    return await _storage.read(key: _departureCityKey);
  }

  Future<String?> getLastArrivalCity() async {
    return await _storage.read(key: _arrivalCityKey);
  }
}
