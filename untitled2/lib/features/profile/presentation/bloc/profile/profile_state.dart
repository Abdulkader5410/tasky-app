part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class LoadingProfileState extends ProfileState {}

final class LoadedProfileState extends ProfileState {
  final ProfileEntity user;

  const LoadedProfileState({required this.user});

  @override
  List<Object> get props => [user];
}

final class ErrorProfileState extends ProfileState {
  final String message;

  const ErrorProfileState({required this.message});

  @override
  List<Object> get props => [message];
}
