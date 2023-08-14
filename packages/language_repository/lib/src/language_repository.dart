import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// here is the url to POST the jsonFiles through POSTMAN
// https://indeesapp.azurewebsites.net/api/language/
// also the json file of eng,ara saved in assets/locale

class LanguageRepository {
  LocalizationService _localizationService = LocalizationService();

  Future<List<LanguageModel>> getLanguages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//checking app version changed or not if changed appUpgrade=true
    final appUpgraded = await checkAppVersion();
    if (appUpgraded) {
      // app updated so get new languages
      final response = await _localizationService.getLanguages();
      final languages = (response as List<dynamic>)
          .map((e) => LanguageModel.fromJson(e))
          .toList();
// and removing old getLanguageByName data from Shared prefs
// so the language_name will be null  while calling LanguageByName function
// and gets new words there
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
//here cachedLanguage will be null when app Updated
// pls check function checkAppVersion() , then getLanguages()
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
