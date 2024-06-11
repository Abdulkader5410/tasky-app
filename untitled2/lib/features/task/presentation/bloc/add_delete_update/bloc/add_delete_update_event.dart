part of 'add_delete_update_bloc.dart';

sealed class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends AddDeleteUpdateEvent {
  TaskEntity task;
  AddTaskEvent({required this.task});
  @override
  List<Object> get props => [];
}

class DeleteTaskEvent extends AddDeleteUpdateEvent {
  final String taskId;

  DeleteTaskEvent({required this.taskId});

  @override
  List<Object> get props => [];
}

class UpdateTaskEvent extends AddDeleteUpdateEvent {
  final TaskResEntity task;

  UpdateTaskEvent({required this.task});

  @override
  List<Object> get props => [];
}