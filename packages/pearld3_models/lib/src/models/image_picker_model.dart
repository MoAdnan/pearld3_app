import 'dart:convert';

class Attachments {
  Attachments(
      {this.uid,
      required this.masterUID,
      required this.transactionType,
      required this.particularType,
      this.attachmentDatas});

  String? uid;
  String? masterUID;
  int? transactionType;
  int? particularType;
  List<AttachmentData>? attachmentDatas;

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "masterUID": masterUID,
        "transactionType": transactionType,
        "particularType": particularType,
        "attachmentDatas": attachmentDatas,
      };
}

pearlAttachmentsFromJson(Map<String, dynamic> json) => Attachments(
      uid: json["uid"].toString(),
      masterUID: json["masterUID"].toString(),
      transactionType: int.parse(json['transactionType'].toString()),
      particularType: int.parse(json['particularType'].toString()),
      attachmentDatas: listOfAttachmentDataFromMapJson(json['attachmentDatas']),
    );

class AttachmentData {
  int page;
  String data;
  bool isDefault;
  AttachmentData(
      {required this.page, required this.data, required this.isDefault});

  Map<String, dynamic> toJson() => {
        "page": page,
        "data": data,
        "isDefault": isDefault,
      };

  @override
  String toString() {
    return 'AttachmentData{page: $page, data: $data, isDefault: $isDefault}';
  }

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
