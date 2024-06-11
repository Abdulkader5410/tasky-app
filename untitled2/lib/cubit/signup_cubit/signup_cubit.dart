import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/api/api_consumer.dart';
import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/errors/exceptions.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/cubit/signup_cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.api) : super(SignupInitial());

  ApiConsumer api;
  GlobalKey<FormState> sigupForm = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  UserModel? userModel;

  signup(String level) async {
    try {
      emit(SignupLoading());

      final body = {
        ApiKey.address: addressController.text,
        ApiKey.password: passController.text,
        ApiKey.phone: phoneController.text,
        ApiKey.displayName: nameController.text,
        ApiKey.experienceYears: yearController.text,
        ApiKey.level: level
      };

      final response =
          await api.post(EndPoints.baseUrl + EndPoints.signup, data: body);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("access_token", response['access_token']);
      sharedPreferences.setString("refresh_token", response['refresh_token']);

     

      userModel = UserModel.fromjson(response);

      

      emit(SignupSuccess());
    } on ServerDioException catch (e) {
      log("ABD");
      emit(SignupFailure(errMsg: e.errModel.errorMsg));
    }
  }
}
