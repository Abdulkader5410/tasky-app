import 'package:dartz/dartz.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/features/signup/domain/dom_repo/signup_dom_repo.dart';


class SignUpUserUC {
  late final SignUpDomRepo signupDomRepo;

  SignUpUserUC({required this.signupDomRepo});

  Future<Either<Failure, Unit>> call(UserEntity userEntity) async {
    return await signupDomRepo.signUpUser(userEntity);
  }
}
