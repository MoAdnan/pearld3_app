# Authentication Repository

Authentication Repository is a Flutter package that provides a repository class responsible for handling authentication-related operations, such as user login, registration, and configuration management.

## Features

- Retrieve user configuration data.
- Log in users with provided credentials.
- Retrieve saved passwords from device storage.
- Register devices with provided information.
- Easily manage user authentication and device registration.

## Installation

To use the Authentication Repository package in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  authentication_repository:
    path: 
```
## Usage

```dart
import 'package:authentication_repository/authentication_repository.dart';

final authRepository = AuthenticationRepository();

// Retrieve user configuration
final  configResult =  authRepository.getConfig(email);

// Log in a user
final loginResult = authRepository.login(
username: 'example_username',
password: 'example_password',
config: configModel,
);

// Retrieve saved passwords
final savedPasswords = authRepository.getSavedPasswords();

// Register a device
final registrationResult =  authRepository.registerDevice(
username: 'example_username',
password: 'example_password',
activationKey: 'example_activation_key',
config: configModel,
);

// Log out
authRepository.logOut()


```