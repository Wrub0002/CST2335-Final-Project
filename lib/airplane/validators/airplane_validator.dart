class AirplaneValidator {
  static String? validateType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the airplane type';
    }
    return null;
  }

  static String? validatePassengers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the number of passengers';
    }
    final passengers = int.tryParse(value);
    if (passengers == null || passengers <= 0) {
      return 'Please enter a valid number of passengers';
    }
    return null;
  }

  static String? validateSpeed(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the maximum speed';
    }
    final speed = double.tryParse(value);
    if (speed == null || speed <= 0) {
      return 'Please enter a valid speed';
    }
    return null;
  }

  static String? validateRange(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the range';
    }
    final range = double.tryParse(value);
    if (range == null || range <= 0) {
      return 'Please enter a valid range';
    }
    return null;
  }
}
