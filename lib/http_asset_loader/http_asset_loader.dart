import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:language_repository/language_repository.dart';

class HttpAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    final languages = await LanguageRepository().getLanguages();
    final ln = languages
        ?.firstWhere((element) => element.languageCode == locale.languageCode);

    final trans = await LanguageRepository().getLanguageByName(ln?.language);
    // log('------------traans');
// log(trans!.toString());
    return trans;
  }
}
