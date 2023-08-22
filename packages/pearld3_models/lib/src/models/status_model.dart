/// Represents a status message with a code.
class Status {
  /// The message associated with the status.
  String? message;

  /// The code associated with the status.
  int? code;

  /// Creates a [Status] instance.
  ///
  /// The [message] is the message associated with the status.
  /// The [code] is the code associated with the status.
  Status({
    required this.message,
    required this.code,
  });

  /// Returns a string representation of the [Status] instance.
  @override
  String toString() {
    return 'AppError{message: $message, code: $code}';
  }

  /// Converts the [Status] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'message': this.message,
      'code': this.code,
    };
  }

  /// Creates a [Status] instance from a JSON map.
  factory Status.fromJson(Map<String, dynamic> map) {
    return Status(
      message: map['message'],
      code: map['code'],
    );
  }

  /// Creates a copy of the [Status] instance with optional parameter overrides.
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
