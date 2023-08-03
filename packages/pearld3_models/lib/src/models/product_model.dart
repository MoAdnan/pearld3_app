import 'package:pearld3_models/src/models/rack_model.dart';

class ProductModel {
  String uid;
  String imageData;
  String itemName;
  String description;
  List<Rack> racks;

  ProductModel({
    required this.uid,
    required this.imageData,
    required this.itemName,
    required this.description,
    required this.racks,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'image': imageData,
      'itemName': itemName,
      'description': description,
      'racks': racks.map((e) => e.tojson()).toList(),
    };
  }

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
