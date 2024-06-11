import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/features/signin/domain/entity/signin_entity.dart';

class SignInModel extends SignInEntity {
  SignInModel({
    super.id,
    super.accessToken,
    super.refreshToken,
    // super.displayName,
  });

  factory SignInModel.fromjson(Map<String, dynamic> jsonDate) {
    return SignInModel(
      id: jsonDate['_id'],
      // displayName: jsonDate[ApiKey.displayName],
      accessToken: jsonDate[ApiKey.accessToken],
      refreshToken: jsonDate[ApiKey.refreshToken],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': ApiKey.id,
      // 'displayName': ApiKey.displayName,
      // password: ApiKey.password,
      'access_token': ApiKey.accessToken,
      'refresh_token': ApiKey.refreshToken,
    };
  }
}
