# PearlD3 Util

PearlD3 Util is a utility Flutter package that provides various utility classes and extensions for common tasks in your PearlD3 project.

## Installation

To use the PearlD3 Util package in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  pearld3_util: ^x.x.x
```

### Utility Classes and Extensions Included

The pearld3_util package includes the following utility classes and extensions:

 BluePrint
A utility class for handling Bluetooth thermal printing.

 StringUtils
An extension to provide utility methods for handling strings.

DoubleExtension
An extension to provide utility methods for handling doubles.

BuildContextExtension
An extension to provide utility methods for handling BuildContext.

Utilities
A utility class containing various methods for common tasks.

## Usage

Import the package and the desired utility classes or extensions:

```dart
import 'package:pearld3_util/pearld3_util.dart';
```

Use the provided utility classes or extensions in your project as needed:

```dart
BluePrint bluePrint = BluePrint();
```

StringUtils

```dart

String title = 'hello world';
String titleCase = title.toTitleCase(); // 'Hello world'

```
