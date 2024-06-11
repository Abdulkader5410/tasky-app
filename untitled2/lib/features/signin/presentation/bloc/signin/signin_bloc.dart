import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/strings/failure.dart';
import 'package:untitled2/features/signin/domain/usecase/signin_usecase.dart';
import 'package:untitled2/features/signup/domain/usecase/signup_usecase.dart';
import 'package:untitled2/features/signup/presentation/bloc/signup/signup_bloc.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUserUC signInUserUC;

  SignInBloc({required this.signInUserUC}) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      if (event is 
      SignInUserEvent) {
        emit(LoadingSignInState());
        final messageOrFailure = await signInUserUC(event.user , event.context);
        emit(_eitherMessageOrFailure(messageOrFailure, event.user));
      }
    });
  }

  SignInState _eitherMessageOrFailure(
      Either<Failure, Unit> either, UserEntity user) {
    return either.fold(
      (failure) => ErrorSignInState(message: _mapFailureType(failure)),
      (users) => SuccessSignInState(user: user),
    );
  }

  String _mapFailureType(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;


      default:
        return "Unexpcted Error";
    }
  }

  
}
