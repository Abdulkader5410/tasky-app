import 'package:ecommerce_app/models/user_model.dart';

class UserState {}

class UserStateInitial extends UserState {}

class SigninStateLoading extends UserState {}

class SigninStateSuccess extends UserState {}

class SigninStateFailure extends UserState {
  final errorMsg;

  SigninStateFailure({required this.errorMsg});
}

class GetUserLoading extends UserState {}

class GetUserLoaded extends UserState {
  UserModel userModel;


  GetUserLoaded({required this.userModel});



}

class GetUserFailure extends UserState {
  final errorMsg;

  GetUserFailure({required this.errorMsg});
}
