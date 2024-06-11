part of 'signin_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class LoadingSignInState extends SignInState {}

final class SuccessSignInState extends SignInState {
  final UserEntity user;

  const SuccessSignInState({required this.user});

  @override
  List<Object> get props => [user];
}

final class ErrorSignInState extends SignInState {
  final String message;

  const ErrorSignInState({required this.message});

  @override
  List<Object> get props => [message];
}

final class MessageSignInState extends SignInState {
  final String message;

  const MessageSignInState({required this.message});

  @override
  List<Object> get props => [message];
}
