import 'package:ecommerce_app/core/api/endpoints.dart';

class SigninModel {
  final String token;

  SigninModel({required this.token});

  factory SigninModel.fromjson(Map<String, dynamic> jsonDate) {
    return SigninModel(token: jsonDate[ApiKey.token]);

    
  }
}
