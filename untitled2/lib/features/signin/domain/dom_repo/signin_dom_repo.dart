import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
abstract class SignInDomRepo {
  Future<Either<Failure, Unit>> signInUser(UserEntity userEntity , BuildContext context);
}
