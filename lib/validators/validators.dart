/// A utility class for validating airplane input fields.
class Validators {
  /// Validates the airplane type.
  static String? validateType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an airplane type.';
    }
    final regex = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!regex.hasMatch(value)) {
      return 'Type can only contain letters, numbers, and spaces.';
    }
    return null;
  }

  /// Validates the number of passengers.
  static String? validatePassengers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the number of passengers.';
    }
    final number = int.tryParse(value);
    if (number == null || number <= 0) {
      return 'Please enter a valid number of passengers.';
    }
    return null;
  }

  /// Validates the max speed.
  static String? validateMaxSpeed(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the max speed (km/h).';
    }
    final number = int.tryParse(value);
    if (number == null || number <= 0) {
      return 'Please enter a valid max speed (km/h).';
    }
    return null;
  }

  /// Validates the range.
  static String? validateRange(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the range (km).';
    }
    final number = int.tryParse(value);
    if (number == null || number <= 0) {
      return 'Please enter a valid range (km).';
    }
    return null;
  }
}
