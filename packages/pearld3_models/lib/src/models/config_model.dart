class ConfigModel {
  String? uid;
  String? adminemail;
  String? serviceurl;
  String? datestarted;
  String? companyname;
  String? contact;
  String? phone;
  String? activationstatus;
  bool? isactive;
  PearlAppSettings? pearlSettings;

  ConfigModel({
    required this.uid,
    required this.adminemail,
    required this.serviceurl,
    required this.datestarted,
    required this.companyname,
    required this.contact,
    required this.phone,
    required this.activationstatus,
    required this.isactive,
    required this.pearlSettings,
  });

  // @override
  // String toString() {
  //   return 'ConfigModel{uid: $uid, adminemail: $adminemail, serviceurl: $serviceurl, datestarted: $datestarted, companyname: $companyname, contact: $contact, phone: $phone, activationstatus: $activationstatus, isactive: $isactive, pearlSettings: $pearlSettings}';
  // }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "adminemail": adminemail,
    "serviceurl": serviceurl,
    "datestarted": datestarted,
    "companyname": companyname,
    "contact": contact,
    "phone": phone,
    "activationstatus": activationstatus,
    "isactive": isactive,
    "pearlSettings": pearlSettings!.toJson(),
  };
  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    uid: json["uid"],
    adminemail: json["adminemail"],
    serviceurl: json["serviceurl"],
    datestarted: json["datestarted"],
    companyname: json["companyname"],
    contact: json["contact"],
    phone: json["phone"],
    activationstatus: json["activationstatus"],
    isactive: json["isactive"],
    pearlSettings: PearlAppSettings.fromJson(json["pearlSettings"]!),
  );
}

class PearlAppSettings {
  int quantityRounding;
  // int currencyRounding;
  bool allowEditCustomer;
  bool allowEditLocation;
  bool allowAddOpening;
  bool productentryonly;
  bool alloworderentry;
  bool allowinvoiceentry;
  bool allowreceipt;
  bool allowsalesreturn;
  bool allowstockrequest;
  bool taxenabled;
  bool printenabled;
  bool alwayonlocation;
  bool function10001;

  /// for production list view instead dashboard
  bool function10002;

  /// for tile in production entry
  bool function10003;
  bool function10004;
  bool function10005;
  bool function10006;
  bool function10007;
  bool function10008;
  bool function10009;
  bool function10010;
  bool function10011;
  bool function10012;

  PearlAppSettings({
    required this.quantityRounding,
    //required this.currencyRounding,
    required this.allowEditCustomer,
    required this.allowEditLocation,
    required this.allowAddOpening,
    required this.productentryonly,
    required this.alloworderentry,
    required this.allowinvoiceentry,
    required this.allowreceipt,
    required this.allowsalesreturn,
    required this.allowstockrequest,
    required this.taxenabled,
    required this.printenabled,
    required this.alwayonlocation,
    required this.function10001,
    required this.function10002,
    required this.function10003,
    required this.function10004,
    required this.function10005,
    required this.function10006,
    required this.function10007,
    required this.function10008,
    required this.function10009,
    required this.function10010,
    required this.function10011,
    required this.function10012,
  });

  @override
  String toString() {
    return 'PearlAppSettings{quantityRounding: $quantityRounding, allowEditCustomer: $allowEditCustomer, allowEditLocation: $allowEditLocation, allowAddOpening: $allowAddOpening, productentryonly: $productentryonly, alloworderentry: $alloworderentry, allowinvoiceentry: $allowinvoiceentry, allowreceipt: $allowreceipt, allowsalesreturn: $allowsalesreturn, allowstockrequest: $allowstockrequest, taxenabled: $taxenabled, printenabled: $printenabled, alwayonlocation: $alwayonlocation, function10001: $function10001, function10002: $function10002, function10003: $function10003, function10004: $function10004, function10005: $function10005, function10006: $function10006, function10007: $function10007, function10008: $function10008, function10009: $function10009, function10010: $function10010, function10011: $function10011, function10012: $function10012}';
  }

  Map<String, dynamic> toJson() => {
    "quantityRounding": quantityRounding.toString(),
    //       "currencyRounding": currencyRounding.toString(),
    "allowEditCustomer": allowEditCustomer,
    "allowEditLocation": allowEditLocation,
    "allowAddOpening": allowAddOpening,
    "productentryonly": productentryonly,
    "alloworderentry": alloworderentry,
    "allowinvoiceentry": allowinvoiceentry,
    "allowreceipt": allowreceipt,
    "allowsalesreturn": allowsalesreturn,
    "allowstockrequest": allowstockrequest,
    "taxenabled": taxenabled,
    "printenabled": printenabled,
    "alwayonlocation": alwayonlocation,
    "function10001": function10001,
    "function10002": function10002,
    "function10003": function10003,
    "function10004": function10004,
    "function10005": function10005,
    "function10006": function10006,
    "function10007": function10007,
    "function10008": function10008,
    "function10009": function10009,
    "function10010": function10010,
    "function10011": function10011,
    "function10012": function10012,
  };
  factory PearlAppSettings.fromJson(Map<String, dynamic> json)
  {

    return  PearlAppSettings(
      quantityRounding: int.parse(json["quantityRounding"].toString()),
      //     currencyRounding: json["currencyRounding"],
      allowEditCustomer: json["allowEditCustomer"],
      allowEditLocation: json["allowEditLocation"],
      allowAddOpening: json["allowAddOpening"],
      productentryonly: json["productentryonly"],
      alloworderentry: json["alloworderentry"],
      allowinvoiceentry: json["allowinvoiceentry"],
      allowreceipt: json["allowreceipt"],
      allowsalesreturn: json["allowsalesreturn"],
      allowstockrequest: json["allowstockrequest"],
      taxenabled: json["taxenabled"],
      printenabled: json["printenabled"],
      alwayonlocation: json["alwayonlocation"],
      function10001: json["function10001"],
      function10002: json["function10002"],
      function10003: json["function10003"],
      function10004: json["function10004"],
      function10005: json["function10005"],
      function10006: json["function10006"],
      function10007: json["function10007"],
      function10008: json["function10008"],
      function10009: json["function10009"],
      function10010: json["function10010"],
      function10011: json["function10011"],
      function10012: json["function10012"],
    );
  }
}
