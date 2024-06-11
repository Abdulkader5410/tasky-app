import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/api/api_consumer.dart';
import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/errors/exceptions.dart';
import 'package:untitled2/features/signin/data/model/sigin_model.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.api) : super(SigninInitial());

  ApiConsumer api;
  GlobalKey<FormState> siginForm = GlobalKey();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  SignInModel? signInModel;

  signin() async {
    try {
      emit(SigninLoading());

      final body = {
        ApiKey.password: passController.text,
        ApiKey.phone: phoneController.text,
      };

      final response =
          await api.post(EndPoints.baseUrl + EndPoints.signin, data: body);

          
      print("USER  >>>>>>>>>>>>>>>>>>  $response");

      signInModel = SignInModel.fromjson(response);

      final decodedToken = JwtDecoder.decode(signInModel!.accessToken!);

      print("decodedToken : ${decodedToken['userId']}");

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString("access_token", response['access_token']);
      sharedPreferences.setString("refresh_token", response['refresh_token']);

     

      emit(SigninSuccess());

      
      
    }  on ServerDioException catch (e) {
      log("ABD");
      emit(SigninFailure(errMsg: e.errModel.errorMsg));
    }
  }
}