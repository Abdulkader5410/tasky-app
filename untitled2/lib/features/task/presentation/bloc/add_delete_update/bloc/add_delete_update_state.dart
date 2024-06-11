part of 'add_delete_update_bloc.dart';

sealed class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class LoadingAddDeleteUpdateState extends AddDeleteUpdateState {}

class ErrorAddDeleteUpdateState extends AddDeleteUpdateState {
   final String message;

  const ErrorAddDeleteUpdateState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdateState extends AddDeleteUpdateState {
   final String message;

  const MessageAddDeleteUpdateState({required this.message});

  @override
  List<Object> get props => [message];
}
class LoadedAddDeleteUpdateState extends AddDeleteUpdateState {
   final TaskResEntity task;

  const LoadedAddDeleteUpdateState({required this.task});

  @override
  List<Object> get props => [task];
}
