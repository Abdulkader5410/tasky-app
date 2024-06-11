import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/exception/server_exception.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/network/network_info.dart';
import 'package:untitled2/features/signin/data/data_source/signin_local_data_source.dart';
import 'package:untitled2/features/signin/data/data_source/signin_remote_data_source.dart';
import 'package:untitled2/features/signin/domain/dom_repo/signin_dom_repo.dart';
import 'package:untitled2/features/signup/domain/dom_repo/signup_dom_repo.dart';

class SignInDataRepo extends SignInDomRepo {
  final SignInRemoteDataSource remoteDataSource;
  // final SignInLocalDataSource localDataSource;
  final Networkinfo networkinfo;

  SignInDataRepo(
      {required this.networkinfo,
      required this.remoteDataSource,
      // required this.localDataSource
      });

  @override
  Future<Either<Failure, Unit>> signInUser(UserEntity userEntity , BuildContext context) async {
    final userModel = UserModel(
      displayName: userEntity.displayName,
      phone: userEntity.phone,
      level: userEntity.level,
      experienceYears: userEntity.experienceYears,
      address: userEntity.address,
      password: userEntity.password,
    );

    if (await networkinfo.isConnected) {
      try {
        
        remoteDataSource.signInUser(userModel , context);
        return const Right(unit);

      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}