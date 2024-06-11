// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {

  String? id;
  String? displayName;
  String? username;
  String? level;
  String? address;
  int? experienceYears;

  ProfileEntity(
      {this.displayName,
      this.id,
      this.username,
      this.address,
      this.level,
      this.experienceYears,
      });
  @override
  List<Object?> get props => [
        id,
        username,
        
        displayName,
        level,
        address,
        experienceYears,
      ];
}
