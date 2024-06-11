import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/api/dio_consumer.dart';
import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/utilities/error_dialog.dart';
import 'package:untitled2/features/signin/data/model/sigin_model.dart';

abstract class SignInRemoteDataSource {
  Future<Unit> signInUser(UserModel userModel, BuildContext context);
}

class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  DioConsumer dio;
  SignInModel? signInModel;

  SignInRemoteDataSourceImpl({required this.dio});

  @override
  Future<Unit> signInUser(UserModel userModel, BuildContext context) async {
    try {
      final body = {
        ApiKey.password: userModel.password,
        ApiKey.phone: userModel.phone,
      };

      final response =
          await dio.post(EndPoints.baseUrl + EndPoints.signin, data: body);

      print("USER  >>>>>>>>>>>>>>>>>>  $response");

      signInModel = SignInModel.fromjson(response);

      final decodedToken = JwtDecoder.decode(signInModel!.accessToken!);

      print("decodedToken : ${decodedToken['userId']}");

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString("access_token", response['access_token']);
      sharedPreferences.setString("refresh_token", response['refresh_token']);

      String? x = sharedPreferences.getString("access_token");
      String? x1 = sharedPreferences.getString("refresh_token");

      print("access_token > $x");
      print("refresh_token > $x1");

      return Future.value(unit);
    } on DioException catch (e) {
      showErrorDialog(e, context);
      return Future(() => unit);
    }
  }
}
