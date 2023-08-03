class Status{
  int? code;
  String? message;

  Status({
    required this.code,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }

  factory Status.fromJson(Map<String, dynamic> map) {
    return Status(
      code: map['code'],
      message: map['message'],
    );
  }
}