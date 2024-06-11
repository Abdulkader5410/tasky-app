import 'package:dartz/dartz.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
abstract class SignUpDomRepo {
  Future<Either<Failure, Unit>> signUpUser(UserEntity userEntity);
}
