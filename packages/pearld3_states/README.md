# PearlD3 States

PearlD3 States is a Flutter package that provides a collection of BLoCs and Cubits for managing state and business logic within your PearlD3 project.

## Blocs and Cubits Included

The `pearld3_states` package includes the following BLoCs and Cubits:

- `ConfigBloc`: Manages the configuration state of your application.
- `LoginBloc`: Manages the user authentication and login state.
- `OrderBloc`: Manages the state related to orders in your application.
- `OrderViewBloc`: Manages the state of order views in your application.
- `QRScanCubit`: Manages the state of QR code scanning in your application.
- `SettingsBloc`: Manages the application settings state.
- `ThemeCubit`: Manages the theme state of your application.

## Installation

To use the PearlD3 States package in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  pearld3_states: 
    path:
```

## Usage

Use the provided BLoCs and Cubits in your project as needed:

```dart
import 'package:pearld3_states/pearld3_states.dart';


ConfigBloc configBloc = ConfigBloc();

LoginBloc loginBloc = LoginBloc();

OrderBloc orderBloc = OrderBloc();

OrderViewBloc orderViewBloc = OrderViewBloc();

```

 Include similar examples for other BLoCs and Cubits 