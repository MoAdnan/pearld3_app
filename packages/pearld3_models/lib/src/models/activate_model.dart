class ActivateModel {
  String username;
  String password;
  String uuid;
  String ActivationKey;
  String ModelNumber;
  double Lng;
  double Lat;

  ActivateModel(
      {required this.username,
      required this.password,
      required this.uuid,
      required this.ActivationKey,
      required this.ModelNumber,
      required this.Lng,
      required this.Lat});

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

activatefromJson(Map<String, dynamic> json) => ActivateModel(
    uuid: json["uuid"].toString(),
    username: json["username"].toString(),
    password: json["password"].toString(),
    ActivationKey: json["ActivationKey"],
    ModelNumber: json["ModelNumber"].toString(),
    Lng: json["Lng"],
    Lat: json["Lat"]);
