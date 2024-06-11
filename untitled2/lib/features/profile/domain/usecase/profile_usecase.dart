
import 'package:dartz/dartz.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/profile/data/model/profile_model.dart';
import 'package:untitled2/features/profile/domain/dom_repo/profile_dom_repo.dart';


class ProfileUserUC {
  late final ProfileDomRepo profileDomRepo;

  ProfileUserUC({required this.profileDomRepo});

  Future<Either<Failure, ProfileModel>> call() async {
    return await profileDomRepo.profileUser();
  }
}
