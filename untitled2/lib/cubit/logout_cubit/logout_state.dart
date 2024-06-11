
import 'package:equatable/equatable.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}
final class LogoutSuccess extends LogoutState {}
final class LogoutFailure extends LogoutState {

  final String errMsg;

  const LogoutFailure({required this.errMsg});
    @override
  List<Object> get props => [errMsg];


}
