/// Represents the body model for a login request.
class LoginBodyModel {
  /// The username for the login request.
  String? username;

  /// The password for the login request.
  String? password;

  /// The date of joining associated with the user.
  String? dateOfJoining;

  /// The UUID (Universally Unique Identifier) of the device.
  String? uuid;

  /// The model number of the device.
  String? modelNumber;

  /// The activation key for the login request.
  String? activationKey;

  /// The longitude value of the device's location.
  double? lng;

  /// The latitude value of the device's location.
  double? lat;

  /// Constructs a [LoginBodyModel] instance with optional parameters.
  LoginBodyModel(
      {this.username,
      this.password,
      this.dateOfJoining,
      this.uuid,
      this.modelNumber,
      this.activationKey,
      this.lng,
      this.lat});

  /// Constructs a [LoginBodyModel] instance from a JSON map.
  factory LoginBodyModel.fromJson(Map<String, dynamic> json) {
    return LoginBodyModel(
        username: json['username'],
        password: json['password'],
        dateOfJoining: json['dateOfJoining'],
        uuid: json['uuid'],
        modelNumber: json['modelNumber'],
        activationKey: json['activationKey'],
        lat: json['lng'],
        lng: json['lat']);
  }

  /// Converts the [LoginBodyModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['dateOfJoining'] = this.dateOfJoining;
    data['uuid'] = this.uuid;
    data['modelNumber'] = this.modelNumber;
    data['activationKey'] = this.activationKey;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    return data;
  }
}
