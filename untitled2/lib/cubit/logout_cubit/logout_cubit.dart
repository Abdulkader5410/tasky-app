import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/api/api_consumer.dart';
import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/errors/exceptions.dart';
import 'package:untitled2/cubit/logout_cubit/logout_state.dart';
import 'package:untitled2/features/signin/data/model/sigin_model.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.api) : super(LogoutInitial());

  ApiConsumer api;

  SignInModel? signInModel;
  late SharedPreferences sp;

  Future<dynamic> getToken() async {
    sp = await SharedPreferences.getInstance();

    dynamic user = sp.getString("access_token");
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  logout() async {
    dynamic token = await getToken();

    try {
      emit(LogoutLoading());

      final body = {ApiKey.token: token};

      final response = await api.post(EndPoints.logout, data: body);

      emit(LogoutSuccess());
      sp.clear();
      sp.remove("access_token");
      sp.remove("refresh_token");
    } on ServerDioException catch (e) {
      log("ABD");
      emit(LogoutFailure(errMsg: e.errModel.errorMsg));
    }
  }
}
