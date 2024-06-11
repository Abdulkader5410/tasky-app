class ErrModel {
  final dynamic errorMsg;
  final dynamic error;
  final dynamic statusCode;

  ErrModel(
      {required this.errorMsg, required this.error, required this.statusCode});

  factory ErrModel.fromJson(Map<String, dynamic> jsonErr) {
    return ErrModel(
        errorMsg: jsonErr['message'],
        error: jsonErr['error'],
        statusCode: jsonErr['statusCode']);
  }
}
