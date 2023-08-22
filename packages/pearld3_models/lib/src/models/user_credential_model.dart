import 'company_settings_model.dart';
import 'device_settings_model.dart';

/// Represents the credentials of a user.
class UserCredentialModel {
  /// The code associated with the user.
  String? code;

  /// The name of the employee.
  String? employeeName;

  /// The code of the employee.
  String? employeeCode;

  /// The mobile number of the employee.
  String? mobileNo1;

  /// The UID of the employee.
  String? employeeUID;

  /// The UID of the company.
  String? companyUID;

  /// The name of the company.
  String? companyName;

  /// The UID of the currency.
  String? currencyUID;

  /// The description associated with the user.
  String? description;

  /// The currency symbol associated with the user.
  String? currencySymbol;

  /// The UID of the outlet.
  String? outletUID;

  /// The name of the outlet.
  String? outletName;

  /// The ID of the outlet.
  int? outletID;

  /// The code of the outlet.
  String? outletCode;

  /// The UID of the branch.
  String? branchUID;

  /// The name of the branch.
  String? branchName;

  /// The code of the branch.
  String? branchCode;

  /// The UID of the device.
  String? deviceUID;

  /// The device settings associated with the user.
  DeviceSettingModel? deviceSetting;

  /// The ID of the device.
  int? deviceID;

  /// The UID of the user group.
  String? userGroupUID;

  /// The name of the user group.
  String? groupName;

  /// The type of the user.
  int? type;

  /// The company settings associated with the user.
  CompanySettingModel? companySetting;

  /// Creates a [UserCredentialModel] instance.
  UserCredentialModel(
      {this.code,
      this.employeeName,
      this.employeeCode,
      this.mobileNo1,
      this.employeeUID,
      this.companyUID,
      this.companyName,
      this.currencyUID,
      this.description,
      this.currencySymbol,
      this.outletUID,
      this.outletName,
      this.outletID,
      this.outletCode,
      this.branchUID,
      this.branchName,
      this.branchCode,
      this.deviceUID,
      this.deviceSetting,
      this.deviceID,
      this.userGroupUID,
      this.groupName,
      this.type,
      this.companySetting});

  /// Returns a string representation of the [UserCredentialModel] instance.
  @override
  String toString() {
    return 'UserCredentialModel{code: $code, employeeName: $employeeName, employeeCode: $employeeCode, mobileNo1: $mobileNo1, employeeUID: $employeeUID, companyUID: $companyUID, companyName: $companyName, currencyUID: $currencyUID, description: $description, currencySymbol: $currencySymbol, outletUID: $outletUID, outletName: $outletName, outletID: $outletID, outletCode: $outletCode, branchUID: $branchUID, branchName: $branchName, branchCode: $branchCode, deviceUID: $deviceUID, deviceSetting: $deviceSetting, deviceID: $deviceID, userGroupUID: $userGroupUID, groupName: $groupName, type: $type, companySetting: $companySetting}';
  }

  /// Creates a [UserCredentialModel] instance from a JSON map.
  UserCredentialModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    employeeName = json['employeeName'];
    employeeCode = json['employeeCode'];
    mobileNo1 = json['mobileNo1'];
    employeeUID = json['employeeUID'];
    companyUID = json['companyUID'];
    companyName = json['companyName'];
    currencyUID = json['currencyUID'];
    description = json['description'];
    currencySymbol = json['currencySymbol'];
    outletUID = json['outletUID'];
    outletName = json['outletName'];
    outletID = json['outletID'];
    outletCode = json['outletCode'];
    branchUID = json['branchUID'];
    branchName = json['branchName'];
    branchCode = json['branchCode'];
    deviceUID = json['deviceUID'];
    deviceSetting = json['deviceSetting'] != null
        ? new DeviceSettingModel.fromJson(json['deviceSetting'])
        : null;
    deviceID = json['deviceID'];
    userGroupUID = json['userGroupUID'];
    groupName = json['groupName'];
    type = json['type'];
    companySetting = json['companySetting'] != null
        ? new CompanySettingModel.fromJson(json['companySetting'])
        : null;
  }

  /// Converts the [UserCredentialModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['employeeName'] = this.employeeName;
    data['employeeCode'] = this.employeeCode;
    data['mobileNo1'] = this.mobileNo1;
    data['employeeUID'] = this.employeeUID;
    data['companyUID'] = this.companyUID;
    data['companyName'] = this.companyName;
    data['currencyUID'] = this.currencyUID;
    data['description'] = this.description;
    data['currencySymbol'] = this.currencySymbol;
    data['outletUID'] = this.outletUID;
    data['outletName'] = this.outletName;
    data['outletID'] = this.outletID;
    data['outletCode'] = this.outletCode;
    data['branchUID'] = this.branchUID;
    data['branchName'] = this.branchName;
    data['branchCode'] = this.branchCode;
    data['deviceUID'] = this.deviceUID;
    if (this.deviceSetting != null) {
      data['deviceSetting'] = this.deviceSetting!.toJson();
    }
    data['deviceID'] = this.deviceID;
    data['userGroupUID'] = this.userGroupUID;
    data['groupName'] = this.groupName;
    data['type'] = this.type;
    if (this.companySetting != null) {
      data['companySetting'] = this.companySetting!.toJson();
    }
    return data;
  }
}
