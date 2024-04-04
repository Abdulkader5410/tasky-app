import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure implements Failure {
  @override
  List<Object?> get props => [];
  @override
  bool? get stringify => false;
}

class ServerFailure implements Failure {
  @override
  List<Object?> get props => [];
  @override
  bool? get stringify => false;
}

class EmptyFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}
