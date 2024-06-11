part of 'task_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

final class LoadingTasksState extends TasksState {}

final class LoadedTasksState extends TasksState {
  final List<TaskResEntity> listTask;

  const LoadedTasksState({required this.listTask});

  @override
  List<Object> get props => [listTask];
}

final class LoadedOneTaskState extends TasksState {
  final TaskResEntity task;

  const LoadedOneTaskState({required this.task});

  @override
  List<Object> get props => [task];
}

final class ErrorTasksState extends TasksState {
  final String message;

  const ErrorTasksState({required this.message});

  @override
  List<Object> get props => [message];
}
