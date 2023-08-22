/// A model class representing activation data for a specific model.
class ActivateModel {
  /// The username associated with the activation.
  String username;

  /// The password for activation.
  String password;

  /// The universally unique identifier (UUID) of the activation.
  String uuid;

  /// The activation key required for the activation process.
  String ActivationKey;

  /// The model number associated with the activation.
  String ModelNumber;

  /// The longitude of the activation location.
  double Lng;

  /// The latitude of the activation location.
  double Lat;

  /// Creates an [ActivateModel] instance with the provided details.
  ActivateModel(
      {required this.username,
      required this.password,
      required this.uuid,
      required this.ActivationKey,
      required this.ModelNumber,
      required this.Lng,
      required this.Lat});

  /// Converts this [ActivateModel] instance into a JSON representation.
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "uuid": uuid,
        "ActivationKey": ActivationKey,
        "ModelNumber": ModelNumber,
        "Lng": Lng,
        "Lat": Lat,
      };
}
/// Creates an [ActivateModel] instance from a JSON representation.
activatefromJson(Map<String, dynamic> json) => ActivateModel(
    uuid: json["uuid"].toString(),
    username: json["username"].toString(),
    password: json["password"].toString(),
    ActivationKey: json["ActivationKey"],
    ModelNumber: json["ModelNumber"].toString(),
    Lng: json["Lng"],
    Lat: json["Lat"]);
