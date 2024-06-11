import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/strings/failure.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';
import 'package:untitled2/features/task/domain/usecase/get_all_tasks.dart';
import 'package:untitled2/features/task/domain/usecase/get_one_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TasksEvent, TasksState> {
  final GetAllTasksUC getAllTasks;
  final GetOneTasksUC getOneTask;

  TaskBloc( {required this.getAllTasks ,required this.getOneTask, }) : super(TasksInitial()) {
    on<TasksEvent>((event, emit) async {
      if (event is GetAllTasksEvent) {
        emit(LoadingTasksState());

        final tasksOrFailure = await getAllTasks();

        tasksOrFailure.fold(
          (failure) {
            emit(ErrorTasksState(message: _mapFailureType(failure)));
          },
          (tasks) {
            emit(LoadedTasksState(listTask: tasks));
          },
        );
      }else if(event is GetOneTaskEvent){
        emit(LoadingTasksState());

        final taskOrFailure = await getOneTask(event.taskId);

        taskOrFailure.fold(
          (failure) {
            emit(ErrorTasksState(message: _mapFailureType(failure)));
          },
          (task) {
            emit(LoadedOneTaskState(task: task));
          },
        );
      } 
      
      
      else if (event is RefershPageEvent) {
        emit(LoadingTasksState());

        final postsOrFailure = await getAllTasks();

        postsOrFailure.fold(
          (failure) {
            emit(ErrorTasksState(message: _mapFailureType(failure)));
          },
          (tasks) {
            emit(LoadedTasksState(listTask: tasks));
          },
        );
      }
    });
  }

  String _mapFailureType(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case EmptyFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return SERVER_FAILURE_MESSAGE;

      default:
        return "Unexpcted Error";
    }
  }
}
