
class ErrorModel {
  
  final String errorMsg;

  ErrorModel({ required this.errorMsg});

  factory ErrorModel.fromJson(String jsonDate) {
    return ErrorModel(
        errorMsg: jsonDate);
  }
}