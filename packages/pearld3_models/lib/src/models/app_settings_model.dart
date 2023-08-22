import 'package:pearld3_models/pearld3_models.dart';

/// A class representing application settings.
class AppSettingsModel {
  /// Saved credentials for authentication.
  SavedCredential? savedCredential;

  //  CustomerList? selectedCustomer;
  //
  //  CustomerSupport? customerSupport;
  //
  //  BluetoothDevice? savedBluetoothDevice;
  /// The PIN code used for QR code generation.
  int? pinForQr;

  /// The width of the paper used for printing.
  int? paperWidth;
  // String language = '';
  /// Determines whether to share images for printing.
  bool shareImageToPrint;

  /// The printing mode (e.g., 'single', 'batch').
  String? printMode;

  /// Indicates if Bluetooth is enabled.
  bool enabledBluetooth;

  /// The grouping mode for products.
  String? productGrouping;

  /// Controls the display of pop-up dialogs.
  bool continuePop;

  /// The Bluetooth device used for communication.
  BlueDevice? blueDevice;

  /// The selected language for the application.
  String? language;

  /// Creates an [AppSettingsModel] instance with the provided settings.
  AppSettingsModel({
    this.blueDevice,
    this.savedCredential,
    this.paperWidth,
    required this.shareImageToPrint,
    this.printMode,
    this.productGrouping,
    required this.continuePop,
    required this.language,
    required this.enabledBluetooth,
    this.pinForQr,
  });

  /// Converts the [AppSettingsModel] instance into a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'blueDevice': this.blueDevice != null ? this.blueDevice!.toMap() : null,
      'savedCredential': this.savedCredential?.toMap(),
      'paperWidth': this.paperWidth,
      'pinForQr': this.pinForQr,
      'shareImageToPrint': this.shareImageToPrint,
      'printMode': this.printMode,
      'productGrouping': this.productGrouping,
      'enabledBluetooth': this.enabledBluetooth,
      'language': this.language,
      'continuePop': this.continuePop,
    };
  }

  /// Creates an [AppSettingsModel] instance from a JSON representation.
  factory AppSettingsModel.fromJson(Map<String, dynamic> map) {
    return AppSettingsModel(
      blueDevice: map['blueDevice'] != null
          ? BlueDevice.fromMap(map['blueDevice'])
          : null,
      pinForQr: map['pinForQr'],
      savedCredential: map['savedCredential'] != null
          ? SavedCredential.fromMap(map['savedCredential'])
          : null,
      paperWidth: map['paperWidth'],
      shareImageToPrint: map['shareImageToPrint'],
      printMode: map['printMode'],
      productGrouping: map['productGrouping'],
      language: map['language'],
      continuePop: map['continuePop'],
      enabledBluetooth: map['enabledBluetooth'],
    );
  }

  /// Returns a string representation of the [AppSettingsModel] instance.
  @override
  String toString() {
    return 'AppSettingsModel{blueDevice:$blueDevice, savedCredential: $savedCredential, pinForQr: $pinForQr, paperWidth: $paperWidth, shareImageToPrint: $shareImageToPrint, printMode: $printMode, enabledBluetooth: $enabledBluetooth, productGrouping: $productGrouping, continuePop: $continuePop, language: $language}';
  }

  /// Creates a copy of the [AppSettingsModel] instance with optional modifications.
  AppSettingsModel copyWith({
    SavedCredential? savedCredential,
    int? pinForQr,
    int? paperWidth,
    bool? shareImageToPrint,
    String? printMode,
    bool? enabledBluetooth,
    String? productGrouping,
    bool? continuePop,
    BlueDevice? blueDevice,
    String? language,
  }) {
    return AppSettingsModel(
      savedCredential: savedCredential ?? this.savedCredential,
      pinForQr: pinForQr ?? this.pinForQr,
      paperWidth: paperWidth ?? this.paperWidth,
      shareImageToPrint: shareImageToPrint ?? this.shareImageToPrint,
      printMode: printMode ?? this.printMode,
      enabledBluetooth: enabledBluetooth ?? this.enabledBluetooth,
      productGrouping: productGrouping ?? this.productGrouping,
      continuePop: continuePop ?? this.continuePop,
      blueDevice: blueDevice ?? this.blueDevice,
      language: language ?? this.language,
    );
  }
}
