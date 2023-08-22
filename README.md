
# PearlD3 App

Welcome to the PearlD3 App repository! This project is designed to provide you with a comprehensive foundation for building your PearlD3 application using Flutter. It encompasses various modules, utilities, and screens to help you streamline your app development process.

## Project Structure

The PearlD3 App project is organized as follows:

- `http_asset_loader`: A module for loading assets over HTTP.
- `routes`: Definition of the app's navigation routes.
- `app.dart`: The main entry point of the Flutter app.
- `bootstrap.dart`: Initialization and configuration of the app.
- `main.dart`: The main execution file for your Flutter app.
- `main_dev_adnan.dart`, `main_dev_habeeb.dart`, `main_dev_web.dart`: Development-specific entry points for different platforms.
- `packages`: A directory containing various modules and utilities:
    - `authentication_repository`: A repository for handling authentication.
    - `indees_esc_pos_utils`: Utilities for ESC/POS printing.
    - `language_repository`: A repository for handling app localization.
    - `order_repository`: A repository for managing orders.
    - `pearld3_models`: Shared data models for your app.
    - `pearld3_services`: Services and API interaction logic.
    - `pearld3_states`: BLoCs and Cubits for app state management.
    - `pearld3_util`: Utility classes for common tasks.
    - `pearld3_views`: UI screens and widgets for your app.

## Getting Started

1. Clone this repository to your local machine.
2. Review the structure of the project's components to familiarize yourself with each module's purpose.
3. Modify and extend the components according to your app's requirements.

## Installation

## Important:

Whenever you make changes or add new features, especially if they involve updates to language data retrieved from the server, it's recommended to upgrade the app version to ensure a smooth user experience. Users can then receive the latest updates by updating the app from the app store.
To upgrade the app version:

Update the `version` field in your `pubspec.yaml` file.
Make sure to follow the Flutter versioning conventions when updating the version.
After updating the version, run:

```bash
flutter build 
```
Distribute the updated version of the app to your users through the app store.



To run the PearlD3 App on your local machine:

1. Ensure you have the latest version of Flutter and Dart installed.
2. Navigate to the project's root directory using your terminal.
3. Run `flutter pub get` to fetch and install the project's dependencies.
4. Choose the appropriate entry point file (`main.dart`, `main_dev_adnan.dart`, etc.) based on your development platform.
5. Run the app using `flutter run`.


## Contributing

We appreciate contributions to make the PearlD3 App even better! If you'd like to contribute:

1. Fork this repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and ensure they adhere to coding standards.
4. Open a pull request against the `main` branch of this repository.


## Contact

For any inquiries or questions, feel free to reach out to us at [contact@pearld3app.com](mailto:contact@pearld3app.com).
