# PearlD3 Models

PearlD3 Models is a Flutter package that provides a collection of model classes used for various data representations and structures within your PearlD3 project.

## Models Included

The `pearld3_models` package includes the following model classes:

- `ActivateModel`: Represents activation data.
- `AppSettingsModel`: Represents application settings data.
- `BlueDevice`: Represents Bluetooth device information.
- `CompanySettingsModel`: Represents company settings data.
- `ConfigModel`: Represents user configuration data.
- `DashboardModel`: Represents dashboard data.
- `DBLInputs`: Represents database inputs data.
- `DeviceSettingsModel`: Represents device settings data.
- `ImagePickerModel`: Represents image picker data.
- `LanguageModel`: Represents language data.
- `LoginBodyModel`: Represents login body data.
- `LoginCredentialModel`: Represents login credentials.
- `OrderItemModel`: Represents individual order items.
- `OrderModel`: Represents order details.
- `PrintModel`: Represents printing data.
- `ProductModel`: Represents product data.
- `RackModel`: Represents rack data.
- `SavedCredentialModel`: Represents saved credentials data.
- `StatusModel`: Represents status information for API responses.
- `UserCredentialModel`: Represents user credentials.
- `VisualPickerProductModel`: Represents visual picker product data.

## Installation

To use the PearlD3 Models package in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  pearld3_models: 
    path:
```
## Usage


 Example usages for each model class 
```dart
import 'package:pearld3_models/pearld3_models.dart';


// Example usage of ConfigModel
ConfigModel config = ConfigModel.fromJson(jsonData);

// Example usage of OrderModel
OrderModel order = OrderModel.fromJson(jsonData);

// Example usage of LanguageModel
LanguageModel language = LanguageModel.fromJson(jsonData);

```
 Include similar examples for other model classes 
