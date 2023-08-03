import 'user_credential_model.dart';

class LoginCredentialModel {
  UserCredentialModel? userCredential;
  String? token;
  String? refresh;
  String? fcmKey;
  String? message;

  LoginCredentialModel(
      {this.userCredential,
      this.token,
      this.refresh,
      this.fcmKey,
      this.message});

  @override
  String toString() {
    return 'LoginCredentialModel{userUserredential: $userCredential, token: $token, refresh: $refresh, fcmKey: $fcmKey, message: $message}';
  }

  LoginCredentialModel.fromJson(Map<String, dynamic> json) {
    userCredential = json['credential'] != null
        ? UserCredentialModel.fromJson(json['credential'])
        : null;
    token = json['token'];
    refresh = json['refresh'];
    fcmKey = json['fcm_key'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userCredential != null) {
      data['credential'] = this.userCredential!.toJson();
    }
    data['token'] = this.token;
    data['refresh'] = this.refresh;
    data['fcm_key'] = this.fcmKey;
    data['message'] = this.message;
    return data;
  }
}
