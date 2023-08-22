# Language Repository

Language Repository is a Flutter package that provides a repository class responsible for handling language-related operations. It allows you to retrieve available languages, fetch language data by its name, and manage language-related caching.

## Features

- Retrieve the list of available languages.
- Fetch language data by its name.
- Manage caching of language data.
- Check if the app has been upgraded for cache management.

## Installation

To use the Language Repository package in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  language_repository: 
    path:
```
## Usage
```dart
import 'package:language_repository/language_repository.dart';

final languageRepository = LanguageRepository();


// Retrieve the list of available languages
final languages =  languageRepository.getLanguages();

// Fetch language data by its name
final languageData =  languageRepository.getLanguageByName('english');

// Check if the app has been upgraded for cache management
final appUpgraded = languageRepository.checkAppVersion();


```
