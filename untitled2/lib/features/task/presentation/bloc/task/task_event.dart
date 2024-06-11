part of 'task_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetAllTasksEvent extends TasksEvent {
  

  const GetAllTasksEvent();
}

class RefershPageEvent extends TasksEvent {
  final String urlPath;

  const RefershPageEvent({required this.urlPath});
}

class GetOneTaskEvent extends TasksEvent {
  final String taskId;

  const GetOneTaskEvent({required this.taskId});
}
