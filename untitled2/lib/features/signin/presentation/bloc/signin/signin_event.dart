part of 'signin_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}



class SignInUserEvent extends SignInEvent {
  final UserEntity user;
  final BuildContext context;

  const SignInUserEvent({required this.user , required this.context});
  @override
  List<Object> get props => [user];
}

