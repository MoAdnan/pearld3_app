class OrderItemModel {
  String uid;
  int? rawID;
  String? packing;
  String? routeColor;
 String? extraNote;
  String itemUid;
  String itemName;
  String itemCode;
  String barCode;
  String routeCode;
  double quantity;
  int status;
  String masterUid;

  OrderItemModel({
    required this.extraNote,
    required this.rawID,
    required this.packing,
    required this.routeColor,
    required this.masterUid,
    required this.itemUid,
    required this.uid,
    required this.itemName,
    required this.itemCode,
    required this.barCode,
    required this.routeCode,
    required this.quantity,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'extraNote':extraNote,
      'uid': uid,
      'rowID': rawID,
      'packing': packing,
      'routeColor': routeColor,
      'itemUID': itemUid,
      'itemName': itemName,
      'itemCode': itemCode,
      'barCode': barCode,
      'routeCode': routeCode,
      'quantity': quantity,
      'status': status,
      'masterUID': masterUid,
    };
  }

  String get keywords {
    return ' ${packing!.toLowerCase()} , $barCode , ${itemName.toLowerCase()} , ${itemCode.toLowerCase()}';
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      extraNote: map['extraNote'],
      uid: map['uid'],
      rawID: map['rowID'],
      packing: map['packing'],
      routeColor: map['routeColor'],
      itemUid: map['itemUID'],
      itemName: map['itemName'],
      itemCode: map['itemCode'],
      barCode: map['barCode'],
      routeCode: map['routeCode'],
      quantity: map['quantity'],
      status: map['status'],
      masterUid: map['masterUID'],
    );
  }

  OrderItemModel copyWith({
    String? extraNote,
    String? uid,
    int? rawID,
    String? packing,
    String? routeColor,
    String? itemUid,
    String? itemName,
    String? itemCode,
    String? barCode,
    String? routeCode,
    double? quantity,
    int? status,
    String? masterUid,
  }) {
    return OrderItemModel(
        extraNote: extraNote ,
      uid: uid ?? this.uid,
      rawID: rawID ?? this.rawID,
      packing: packing ?? this.packing,
      routeColor: routeColor ?? this.routeColor,
      itemUid: itemUid ?? this.itemUid,
      itemName: itemName ?? this.itemName,
      itemCode: itemCode ?? this.itemCode,
      barCode: barCode ?? this.barCode,
      routeCode: routeCode ?? this.routeCode,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      masterUid: masterUid ?? this.masterUid
    );
  }
}
