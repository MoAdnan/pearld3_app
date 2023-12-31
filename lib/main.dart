import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_app/bootstrap.dart';
import 'package:pearld3_states/di.dart' as getIt;
import 'app.dart';
import 'http_asset_loader/http_asset_loader.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
// }
/// The main entry point of the application.
void main() async {

// Initialize the application and start with the provided builder.
  bootstrap(() => EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
        path: 'assets/lang', // Specify the path to your localization files
        fallbackLocale: const Locale('en', 'US'),
        assetLoader: HttpAssetLoader(),
        child:  App(),
      ));
  // Example usage:
  //
  // This function initializes the application, sets up localization,
  // and starts the application with the root widget provided by the `App` class.
  // The supported locales, localization path, fallback locale, and asset loader
  // are configured for the `EasyLocalization` widget.
}
