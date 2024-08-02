class PassengersValidator {
  /// Validates the number of passengers.
  static String? validate(String? value) {
    final number = int.tryParse(value ?? '');
    if (number == null || number <= 0) {
      return 'Please enter a valid number of passengers.';
    }
    return null;
  }
}
