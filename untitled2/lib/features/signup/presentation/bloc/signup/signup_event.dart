part of 'signup_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}



class SignUpUserEvent extends SignUpEvent {
  final UserEntity user;

  const SignUpUserEvent({required this.user});
  @override
  List<Object> get props => [user];
}

