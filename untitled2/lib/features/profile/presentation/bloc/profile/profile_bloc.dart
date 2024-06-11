import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/strings/failure.dart';
import 'package:untitled2/features/profile/data/model/profile_model.dart';
import 'package:untitled2/features/profile/domain/entity/profile_entity.dart';
import 'package:untitled2/features/profile/domain/usecase/profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUserUC profileUserUC;

  ProfileBloc({required this.profileUserUC}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileUserEvent) {
        emit(LoadingProfileState());
        final userOrFailure = await profileUserUC();
        emit(_eitherMessageOrFailure(userOrFailure));
      }
    });
  }

  ProfileState _eitherMessageOrFailure(
      Either<Failure, ProfileModel> either) {
    return either.fold(
      (failure) => ErrorProfileState(message: _mapFailureType(failure)),
      (user) => LoadedProfileState(user: user),
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
