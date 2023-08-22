/// Represents a configuration model containing various settings for an application.
class ConfigModel {
  /// The unique identifier for the configuration.
  String? uid;

  /// The email address of the administrator.
  String? adminemail;

  /// The URL of the service associated with the configuration.
  String? serviceurl;

  /// The date when the configuration started.
  String? datestarted;

  /// The name of the company associated with the configuration.
  String? companyname;

  /// The contact information for the configuration.
  String? contact;

  /// The phone number associated with the configuration.
  String? phone;

  /// The activation status of the configuration.
  String? activationstatus;

  /// Indicates whether the configuration is active or not.
  bool? isactive;

  /// The settings specific to the Pearl application.
  PearlAppSettings? pearlSettings;

  /// Creates a new [ConfigModel] instance with the provided settings.
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

  /// Converts the [ConfigModel] instance to a JSON representation.
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

  /// Creates a [ConfigModel] instance from a JSON map.
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

/// Represents settings for the Pearl application.
class PearlAppSettings {
  /// The rounding value for quantities.
  int quantityRounding;
  // int currencyRounding;
  /// Indicates whether editing customer information is allowed.
  bool allowEditCustomer;

  /// Indicates whether editing location information is allowed.
  bool allowEditLocation;

  /// Indicates whether adding opening is allowed.
  bool allowAddOpening;

  /// Indicates whether only product entry is allowed.
  bool productentryonly;

  /// Indicates whether order entry is allowed.
  bool alloworderentry;

  /// Indicates whether invoice entry is allowed.
  bool allowinvoiceentry;

  /// Indicates whether receipt entry is allowed.
  bool allowreceipt;

  /// Indicates whether sales return entry is allowed.
  bool allowsalesreturn;

  /// Indicates whether stock request entry is allowed.
  bool allowstockrequest;

  /// Indicates whether tax calculation is enabled.
  bool taxenabled;

  /// Indicates whether printing is enabled.
  bool printenabled;

  /// Indicates whether always-on-location mode is enabled.
  bool alwayonlocation;

  /// Indicates the status of function 10001.
  bool function10001;

  /// for production list view instead dashboard
  bool function10002;

  /// for tile in production entry
  bool function10003;

  /// Indicates whether function 10004 is enabled.
  bool function10004;

  /// Indicates whether function 10005 is enabled.
  bool function10005;

  /// Indicates whether function 10006 is enabled.
  bool function10006;

  /// Indicates whether function 10007 is enabled.
  bool function10007;

  /// Indicates whether function 10008 is enabled.
  bool function10008;

  /// Indicates whether function 10009 is enabled.
  bool function10009;

  /// Indicates whether function 10010 is enabled.
  bool function10010;

  /// Indicates whether function 10011 is enabled.
  bool function10011;

  /// Indicates whether function 10012 is enabled.
  bool function10012;

  /// Creates a new [PearlAppSettings] instance with the provided settings.
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

  /// Converts the [PearlAppSettings] instance to a JSON representation.
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

  /// Creates a [PearlAppSettings] instance from a JSON map.
  factory PearlAppSettings.fromJson(Map<String, dynamic> json) {
    return PearlAppSettings(
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
