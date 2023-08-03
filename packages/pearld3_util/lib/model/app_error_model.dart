class ApiErrorModel{
  int? code;
  String? message;

  ApiErrorModel({
    required this.code,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }

  factory ApiErrorModel.fromJson(Map<String, dynamic> map) {
    return ApiErrorModel(
      code: map['code'],
      message: map['message'],
    );
  }
}