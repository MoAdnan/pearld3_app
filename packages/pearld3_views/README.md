# PearlD3 Views

PearlD3 Views is a Flutter package that provides a collection of UI screens and widgets for your PearlD3 project. It includes various screens and widgets to help you build the user interface of your app.

## Installation

To use the PearlD3 Views package in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  pearld3_views: 
    path:
```
## Included UI Screens and Widgets

The pearld3_views package includes the following UI screens and widgets:

### Screens
- OrderItemViewScreen: A screen to display details about an order item.
- ActivateScreen: A screen for activating user accounts.
- ConfigureScreen: A screen for configuring app settings.
- HomeScreen: The main screen of the app, typically the app's home page.
- LoginScreen: A screen for user authentication and login.
- NoNetworkScreen: A screen to display when the device is offline.
- QRViewScreen: A screen for scanning and displaying QR codes.
- SettingsScreen: A screen to manage app settings.
- Widgets

Widgets 

AppLogo: A widget that displays the app logo.

ButtonWidget: A customizable button widget.

CalenderButton: A button widget with a calendar icon.

CircularProgress: A circular progress indicator.

DoubleUnTick: A widget to show a double untick icon.

DropDownWidget: A dropdown widget with customizable options.

EmptyScreen: A screen to display when content is empty.

ErrorBuilder: A widget that builds different UIs based on error states.

ErrorText: A widget to display error messages.

HomeButton: A button widget with a home icon.

IconButtonWidget: A customizable icon button widget.

LoadingButton: A button widget with a loading indicator.

LogoutButton: A button widget with a logout icon.

PasswordField: A widget for password input.

ProductBottomSheet: A bottom sheet for displaying product details.

SaveButton: A button widget with a save icon.

SearchBar: A widget for a search bar with a search icon.

SettingsButton: A button widget with a settings icon.

SwitchWidget: A switch widget for toggling options.

TextContextWidget: A widget for displaying contextual text.

TextFieldWidget: A customizable text input widget.

UsernameField: A widget for username input.

## Usage
```dart
import 'package:pearld3_views/pearld3_views.dart';

AppLogo();
ButtonWidget();
// Usage of other widgets
```

### Assets

The package also includes fonts and images that you can use in your project. These assets are located in the assets folder of the package.