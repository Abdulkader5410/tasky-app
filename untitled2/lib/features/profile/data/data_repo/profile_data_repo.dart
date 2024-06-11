import 'package:dartz/dartz.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/exception/server_exception.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/network/network_info.dart';
import 'package:untitled2/features/profile/data/data_source/profile_local_data_source.dart';
import 'package:untitled2/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:untitled2/features/profile/data/model/profile_model.dart';
import 'package:untitled2/features/profile/domain/dom_repo/profile_dom_repo.dart';



class ProfileDataRepo extends ProfileDomRepo {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final Networkinfo networkinfo;

  ProfileDataRepo(
      {required this.networkinfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure,ProfileModel>> profileUser() async {

    // final userModel = UserModel(
    //   phone: userEntity.phone,
    //   displayName: userEntity.displayName,
    //   level: userEntity.level,
    //   experienceYears: userEntity.experienceYears,
    //   address: userEntity.address,
    //   password: userEntity.password,
    // );

    if (await networkinfo.isConnected) {
      try {
       ProfileModel user = await remoteDataSource.profileUser();
        return  Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
