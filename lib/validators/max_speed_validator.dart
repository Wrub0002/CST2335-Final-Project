class MaxSpeedValidator {
  /// Validates the max speed.
  static String? validate(String? value) {
    final number = int.tryParse(value ?? '');
    if (number == null || number <= 0) {
      return 'Please enter a valid max speed (km/h).';
    }
    return null;
  }
}
