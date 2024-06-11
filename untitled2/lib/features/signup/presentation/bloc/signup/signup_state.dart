part of 'signup_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class LoadingSignUpState extends SignUpState {}

final class SuccessSignUpState extends SignUpState {
  final UserEntity user;

  const SuccessSignUpState({required this.user});

  @override
  List<Object> get props => [user];
}

final class ErrorSignUpState extends SignUpState {
  final String message;

  const ErrorSignUpState({required this.message});

  @override
  List<Object> get props => [message];
}

final class MessageSignUpState extends SignUpState {
  final String message;

  const MessageSignUpState({required this.message});

  @override
  List<Object> get props => [message];
}
