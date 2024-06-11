import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/enitity/user_entity.dart';
import 'package:untitled2/features/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    super.id,
    super.username,
    super.displayName,
    super.level,
    super.experienceYears,
    super.address,
  });

  factory ProfileModel.fromjson(Map<String, dynamic> jsonDate) {
    return ProfileModel(
      id: jsonDate['_id'],
      displayName: jsonDate[ApiKey.displayName],
      // password: jsonDate[ApiKey.password],
      level: jsonDate[ApiKey.level],
      experienceYears: jsonDate[ApiKey.experienceYears],
      address: jsonDate[ApiKey.address],
      username: jsonDate[ApiKey.username],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': ApiKey.id,
      'displayName': ApiKey.displayName,
      // password: ApiKey.password,
      'level': ApiKey.level,
      'experienceYears': ApiKey.experienceYears,
      'address': ApiKey.address,
      'username': ApiKey.username,
    };
  }
}
