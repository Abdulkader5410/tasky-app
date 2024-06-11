// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {

  String? id;
  String? accessToken;
  String? refreshToken;
  // String? displayName;

  SignInEntity(
      { this.id, this.accessToken, this.refreshToken });
  @override
  List<Object?> get props => [id, accessToken, refreshToken];
}
