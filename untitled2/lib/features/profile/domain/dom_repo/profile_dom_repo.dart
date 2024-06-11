
import 'package:dartz/dartz.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/profile/data/model/profile_model.dart';

abstract class ProfileDomRepo {
  Future<Either<Failure, ProfileModel>> profileUser();
}
