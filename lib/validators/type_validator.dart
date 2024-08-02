class TypeValidator {
  /// Validates the airplane type.
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an airplane type.';
    }
    final regex = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!regex.hasMatch(value)) {
      return 'Type can only contain letters, numbers, and spaces.';
    }
    return null;
  }
}
