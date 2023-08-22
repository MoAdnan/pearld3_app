import 'dart:convert';

/// Represents attachments associated with a specific master entity.
class Attachments {
  /// Constructs an [Attachments] instance.
  Attachments(
      {this.uid,
      required this.masterUID,
      required this.transactionType,
      required this.particularType,
      this.attachmentDatas});

  /// The unique identifier of the attachment.
  String? uid;

  /// The unique identifier of the master entity.
  String? masterUID;

  /// The type of transaction associated with the attachment.
  int? transactionType;

  /// The type of particular associated with the attachment.
  int? particularType;

  /// List of attachment data instances.
  List<AttachmentData>? attachmentDatas;

  /// Converts this [Attachments] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "masterUID": masterUID,
        "transactionType": transactionType,
        "particularType": particularType,
        "attachmentDatas": attachmentDatas,
      };
}

/// Constructs an [Attachments] instance from a JSON map.
pearlAttachmentsFromJson(Map<String, dynamic> json) => Attachments(
      uid: json["uid"].toString(),
      masterUID: json["masterUID"].toString(),
      transactionType: int.parse(json['transactionType'].toString()),
      particularType: int.parse(json['particularType'].toString()),
      attachmentDatas: listOfAttachmentDataFromMapJson(json['attachmentDatas']),
    );

/// Represents attachment data.
class AttachmentData {
  /// The page number of the attachment.
  int page;

  /// The attachment data.
  String data;

  /// Indicates whether the attachment is the default.
  bool isDefault;

  /// Constructs an [AttachmentData] instance.
  AttachmentData(
      {required this.page, required this.data, required this.isDefault});

  /// Converts this [AttachmentData] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "page": page,
        "data": data,
        "isDefault": isDefault,
      };

  /// Overrides the default `toString()` implementation.
  @override
  String toString() {
    return 'AttachmentData{page: $page, data: $data, isDefault: $isDefault}';
  }

  /// Constructs an [AttachmentData] instance from a JSON map.
  AttachmentData.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        data = json['data'],
        isDefault = json['isDefault'] as bool;
}

// List<AttachmentData> listOfAttachmentDataFromJson(Map<String,dynamic> str) {
//   print("hello");
//   // print('-->>' + str.substring(1, str.length-1));
//   // str=str.substring(1, str.length-1);
//   var x =json.decode(str.);
//   return List<AttachmentData>.from(json.decode(str).map((x) {
//     print(x.toString());
//     pearlAttachmentDataFromJson(x);
//   }));
// }
List<AttachmentData> listOfAttachmentDataFromMapJson(List<dynamic> str) =>
    List<AttachmentData>.from(str.map((x) => AttachmentData.fromJson(x)));

List<AttachmentData> listOfAttachmentDataFromJson(String str) =>
    List<AttachmentData>.from(
        json.decode(str).map((x) => AttachmentData.fromJson(x)));

pearlAttachmentDataFromJson(Map<String, dynamic> json) => AttachmentData(
    page: int.parse(json["page"].toString()),
    data: json["data"].toString(),
    isDefault: json["isDefault"] as bool);
