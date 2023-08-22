import 'package:intl/intl.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';

/// Represents an order.
class OrderModel {
  /// Unique identifier for the order.
  String uid;

  /// Document number of the order.
  String docNumber;

  /// Entry date of the order.
  String entryDate;

  /// Status of the order.
  int? status;

  /// Weight of the order.
  double? weight;

  /// Unique identifier of the right leaf.
  String? rightLeafUID;

  /// Status name of the order.
  String? statusName;

  /// Order header unique identifier.
  String? ohUID;

  /// Customer name associated with the order.
  String customerName;

  /// Net quantity of the order.
  double netQty;

  /// Net total of the order.
  double netTotal;

  /// Progress of the order.
  num progress;

  /// Constructs an [OrderModel].
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

  /// Gets the formatted entry date of the order.
  String get formattedDate {
    DateFormat.yMd().add_jm();
    DateFormat dateFormat = DateFormat('dd-MM-yyyy hh:mm aaa');
    final date = DateTime.parse(entryDate);
    return dateFormat.format(date);
  }

  /// Converts the [OrderModel] to a JSON map.
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

  /// Gets keywords for searching based on order properties.
  String get keywords {
    return ' ${docNumber.toLowerCase()} , ${entryDate.toTitleCase()} , $weight , ${statusName!.toLowerCase()}';
  }

  /// Returns a string representation of the [OrderModel].
  @override
  String toString() {
    return 'OrderModel{uid: $uid, docNumber: $docNumber, entryDate: $entryDate, status: $status, weight: $weight, rightLeafUID: $rightLeafUID, statusName: $statusName, ohUID: $ohUID}';
  }

  /// Creates an [OrderModel] from a JSON map.
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
