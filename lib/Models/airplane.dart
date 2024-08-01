/// A class that represents an airplane with specific properties.
class Airplane {
  final String type;
  final int numberOfPassengers;
  final int maxSpeed;
  final int range;

  /// Creates an [Airplane] with the given properties.
  ///
  /// All parameters are required:
  Airplane({
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });
}
