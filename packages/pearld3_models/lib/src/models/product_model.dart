import 'package:pearld3_models/src/models/rack_model.dart';

/// Represents a product model.
class ProductModel {
  /// The unique identifier for the product.
  String uid;

  /// The image data associated with the product.
  String imageData;

  /// The name of the product.
  String itemName;

  /// The description of the product.
  String description;

  /// The list of racks associated with the product.
  List<Rack> racks;

  /// Creates a [ProductModel] instance.
  ///
  /// The [uid] is the unique identifier for the product.
  /// The [imageData] is the image data associated with the product.
  /// The [itemName] is the name of the product.
  /// The [description] is the description of the product.
  /// The [racks] is the list of racks associated with the product.
  ProductModel({
    required this.uid,
    required this.imageData,
    required this.itemName,
    required this.description,
    required this.racks,
  });

  /// Converts the [ProductModel] instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'image': imageData,
      'itemName': itemName,
      'description': description,
      'racks': racks.map((e) => e.tojson()).toList(),
    };
  }

  /// Creates a [ProductModel] instance from a map.
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      uid: map['uid'],
      imageData: map['image'],
      itemName: map['itemName'],
      description: map['description'],
      racks:
          (map['racks'] as List<dynamic>).map((e) => Rack.fromjson(e)).toList(),
    );
  }
}
