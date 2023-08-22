/// Represents a rack.
class Rack {
  /// The route associated with the rack.
  String route;

  /// The rack name.
  String rack;

  /// The color of the route associated with the rack.
  String routeColor;

  /// Creates a [Rack] instance.
  ///
  /// The [routeColor] is the color of the route associated with the rack.
  /// The [route] is the route associated with the rack.
  /// The [rack] is the rack name.
  Rack({
    required this.routeColor,
    required this.route,
    required this.rack,
  });

  /// Converts the [Rack] instance to a JSON map.
  Map<String, dynamic> tojson() {
    return {
      'routeColor': routeColor,
      'route': route,
      'rack': rack,
    };
  }

  /// Creates a [Rack] instance from a JSON map.
  factory Rack.fromjson(Map<String, dynamic> json) {
    return Rack(
      routeColor: json['routeColor'],
      route: json['route'],
      rack: json['rack'],
    );
  }
}
