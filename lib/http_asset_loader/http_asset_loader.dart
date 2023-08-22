import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:language_repository/language_repository.dart';

/// This class extends the [AssetLoader] class and provides an implementation
/// for loading assets through HTTP requests. It overrides the [load] method to
/// fetch asset translations based on the provided [path] and [locale].
class HttpAssetLoader extends AssetLoader {
  /// Loads asset translations using HTTP requests.
  ///
  /// Given a [path] and a [locale], this method retrieves language information
  /// from the [LanguageRepository], attempts to match the language code with
  /// the provided locale, and fetches the corresponding translations using
  /// the resolved language name. The fetched translations are returned as
  /// a [Map<String, dynamic>] or null if no translations are found.
  ///
  /// Overrides the [load] method from the [AssetLoader] class.
  ///
  /// Throws a [LanguageRepositoryException] if the language information cannot be fetched
  /// or if there's an error during translation retrieval.
  ///
  /// Example:
  /// ```dart
  /// final loader = HttpAssetLoader();
  /// final translations = await loader.load('assets/translations', Locale('en', 'US'));
  /// if (translations != null) {
  ///   // Process and use the fetched translations
  /// } else {
  ///   // Handle no translations found
  /// }
  /// ` @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    // Retrieve available languages from the repository
    final availableLanguages = await LanguageRepository().getLanguages();
    // Find the language that matches the given locale's language code
    final language = availableLanguages
        ?.firstWhere((element) => element.languageCode == locale.languageCode);
    // Fetch translations based on the resolved language name
    final trans =
        await LanguageRepository().getLanguageByName(language?.language);

    return trans;
  }
}
