/// Represents an item within an order.
class OrderItemModel {
  /// Unique identifier for the order item.
  String uid;

  /// Raw ID of the order item.
  int? rawID;

  /// Packing information of the order item.
  String? packing;

  /// Color code for the route of the order item.
  String? routeColor;

  /// Additional notes for the order item. Here only sending available qty in stock when a out of stock switch enables
  String? extraNote;

  /// Unique identifier of the item.
  String itemUid;

  /// Name of the item.
  String itemName;

  /// Code of the item.
  String itemCode;

  /// Barcode associated with the item.
  String barCode;

  /// Route code of the item.
  String routeCode;

  /// Quantity of the item.
  double quantity;

  /// Status of the item.
  int status;

  /// Master unique identifier of the item.
  String masterUid;

  /// Constructs an [OrderItemModel].
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

  /// Gets the value of [extraNote] (available quantity) as a double.
  double? get extraNoteInDouble {
    final value = double.tryParse(extraNote!);
    final qtyValue = double.tryParse(quantity.toString());
    // if available quantity is null old method was return0 that changed to
    // return orderedQuantity and it works fine
    if (value != null) {
      return value;
    } else {
      return qtyValue;
    }
  }

  /// Gets the quantity text with extra note information (available qty/total order quantity).
  String get qtyText {
    // Handle the case where availability is 0 separately
    if (extraNoteInDouble == 0) {
      return '0.000/${quantity.toStringAsFixed(3)}';
    }

    // Handle the case where availability is equal to ordered stock
    if (extraNoteInDouble == quantity) {
      return '${quantity.toStringAsFixed(3)}/${quantity.toStringAsFixed(3)}';
    }

    // For other cases, display availability/ordered stock
    return '${extraNoteInDouble!.toStringAsFixed(3)}/${quantity.toStringAsFixed(3)}';

//old working before un editable no stock
    // if (extraNoteInDouble > 0) {
    //   return '${extraNoteInDouble.toStringAsFixed(3)}(${quantity.toStringAsFixed(3)})';
    // } else if (extraNoteInDouble == quantity) {
    //   return '${quantity.toStringAsFixed(3)}(${quantity.toStringAsFixed(3)})';
    // } else if (extraNoteInDouble == 0) {
    //   return '${0.toStringAsFixed(3)}(${quantity.toStringAsFixed(3)})';
    // }
    // return '${quantity.toStringAsFixed(3)}(${quantity.toStringAsFixed(3)})';
  }

  /// Converts the [OrderItemModel] to a map.
  Map<String, dynamic> toMap() {
    return {
      'extraNote': extraNote,
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

  /// Gets keywords for searching based on item properties.
  String get keywords {
    return ' ${packing!.toLowerCase()} , $barCode , ${itemName.toLowerCase()} , ${itemCode.toLowerCase()}';
  }

  /// Creates an [OrderItemModel] from a map.
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

  /// Creates a copy of the [OrderItemModel] with optional property overrides.
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
        extraNote: extraNote,
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
        masterUid: masterUid ?? this.masterUid);
  }
}
