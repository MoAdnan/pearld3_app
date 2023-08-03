import 'dart:convert';

class VisualBase {
  String previousUID = "";
  int mode = 0;
  double stock = 0;
  VisualBase(
      {required this.mode, required this.previousUID, required this.stock});
}

List<VisualProduct> listOfVisualProductsFromJson(String str) =>
    List<VisualProduct>.from(
        json.decode(str).map((x) => productListFromJson(x)));

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

class VisualProduct extends VisualBase {
  String? uid;
  String? code;
  String? name;
  String? localeName;
  double? price;
  String? departmentUID;
  String? categoryUID;
  String? subCategoryUID;
  String? brandUID;
  String? imgData;
  int mode = 1;
  double stock = 0.0;

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

List<VisualDepartment> listOfVisualDepartmentsFromJson(String str) =>
    List<VisualDepartment>.from(
        json.decode(str).map((x) => visualDepartmentListFromJson(x)));

visualDepartmentListFromJson(Map<String, dynamic> json) => VisualDepartment(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    imgData: json["imgData"].toString());

class VisualDepartment extends VisualBase {
  String? uid;
  String? code;
  String? name;
  String? localeName;
  String? imgData;
  int mode = 0;

  VisualDepartment({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.imgData,
  }) : super(mode: 0, previousUID: '', stock: 0.0);
}

List<VisualCategory> listOfVisualCategoriesFromJson(String str) =>
    List<VisualCategory>.from(
        json.decode(str).map((x) => visualCategoryListFromJson(x)));

visualCategoryListFromJson(Map<String, dynamic> json) => VisualCategory(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    departmentUID: json['departmentUID'].toString(),
    imgData: json["imgData"].toString());

class VisualCategory extends VisualBase {
  String? uid;
  String? code;
  String? name;
  String? localeName;
  String? departmentUID;
  String? imgData;
  int mode = 0;

  VisualCategory({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.departmentUID,
    required this.imgData,
  }) : super(mode: 0, previousUID: '', stock: 0.0);
}

List<VisualSubCategory> listOfVisualSubCategoriesFromJson(String str) =>
    List<VisualSubCategory>.from(
        json.decode(str).map((x) => visualSubCategoryListFromJson(x)));

visualSubCategoryListFromJson(Map<String, dynamic> json) => VisualSubCategory(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    imgData: json["imgData"].toString());

class VisualSubCategory extends VisualBase {
  String? uid;
  String? code;
  String? name;
  String? localeName;
  String? imgData;
  int mode = 0;

  VisualSubCategory({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.imgData,
  }) : super(mode: 0, previousUID: '', stock: 0.0);
}

List<VisualSubGroup> listOfVisualSubGroupsFromJson(String str) =>
    List<VisualSubGroup>.from(
        json.decode(str).map((x) => visualSubGroupFromJson(x)));

visualSubGroupFromJson(Map<String, dynamic> json) => VisualSubGroup(
    uid: json["uid"].toString(),
    code: json["code"].toString(),
    name: json["name"].toString(),
    localeName: json["localeName"].toString(),
    imgData: json["imgData"].toString());

class VisualSubGroup extends VisualBase {
  String? uid;
  String? code;
  String? name;
  String? localeName;
  String? imgData;
  int mode = 0;

  VisualSubGroup({
    required this.uid,
    required this.code,
    required this.name,
    required this.localeName,
    required this.imgData,
  }) : super(mode: 0, previousUID: '', stock: 0.0);
}
