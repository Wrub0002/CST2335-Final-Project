class RangeValidator {
  /// Validates the range.
  static String? validate(String? value) {
    final number = int.tryParse(value ?? '');
    if (number == null || number <= 0) {
      return 'Please enter a valid range (km).';
    }
    return null;
  }
}
