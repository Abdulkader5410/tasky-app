import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/api/dio_consumer.dart';
import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/cache/cache.dart';
import 'package:untitled2/core/errors/exceptions.dart';
import 'package:untitled2/core/models/user_model.dart';

abstract class SignUpRemoteDataSource {
  Future<Unit> signUpUser(UserModel userModel);
}

class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  DioConsumer dio;
  UserModel? userModel;

  SignUpRemoteDataSourceImpl({required this.dio});

  @override
  Future<Unit> signUpUser(UserModel userModel) async {
    try {
      final body = {
        ApiKey.address: userModel.address,
        ApiKey.password: userModel.password,
        ApiKey.phone: userModel.phone,
        ApiKey.displayName: userModel.displayName,
        ApiKey.experienceYears: userModel.experienceYears,
        ApiKey.level: userModel.level,
      };

      final response =
          await dio.post(EndPoints.baseUrl + EndPoints.signup, data: body);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("access_token", response['access_token']);
      sharedPreferences.setString("refresh_token", response['refresh_token']);

      String? x = sharedPreferences.getString("access_token");
      String? x1 = sharedPreferences.getString("refresh_token");

      print("access_token > $x");
      print("refresh_token > $x1");

      print("USER  >>>>>>>>>>>>>>>>>>  $response");

      userModel = UserModel.fromjson(response);

      print(
          "USER  >>>>>>>>>>>>>>>>>>  ${userModel.displayName}"); //sub => userID

      return Future.value(unit);
    } on DioException catch (e) {
      handleEx(e);
      return Future(() => unit);
    }
  }
}
