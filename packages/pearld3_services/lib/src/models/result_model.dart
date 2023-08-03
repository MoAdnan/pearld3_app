class ResultModel{
  int? statusCode;
  String? status;
  Map<String,dynamic>? response;

  ResultModel({
    this.statusCode,
    this.status,
    required this.response,
  });

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'status': status,
      'response': response,
    };
  }

  factory ResultModel.fromJson(Map<String, dynamic> map) {
    return ResultModel(
      statusCode: map['statusCode'],
      status: map['status'],
      response: map['response'],
    );
  }
}

