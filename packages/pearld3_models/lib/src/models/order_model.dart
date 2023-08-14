import 'package:intl/intl.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';

class OrderModel {
  String uid;
  String docNumber;
  String entryDate;
  int? status;
  double? weight;
  String? rightLeafUID;
  String? statusName;
  String? ohUID;
  String customerName;
  double netQty;
  double netTotal;
  num progress;

  OrderModel({
    required this.customerName,
    required this.netQty,
    required this.netTotal,
    required this.progress,
    required this.uid,
    required this.docNumber,
    required this.entryDate,
    this.status,
    this.weight,
    this.rightLeafUID,
    this.statusName,
    this.ohUID,
  });

  String get formattedDate {
    DateFormat.yMd().add_jm();
    DateFormat dateFormat = DateFormat('dd-MM-yyyy hh:mm aaa');
    final date = DateTime.parse(entryDate);
    return dateFormat.format(date);
  }

  Map<String, dynamic> toJson() {
    return {
      'progress': progress,
      'netQty': netQty,
      'netTotal': netTotal,
      'customerName': customerName,
      'ohUID': ohUID,
      'uid': uid,
      'docNumber': docNumber,
      'entryDate': entryDate,
      'status': status,
      'weight': weight,
      'rightLeafUID': rightLeafUID,
      'statusName': statusName,
    };
  }

  String get keywords {
    return ' ${docNumber.toLowerCase()} , ${entryDate.toTitleCase()} , $weight , ${statusName!.toLowerCase()}';
  }

  @override
  String toString() {
    return 'OrderModel{uid: $uid, docNumber: $docNumber, entryDate: $entryDate, status: $status, weight: $weight, rightLeafUID: $rightLeafUID, statusName: $statusName, ohUID: $ohUID}';
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      progress: json['progress'],
      netTotal: json['netTotal'],
      netQty: json['netQty'],
      customerName: json['customerName'],
      ohUID: json['ohUID'],
      uid: json['uid'],
      docNumber: json['docNumber'],
      entryDate: json['entryDate'],
      status: json['status'],
      weight: json['weight'] ?? 0.0,
      rightLeafUID: json['rightLeafUID'],
      statusName: json['statusName'],
    );
  }
}
