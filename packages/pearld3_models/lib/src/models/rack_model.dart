class Rack {
  String route;
  String rack;
  String routeColor;

  Rack({
    required this.routeColor,
    required this.route,
    required this.rack,
  });

  Map<String, dynamic> tojson() {
    return {
      'routeColor': routeColor,
      'route': route,
      'rack': rack,
    };
  }

  factory Rack.fromjson(Map<String, dynamic> json) {
    return Rack(
      routeColor: json['routeColor'],
      route: json['route'],
      rack: json['rack'],
    );
  }
}
