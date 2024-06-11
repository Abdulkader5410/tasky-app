import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/features/signin/domain/dom_repo/signin_dom_repo.dart';


class SignInUserUC {
  late final SignInDomRepo signInDomRepo;

  SignInUserUC({required this.signInDomRepo});

  Future<Either<Failure, Unit>> call(UserEntity userEntity , BuildContext context) async {
    return await signInDomRepo.signInUser(userEntity , context);
  }
}
