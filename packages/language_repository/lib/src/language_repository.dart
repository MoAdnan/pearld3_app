import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// here is the url to POST the jsonFiles through POSTMAN
// https://indeesapp.azurewebsites.net/api/language/

class LanguageRepository {
  LocalizationService _localizationService = LocalizationService();

  Future<List<LanguageModel>> getLanguages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final appUpgraded = await checkAppVersion();
    if (appUpgraded) {
      final response = await _localizationService.getLanguages();
      final languages = (response as List<dynamic>)
          .map((e) => LanguageModel.fromJson(e))
          .toList();

      for (LanguageModel languageModel in languages) {
        await prefs.remove('language_${languageModel.language}');
      }
    }
    String? languageDataString = prefs.getString('languages');

    if (languageDataString != null) {
      List<dynamic> languageDataJson = json.decode(languageDataString);
      List<LanguageModel> languages =
          languageDataJson.map((json) => LanguageModel.fromJson(json)).toList();
      return languages;
    } else {
      final response = await _localizationService.getLanguages();
      final languages = (response as List<dynamic>)
          .map((e) => LanguageModel.fromJson(e))
          .toList();

      List<Map<String, dynamic>> languageDataMap =
          languages.map((lang) => lang.toJson()).toList();
      String languageDataJson = json.encode(languageDataMap);

      await prefs.setString('languages', languageDataJson);

      return languages;
    }
  }

  Future<Map<String, dynamic>?> getLanguageByName(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? cachedLanguage = prefs.getString('language_$name');
    if (cachedLanguage != null) {
      return json.decode(cachedLanguage);
    } else {
      final language = await _localizationService.getLanguagesByName(name);
      await prefs.setString('language_$name', json.encode(language));
      return language;
    }
  }

  Future<bool> checkAppVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final oldVersion = prefs.getString('appVersion');

    String currentVersion = packageInfo.version;

    if (oldVersion != currentVersion) {
      await prefs.remove('appVersion');
      await prefs.setString('appVersion', currentVersion);
      return true;
    } else {
      return false;
    }
  }
}
