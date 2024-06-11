import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/enitity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.password,
    super.phone,
    super.displayName,
    super.level,
    super.experienceYears,
    super.address,
  });

  factory UserModel.fromjson(Map<String, dynamic> jsonDate) {
    return UserModel(
      id: jsonDate[ApiKey.id],
      displayName: jsonDate[ApiKey.displayName],
      // password: jsonDate[ApiKey.password],
      level: jsonDate[ApiKey.level],
      experienceYears: jsonDate[ApiKey.experienceYears],
      address: jsonDate[ApiKey.address],
      phone: jsonDate[ApiKey.phone],
      password: jsonDate[ApiKey.password],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': ApiKey.id,
      'displayName': ApiKey.displayName,
      // password: ApiKey.password,
      'level': ApiKey.level,
      'experienceYears': ApiKey.experienceYears,
      'address': ApiKey.address,
      'phone': ApiKey.phone,
      'password': ApiKey.password,
    };
  }
}
