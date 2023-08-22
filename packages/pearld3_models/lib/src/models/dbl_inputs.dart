import 'package:equatable/equatable.dart';

/// Represents input data for the database.
class DbInputs extends Equatable {
  /// The requested date for the data.
  String? reqdate;

  /// The unique identifier for the outlet.
  String? outletUID;

  /// The device ID associated with the data.
  int? deviceID;

  /// The reference identifier.
  String? refUID;

  /// The key for the report.
  String? reportKey;

  /// Indicates whether PDF mode is enabled.
  bool? pdfMode;

  /// The width of the paper.
  int? paperWidth;

  /// Creates a new [DbInputs] instance.
  DbInputs({
    this.reqdate,
    this.outletUID,
    this.deviceID,
    this.refUID,
    this.reportKey,
    this.pdfMode,
    this.paperWidth,
  });

  @override
  List<Object?> get props =>
      [reqdate, outletUID, deviceID, refUID, reportKey, pdfMode, paperWidth];

  /// Converts the [DbInputs] instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'reqdate': reqdate,
      'outletUID': outletUID,
      'deviceID': deviceID,
      'refUID': refUID,
      'reportKey': reportKey,
      'pdfMode': pdfMode,
      'paperWidth': paperWidth,
    };
  }

  /// Creates a [DbInputs] instance from a map.
  factory DbInputs.fromMap(Map<String, dynamic> map) {
    return DbInputs(
      reqdate: map['reqdate'],
      outletUID: map['outletUID'],
      deviceID: map['deviceID'],
      refUID: map['refUID'],
      reportKey: map['reportKey'],
      pdfMode: map['pdfMode'],
      paperWidth: map['paperWidth'],
    );
  }

  /// Creates a copy of [DbInputs] with optional changes.
  DbInputs copyWith({
    String? reqdate,
    String? outletUID,
    int? deviceID,
    String? refUID,
    String? reportKey,
    bool? pdfMode,
    int? paperWidth,
  }) {
    return DbInputs(
      reqdate: reqdate ?? this.reqdate,
      outletUID: outletUID ?? this.outletUID,
      deviceID: deviceID ?? this.deviceID,
      refUID: refUID ?? this.refUID,
      reportKey: reportKey ?? this.reportKey,
      pdfMode: pdfMode ?? this.pdfMode,
      paperWidth: paperWidth ?? this.paperWidth,
    );
  }
}
