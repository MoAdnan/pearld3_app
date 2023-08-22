import 'dart:convert';

class CommonModel {
  int? TransactionType;
  String? Input1;
  String? Input2;
  String? Input3;
  String? Input4;
  String? Input5;
  String? Input6;
  DateTime? Input7;
  String? Output1;
  String? Output2;
  String? Output3;
  String? Output4;
  String? Output5;
  String? Output6;
  DateTime? Output7;

  CommonModel(
      {this.TransactionType,
      this.Input1,
      this.Input2,
      this.Input3,
      this.Input4,
      this.Input5,
      this.Input6,
      this.Input7,
      this.Output1,
      this.Output2,
      this.Output3,
      this.Output4,
      this.Output5,
      this.Output6,
      this.Output7});

  Map<String, dynamic> toJson() => {
        "TransactionType": TransactionType,
        "Input1": Input1,
        "Input2": Input2,
        "Input3": Input3,
        "Input4": Input4,
        "Input5": Input5,
        "Input6": Input6,
        "Input7": Input7,
        "Output1": Output1,
        "Output2": Output2,
        "Output3": Output3,
        "Output4": Output4,
        "Output5": Output5,
        "Output6": Output6,
        "Output7": Output7
      };
}

commonModelfromJson(Map<String, dynamic> json) => CommonModel(
      TransactionType: int.parse(json["TransactionType"].toString()),
      Input1: json["Input1"].toString(),
      Input2: json["Input2"].toString(),
      Input3: json["Input3"].toString(),
      Input4: json["Input4"].toString(),
      Input5: json["Input5"].toString(),
      Input6: json["Input6"].toString(),
      Input7: DateTime.parse(json["Input7"].toString()),
      Output1: json["Output1"].toString(),
      Output2: json["Output2"].toString(),
      Output3: json["Output3"].toString(),
      Output4: json["Output4"].toString(),
      Output5: json["Output5"].toString(),
      Output6: json["Output6"].toString(),
      Output7: DateTime.parse(json["Output7"].toString()),
    );

/// Represents input data for the database.
class DbInputs {
  /// The requested date for the data.
  DateTime? reqdate;

  /// The unique identifier for the outlet.
  String? outletUID;

  /// The device ID associated with the data.
  int? deviceID;

  /// The reference identifier.
  String? refUID;

  /// The key for the report.
  String? reportKey = '';

  /// The width of the paper (default value: 560).
  int paperWidth = 560;

  /// Indicates whether PDF mode is enabled (default value: false).
  bool pdfMode = false;

  /// Creates a new [DbInputs] instance.
  DbInputs(
      {this.reqdate,
      this.outletUID,
      this.deviceID,
      this.refUID,
      this.reportKey,
      this.paperWidth = 560});

  /// Converts the [DbInputs] instance to a JSON representation.
  Map<String, dynamic> toJson() => {
        "reqdate": reqdate!.toIso8601String(),
        "outletUID": outletUID,
        "deviceID": deviceID,
        "refUID": refUID,
        "reportKey": reportKey,
        "paperWidth": paperWidth,
        "pdfMode": pdfMode,
      };
}

/// Creates a [DbInputs] instance from a JSON map.
dbInputsfromJson(Map<String, dynamic> json) => DbInputs(
    reqdate: DateTime.parse(json["reqdate"].toString()),
    outletUID: json["outletUID"].toString(),
    deviceID: int.parse(json["deviceID"].toString()),
    refUID: json["refUID"].toString(),
    reportKey: json["reportKey"].toString());

class ReportsData {
  String? reportKey;
  double? value;
  ReportsData({this.reportKey, this.value});
}

reportsDatafromJson(Map<String, dynamic> json) => ReportsData(
      reportKey: json["reportKey"].toString(),
      value: double.parse(json["value"].toString()),
    );

class PearlReportObject {
  List<ReportColumns>? columns;
  List<dynamic>? data;
  String title = "";
  String subTitle = "";
  String groupColumn = "";
  String drillColumn = "";

  PearlReportObject({
    this.columns,
    this.data,
  });
}

List<PearlReportObject> listOfPearlReportObjectFromJson(String str) =>
    List<PearlReportObject>.from(
        json.decode(str).map((x) => pearlReportObjectFromJson(x)));

pearlReportObjectFromJson(Map<String, dynamic> json) => PearlReportObject(
    columns: listOfReportColumnsFromJson(json["columns"].toString()),
    data: null // listOfDynamicFromJson(json["data"].toString()),
    );

List<dynamic> listOfDynamicFromJson(String str) => List<dynamic>.from(
    json.decode(str).map((x) => pearlReportColumnsFromJson(x)));

class ReportColumns {
  String? columnName;
  String? title;
  String? dataType;
  bool? visibleInGroup;
  bool? visibleInChild;
  int? lineNumber;
  bool? summaryColumn;
  int? formatType = 0;
  int? colorCode = 0;
  int? alignCode = 0;

  ReportColumns(
      {this.columnName,
      this.title,
      this.dataType,
      this.visibleInGroup,
      this.visibleInChild,
      this.lineNumber,
      this.summaryColumn,
      this.formatType,
      this.colorCode,
      this.alignCode});

  Map<String, dynamic> toJson() => {
        "columnName": columnName,
        "title": title,
        "dataType": dataType,
        "visibleInGroup": visibleInGroup,
        "visibleInChild": visibleInChild,
        "lineNumber": lineNumber,
        "summaryColumn": summaryColumn,
        "formatType": formatType,
        "colorCode": colorCode,
        "alignCode": alignCode,
      };
}

List<ReportColumns> listOfReportColumnsFromJson(String str) =>
    List<ReportColumns>.from(json.decode(str).map((x) {
      pearlReportColumnsFromJson(x);
    }));

pearlReportColumnsFromJson(Map<String, dynamic> json) => ReportColumns(
      columnName: json["columnName"].toString(),
      title: json["title"].toString(),
      dataType: json["dataType"].toString(),
      visibleInGroup: json["visibleInGroup"] as bool,
      visibleInChild: json["visibleInChild"] as bool,
      lineNumber: int.parse(json["lineNumber"].toString()),
      summaryColumn: json['summaryColumn'] as bool,
      formatType: int.parse(json["formatType"].toString()),
      colorCode: int.parse(json["colorCode"].toString()),
      alignCode: int.parse(json["alignCode"].toString()),
    );

class PrintData {
  String? header;
  List<dynamic> data = [];
  PrintData({
    this.header,
  });
}
