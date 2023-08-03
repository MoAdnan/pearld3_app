class LoginBodyModel {
  String? username;
  String? password;
  String? dateOfJoining;
  String? uuid;
  String? modelNumber;
  String? activationKey;
  double? lng;
  double? lat;

  LoginBodyModel(
      {this.username,
      this.password,
      this.dateOfJoining,
      this.uuid,
      this.modelNumber,
      this.activationKey,
      this.lng,
      this.lat});

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
