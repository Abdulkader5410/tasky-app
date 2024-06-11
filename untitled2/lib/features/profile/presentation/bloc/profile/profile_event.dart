part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}



class GetProfileUserEvent extends ProfileEvent {
  

  const GetProfileUserEvent();
  @override
  List<Object> get props => [];
}

