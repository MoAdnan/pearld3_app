class Status {
  String? message;
  int? code;

  Status({
    required this.message,
    required this.code,
  });

  @override
  String toString() {
    return 'AppError{message: $message, code: $code}';
  }

  Map<String, dynamic> toJson() {
    return {
      'message': this.message,
      'code': this.code,
    };
  }

  factory Status.fromJson(Map<String, dynamic> map) {
    return Status(
      message: map['message'],
      code: map['code'],
    );
  }

  Status copyWith({
    String? message,
    int? code,
  }) {
    return Status(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
