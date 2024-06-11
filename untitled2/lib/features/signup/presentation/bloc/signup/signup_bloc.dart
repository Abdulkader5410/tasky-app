import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/strings/failure.dart';
import 'package:untitled2/features/signup/domain/usecase/signup_usecase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUserUC signUpUserUC;
  

  SignUpBloc({required this.signUpUserUC}) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpUserEvent) {
        emit(LoadingSignUpState());
        final messageOrFailure = await signUpUserUC(event.user);
        emit(_eitherMessageOrFailure(messageOrFailure, event.user));
      }
    });
  }

  SignUpState _eitherMessageOrFailure(
      Either<Failure, Unit> either, UserEntity user) {
    return either.fold(
      (failure) => ErrorSignUpState(message: _mapFailureType(failure)),
      (posts) => SuccessSignUpState(user: user),
    );
  }

  String _mapFailureType(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return SERVER_FAILURE_MESSAGE;

      default:
        return "Unexpcted Error";
    }
  }

  
}
