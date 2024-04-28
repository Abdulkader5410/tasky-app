import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/endpoints.dart';
import 'package:ecommerce_app/core/errors/exceptions.dart';
import 'package:ecommerce_app/cubit/user_state.dart';
import 'package:ecommerce_app/models/signin_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class UserCubit extends Cubit<UserState> {

  UserCubit(this.api) : super(UserStateInitial());

  ApiConsumer api;

  GlobalKey<FormState> formSignin = GlobalKey();
  TextEditingController emailControllerSignin = TextEditingController();
  TextEditingController passControllerSignin = TextEditingController();

  GlobalKey<FormState> formSignup = GlobalKey();
  TextEditingController nameControllerSignup = TextEditingController();
  TextEditingController emailControllerSignup = TextEditingController();
  TextEditingController passControllerSignup = TextEditingController();

  SigninModel? user;

  signIn() async {
    try {
      emit(SigninStateLoading());
      final response = await api.post(EndPoints.signin, data: {
        ApiKey.email: emailControllerSignin.text.trim().toString(),
        ApiKey.password: passControllerSignin.text.trim().toString()
      });

      user = SigninModel.fromjson(response);

      final decodedToken = JwtDecoder.decode(user!.token);

      print("USER ${decodedToken['user']}");

      emit(SigninStateSuccess());
    } on ServerException catch (e) {
      emit(SigninStateFailure(errorMsg: e.errorModel.errorMsg));
    }
  }

  getUserProfile() async {
    try {
      emit(GetUserLoading());
      final response = await api.get(EndPoints.getUserEndPoint(1));

      emit(GetUserLoaded(userModel: UserModel.fromjson(response)));


    } on ServerException catch (e) {
      emit(GetUserFailure(errorMsg: e.errorModel.errorMsg));
    }
  
  
  }

}