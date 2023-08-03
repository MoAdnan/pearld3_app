import 'dart:ui';

class LanguageModel {
  String? uid;
  String? author;
  String? language;
  String? languageCode;
  String? description;
  String? directon;
  bool? isBase;
  String? regionCode;
  Null? data;

  Locale toLacale() {
    return Locale(languageCode!, regionCode);
  }

  LanguageModel(
      {this.uid,
      this.regionCode,
      this.author,
      this.language,
      this.languageCode,
      this.description,
      this.directon,
      this.isBase,
      this.data});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    regionCode = json['regionCode'];
    uid = json['uid'];
    author = json['author'];
    language = json['language'];
    languageCode = json['languageCode'];
    description = json['description'];
    directon = json['directon'];
    isBase = json['isBase'];
    data = json['data'];
  }

  @override
  String toString() {
    return 'LanguageModel{uid: $uid, author: $author, language: $language, languageCode: $languageCode, description: $description, directon: $directon, isBase: $isBase, regionCode: $regionCode, data: $data}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['author'] = this.author;
    data['language'] = this.language;
    data['languageCode'] = this.languageCode;
    data['description'] = this.description;
    data['directon'] = this.directon;
    data['isBase'] = this.isBase;
    data['data'] = this.data;
    data['regionCode'] = this.regionCode;
    return data;
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LanguageModel &&
              runtimeType == other.runtimeType &&
              languageCode == other.languageCode;

  @override
  int get hashCode => languageCode.hashCode;
}
