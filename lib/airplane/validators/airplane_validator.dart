
/// A utility class that provides validation methods for airplane-related fields.
class AirplaneValidator {
  static String? validateType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the airplane type.';
    }
    if (value.length < 3) {
      return 'The airplane type must be at least 3 characters long.';
    }
    return null;
  }

  static String? validatePassengers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the number of passengers.';
    }
    final numberOfPassengers = int.tryParse(value);
    if (numberOfPassengers == null || numberOfPassengers <= 0) {
      return 'Please enter a valid number of passengers.';
    }
    return null;
  }

  static String? validateSpeed(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the maximum speed.';
    }
    final maxSpeed = double.tryParse(value);
    if (maxSpeed == null || maxSpeed <= 0) {
      return 'Please enter a valid maximum speed.';
    }
    return null;
  }

  static String? validateRange(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the range.';
    }
    final range = double.tryParse(value);
    if (range == null || range <= 0) {
      return 'Please enter a valid range.';
    }
    return null;
  }
}
