import 'company_settings_model.dart';
import 'device_settings_model.dart';
import 'login_credential_model.dart';

class UserCredentialModel {
  String? code;
  String? employeeName;
  String? employeeCode;
  String? mobileNo1;
  String? employeeUID;
  String? companyUID;
  String? companyName;
  String? currencyUID;
  String? description;
  String? currencySymbol;
  String? outletUID;
  String? outletName;
  int? outletID;
  String? outletCode;
  String? branchUID;
  String? branchName;
  String? branchCode;
  String? deviceUID;
  DeviceSettingModel? deviceSetting;
  int? deviceID;
  String? userGroupUID;
  String? groupName;
  int? type;
  CompanySettingModel? companySetting;

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

  @override
  String toString() {
    return 'UserCredentialModel{code: $code, employeeName: $employeeName, employeeCode: $employeeCode, mobileNo1: $mobileNo1, employeeUID: $employeeUID, companyUID: $companyUID, companyName: $companyName, currencyUID: $currencyUID, description: $description, currencySymbol: $currencySymbol, outletUID: $outletUID, outletName: $outletName, outletID: $outletID, outletCode: $outletCode, branchUID: $branchUID, branchName: $branchName, branchCode: $branchCode, deviceUID: $deviceUID, deviceSetting: $deviceSetting, deviceID: $deviceID, userGroupUID: $userGroupUID, groupName: $groupName, type: $type, companySetting: $companySetting}';
  }

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
