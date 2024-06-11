import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/strings/failure.dart';
import 'package:untitled2/core/strings/messages.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';
import 'package:untitled2/features/task/domain/usecase/add_task.dart';
import 'package:untitled2/features/task/domain/usecase/delete_task.dart';
import 'package:untitled2/features/task/domain/usecase/update_task.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddTaskUC addTask;
  final DeleteTaskUC deleteTask;
  final UpdateTasktUC updateTask;

  AddDeleteUpdateBloc(
      {required this.addTask,
      required this.deleteTask,
      required this.updateTask})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddTaskEvent) {
        emit(LoadingAddDeleteUpdateState());

        final messageOrFailure = await addTask(event.task);
        emit(_eitherMessageOrFailure(messageOrFailure, ADD_SUCCESSFUL_MESSAGE));
      } else if (event is UpdateTaskEvent) {
        emit(LoadingAddDeleteUpdateState());

        final messageOrFailure = await updateTask(event.task);
        emit(_eitherMessageOrFailure(
            messageOrFailure, UPDATE_SUCCESSFUL_MESSAGE));
      } else if (event is DeleteTaskEvent) {
        emit(LoadingAddDeleteUpdateState());

        final messageOrFailure = await deleteTask(event.taskId);

        emit(_eitherMessageOrFailure(
            messageOrFailure, DELETE_SUCCESSFUL_MESSAGE));
      }
    });
  }

  AddDeleteUpdateState _eitherMessageOrFailure(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateState(message: _mapFailureType(failure)),
      (tasks) => MessageAddDeleteUpdateState(message: message),
    );
  }

  String _mapFailureType(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return SERVER_FAILURE_MESSAGE;

      default:
        return "Unexpcted Error";
    }
  }
}
