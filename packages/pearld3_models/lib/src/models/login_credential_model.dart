import 'user_credential_model.dart';

/// Represents the login credential model containing user information and authentication details.
class LoginCredentialModel {
  /// The user's credential information.
  UserCredentialModel? userCredential;

  /// The authentication token obtained after successful login.
  String? token;

  /// The refresh token used to obtain a new authentication token.
  String? refresh;

  /// The Firebase Cloud Messaging (FCM) key associated with the user.
  String? fcmKey;

  /// A message associated with the login process.
  String? message;

  /// Constructs a [LoginCredentialModel] instance with optional parameters.
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

  /// Constructs a [LoginCredentialModel] instance from a JSON map.
  LoginCredentialModel.fromJson(Map<String, dynamic> json) {
    userCredential = json['credential'] != null
        ? UserCredentialModel.fromJson(json['credential'])
        : null;
    token = json['token'];
    refresh = json['refresh'];
    fcmKey = json['fcm_key'];
    message = json['message'];
  }

  /// Converts the [LoginCredentialModel] instance to a JSON map.
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
