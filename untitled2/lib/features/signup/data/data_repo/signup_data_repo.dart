import 'package:dartz/dartz.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/exception/server_exception.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/network/network_info.dart';
import 'package:untitled2/features/signup/data/data_source/signup_local_data_source.dart';
import 'package:untitled2/features/signup/data/data_source/signup_remote_data_source.dart';
import 'package:untitled2/features/signup/domain/dom_repo/signup_dom_repo.dart';

class SignUpDataRepo extends SignUpDomRepo {
  final SignUpRemoteDataSource remoteDataSource;
  // final SignUpLocalDataSource localDataSource;
  final Networkinfo networkinfo;

  SignUpDataRepo(
      {required this.networkinfo,
      required this.remoteDataSource,
      // required this.localDataSource
      });

  @override
  Future<Either<Failure, Unit>> signUpUser(UserEntity userEntity) async {
    final userModel = UserModel(
      address: userEntity.address,
      displayName: userEntity.displayName,
      experienceYears: userEntity.experienceYears,
      level: userEntity.level,
      password: userEntity.password,
      phone: userEntity.phone,
    );

    if (await networkinfo.isConnected) {
      try {
        remoteDataSource.signUpUser(userModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
