import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled2/core/api/dio_consumer.dart';
import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/errors/exceptions.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/profile/data/model/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> profileUser();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  DioConsumer dio;
  ProfileModel? profileModel;

  ProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<ProfileModel> profileUser() async {
    
    try {
      // final body = {
      //   ApiKey.experienceYears: userModel.experienceYears,
      //   ApiKey.password: userModel.password,
      //   ApiKey.phone: userModel.phone,
      //   ApiKey.address: userModel.address,
      //   ApiKey.displayName: userModel.displayName,
      //   ApiKey.level: userModel.level,
      // };

      final response =
          await dio.get(EndPoints.baseUrl + EndPoints.profile);

      print("PROFILE  >>>>>>>>>>>>>>>>>>  $response");

      profileModel = ProfileModel.fromjson(response);

  
      return Future.value(profileModel);
      
    } on DioException catch (e) {
      handleEx(e);
      return Future.value(profileModel);
    }
  }
}
