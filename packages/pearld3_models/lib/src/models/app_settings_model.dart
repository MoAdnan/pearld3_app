import 'package:pearld3_models/pearld3_models.dart';

class AppSettingsModel {
  SavedCredential? savedCredential;

  //  CustomerList? selectedCustomer;
  //
  //  CustomerSupport? customerSupport;
  //
  //  BluetoothDevice? savedBluetoothDevice;
  int? pinForQr;
  int? paperWidth;
  // String language = '';
  bool shareImageToPrint;

  String? printMode;
  bool enabledBluetooth;
  String? productGrouping;
  bool continuePop;
 BlueDevice? blueDevice;
  String? language;

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

  Map<String, dynamic> toJson() {
    return {
      'blueDevice': this.blueDevice!=null?this.blueDevice!.toMap():null,
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

  factory AppSettingsModel.fromJson(Map<String, dynamic> map) {
    return AppSettingsModel(
      blueDevice:map['blueDevice']!=null?BlueDevice.fromMap(map['blueDevice']):null,
      pinForQr: map['pinForQr'],
      savedCredential: SavedCredential.fromMap(map['savedCredential']),
      paperWidth: map['paperWidth'],
      shareImageToPrint: map['shareImageToPrint'],
      printMode: map['printMode'],
      productGrouping: map['productGrouping'],
      language: map['language'],
      continuePop: map['continuePop'],
      enabledBluetooth: map['enabledBluetooth'],
    );
  }


  @override
  String toString() {
    return 'AppSettingsModel{blueDevice:$blueDevice, savedCredential: $savedCredential, pinForQr: $pinForQr, paperWidth: $paperWidth, shareImageToPrint: $shareImageToPrint, printMode: $printMode, enabledBluetooth: $enabledBluetooth, productGrouping: $productGrouping, continuePop: $continuePop, language: $language}';
  }

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
