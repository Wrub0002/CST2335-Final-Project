/// Represents an airplane with various attributes.
class Airplane {
  final int id;
  final String type;
  final int numberOfPassengers;
  final double maxSpeed;
  final double range;

  /// Creates a new instance of [Airplane] with the given parameters.
  Airplane({
    required this.id,
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });

  /// Converts the [Airplane] instance to a [Map] representation.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'numberOfPassengers': numberOfPassengers,
      'maxSpeed': maxSpeed,
      'range': range,
    };
  }

  /// Creates an [Airplane] instance from a [Map].
  factory Airplane.fromMap(Map<String, dynamic> map) {
    return Airplane(
      id: map['id'] ?? 0,
      type: map['type'] ?? '',
      numberOfPassengers: map['numberOfPassengers'] ?? 0,
      maxSpeed: map['maxSpeed'] ?? 0.0,
      range: map['range'] ?? 0.0,
    );
  }
}
