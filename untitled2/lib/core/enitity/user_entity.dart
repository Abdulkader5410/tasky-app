// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  int? id;
  String? password;
  String? displayName;
  String? phone;
  String? level;
  String? address;
  int? experienceYears;

  UserEntity(
      {this.displayName,
      this.id,
      this.password,
      this.address,
      this.level,
      this.experienceYears,
      this.phone});
  @override
  List<Object?> get props => [
        id,
        phone,
        password,
        displayName,
        level,
        address,
        experienceYears,
      ];
}
