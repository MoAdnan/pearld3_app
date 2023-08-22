import 'dart:convert';

/// The base class for visual elements.
class VisualBase {
  /// The previous unique identifier.
  String previousUID = "";
  /// The mode of the visual element.
  int mode = 0;
  /// The stock value of the visual element.
  double stock = 0;

  /// Creates a [VisualBase] instance with the specified attributes.
  ///
  /// The [mode], [previousUID], and [stock] attributes define the behavior of
  /// visual elements.
  VisualBase(
      {required this.mode, required this.previousUID, required this.stock});
}

/// Converts a JSON string to a list of [VisualProduct] instances.
List<VisualProduct> listOfVisualProductsFromJson(String str) =>
    List<VisualProduct>.from(
        json.decode(str).map((x) => productListFromJson(x)));

/// Converts a JSON map to a [VisualProduct] instance.
productListFromJson(Map<String, dynamic> json) => VisualProduct(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    price: double.parse(json["price"].toString()),
    departmentUID: json["departmentUID"].toString(),
    categoryUID: json['categoryUID'].toString(),
    subCategoryUID: json['subCategoryUID'].toString(),
    brandUID: json['brandUID'].toString(),
    imgData: json["imgData"].toString());

/// Represents a visual product, extending the base class [VisualBase].
class VisualProduct extends VisualBase {
  /// The unique identifier of the product.
  String? uid;

  /// The code of the product.
  String? code;

  /// The name of the product.
  String? name;

  /// The localized name of the product.
  String? localeName;

  /// The price of the product.
  double? price;

  /// The unique identifier of the department associated with the product.
  String? departmentUID;

  /// The unique identifier of the category associated with the product.
  String? categoryUID;

  /// The unique identifier of the sub-category associated with the product.
  String? subCategoryUID;

  /// The unique identifier of the brand associated with the product.
  String? brandUID;

  /// The image data of the product.
  String? imgData;

  /// The mode of the product. Default is 1.
  int mode = 1;

  /// The stock of the product. Default is 0.0.
  double stock = 0.0;

  /// Creates a [VisualProduct] instance with the specified attributes.
  ///
  /// The [uid], [code], [name], [localeName], [price], [departmentUID],
  /// [categoryUID], [subCategoryUID], [brandUID], and [imgData] are required
  /// attributes that define the visual product.
  VisualProduct({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.price,
    required this.departmentUID,
    required this.categoryUID,
    required this.subCategoryUID,
    required this.brandUID,
    required this.imgData,
  }) : super(mode: 1, previousUID: '', stock: 0.0);
}

/// Converts a JSON string to a list of [VisualDepartment] instances.
List<VisualDepartment> listOfVisualDepartmentsFromJson(String str) =>
    List<VisualDepartment>.from(
        json.decode(str).map((x) => visualDepartmentListFromJson(x)));

/// Converts a JSON map to a [VisualDepartment] instance.
visualDepartmentListFromJson(Map<String, dynamic> json) => VisualDepartment(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    imgData: json["imgData"].toString());

/// Represents a visual department, extending the base class [VisualBase].
class VisualDepartment extends VisualBase {
  /// The unique identifier of the department.
  String? uid;
  /// The code of the department.
  String? code;
  /// The name of the department.
  String? name;
  /// The localized name of the department.
  String? localeName;
  /// The image data associated with the department.
  String? imgData;
  /// The mode of the department. Default is 0.
  int mode = 0;

  /// Creates a [VisualDepartment] instance with the specified attributes.
  ///
  /// The [uid], [code], [name], [localeName], and [imgData] are required
  /// attributes that define the visual department.
  VisualDepartment({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.imgData,
  }) : super(mode: 0, previousUID: '', stock: 0.0);
}
/// Converts a JSON string to a list of [VisualCategory] instances.
List<VisualCategory> listOfVisualCategoriesFromJson(String str) =>
    List<VisualCategory>.from(
        json.decode(str).map((x) => visualCategoryListFromJson(x)));

/// Converts a JSON map to a [VisualCategory] instance.
visualCategoryListFromJson(Map<String, dynamic> json) => VisualCategory(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    departmentUID: json['departmentUID'].toString(),
    imgData: json["imgData"].toString());

/// Represents a visual category, extending the base class [VisualBase].
class VisualCategory extends VisualBase {
  /// The unique identifier of the category.
  String? uid;
  /// The code of the category.
  String? code;
  /// The name of the category.
  String? name;
  /// The localized name of the category.
  String? localeName;
  /// The unique identifier of the department associated with the category.
  String? departmentUID;
  /// The image data associated with the category.
  String? imgData;
  /// The mode of the category. Default is 0.
  int mode = 0;

  /// Creates a [VisualCategory] instance with the specified attributes.
  ///
  /// The [uid], [code], [name], [localeName], [departmentUID], and [imgData]
  /// are required attributes that define the visual category.
  VisualCategory({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.departmentUID,
    required this.imgData,
  }) : super(mode: 0, previousUID: '', stock: 0.0);
}
/// Converts a JSON string to a list of [VisualSubCategory] instances.
List<VisualSubCategory> listOfVisualSubCategoriesFromJson(String str) =>
    List<VisualSubCategory>.from(
        json.decode(str).map((x) => visualSubCategoryListFromJson(x)));

/// Converts a JSON map to a [VisualSubCategory] instance.
visualSubCategoryListFromJson(Map<String, dynamic> json) => VisualSubCategory(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    imgData: json["imgData"].toString());

/// Represents a visual sub-category, extending the base class [VisualBase].
class VisualSubCategory extends VisualBase {
  /// The unique identifier of the sub-category.
  String? uid;
  /// The code of the sub-category.
  String? code;
  /// The name of the sub-category.
  String? name;
  /// The localized name of the sub-category.
  String? localeName;
  /// The image data associated with the sub-category.
  String? imgData;
  /// The mode of the sub-category. Default is 0.
  int mode = 0;

  /// Creates a [VisualSubCategory] instance with the specified attributes.
  ///
  /// The [uid], [code], [name], [localeName], and [imgData] are required
  /// attributes that define the visual sub-category.
  VisualSubCategory({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.imgData,
  }) : super(mode: 0, previousUID: '', stock: 0.0);
}
/// Converts a JSON string to a list of [VisualSubGroup] instances.
List<VisualSubGroup> listOfVisualSubGroupsFromJson(String str) =>
    List<VisualSubGroup>.from(
        json.decode(str).map((x) => visualSubGroupFromJson(x)));

/// Converts a JSON map to a [VisualSubGroup] instance.
visualSubGroupFromJson(Map<String, dynamic> json) => VisualSubGroup(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    imgData: json["imgData"].toString());

/// Represents a visual sub-group, extending the base class [VisualBase].
class VisualSubGroup extends VisualBase {
  /// The unique identifier of the sub-group.
  String? uid;
  /// The code of the sub-group.
  String? code;
  /// The name of the sub-group.
  String? name;
  /// The localized name of the sub-group.
  String? localeName;
  /// The image data associated with the sub-group.
  String? imgData;
  /// The mode of the sub-group. Default is 0.
  int mode = 0;


  /// Creates a [VisualSubGroup] instance with the specified attributes.
  ///
  /// The [uid], [code], [name], [localeName], and [imgData] are required
  /// attributes that define the visual sub-group.
  VisualSubGroup({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.imgData,
  }) : super(mode: 0, previousUID: '', stock: 0.0);
}
