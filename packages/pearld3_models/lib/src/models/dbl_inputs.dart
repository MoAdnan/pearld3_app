import 'package:equatable/equatable.dart';

class DbInputs extends Equatable {
  String? reqdate;
  String? outletUID;
  int? deviceID;
  String? refUID;
  String? reportKey;
  bool? pdfMode;
  int? paperWidth;

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
