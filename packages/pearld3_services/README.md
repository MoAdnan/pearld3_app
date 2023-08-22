# PearlD3 Services

PearlD3 Services is a Flutter package that provides a collection of service classes for making API calls within your PearlD3 project.

## Services Included

The `pearld3_services` package includes the following service classes:

- `UnAuthorizedService`: Provides methods for making unauthorized requests using Dio.
- `DioInterceptors`: Interceptor class for Dio to handle request, error, and response interceptors.
- `AuthorizedService`: Provides methods for making authorized API calls with headers.
- `OrderService`: Provides methods for making API calls related to orders.

## Installation

To use the PearlD3 Services package in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  pearld3_services: 
    path:
```

## Usage

Use the provided service classes in your project as needed:
```dart
import 'package:pearld3_services/pearld3_services.dart';


UnAuthorizedService unAuthorizedService = UnAuthorizedService();

AuthorizedService authorizedService = AuthorizedService(
  baseUrl: 'https://yourapiurl.com',
  token: 'yourAuthToken',
);

OrderService orderService = OrderService(
  baseUrl: 'https://yourapiurl.com',
  token: 'yourAuthToken',
);

```
 Include similar examples for other service classes 