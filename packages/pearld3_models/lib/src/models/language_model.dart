import 'dart:ui';

/// Represents a language model with properties and methods for language data handling.
class LanguageModel {
  /// Unique identifier for the language model
  String? uid;

  /// Author of the language
  String? author;

  /// Name of the language
  String? language;

  /// Code representing the language
  String? languageCode;

  /// Description of the language
  String? description;

  /// Direction of the language (possibly a typo, should be 'direction')
  String? directon;

  /// Indicates if the language is the base language
  bool? isBase;

  /// Code representing the region
  String? regionCode;

  /// Additional data associated with the language
  Null? data;

  /// Creates a [Locale] object from the [languageCode] and [regionCode].
  Locale toLocale() {
    return Locale(languageCode!, regionCode);
  }

  /// Constructs a [LanguageModel] instance from JSON data.
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

  /// Constructs a [LanguageModel] instance from a JSON map.
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

  /// Converts the [LanguageModel] instance to a formatted string.
  @override
  String toString() {
    return 'LanguageModel{uid: $uid, author: $author, language: $language, languageCode: $languageCode, description: $description, directon: $directon, isBase: $isBase, regionCode: $regionCode, data: $data}';
  }

  /// Converts the [LanguageModel] instance to a JSON map.
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

  /// Compares two [LanguageModel] instances for equality based on [languageCode].
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModel &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode;

  /// Returns the hash code of the [languageCode].
  @override
  int get hashCode => languageCode.hashCode;
}
