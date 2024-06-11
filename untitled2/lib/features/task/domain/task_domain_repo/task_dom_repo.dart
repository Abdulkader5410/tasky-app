import 'package:dartz/dartz.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';

abstract class TaskDomRepo {
  Future<Either<Failure, List<TaskResEntity>>> getAllTasks();
  Future<Either<Failure, TaskResEntity>> getOneTask(String taskId);
  Future<Either<Failure, Unit>> addTask(TaskEntity taskEntity);
  Future<Either<Failure, Unit>> updateTask(TaskResEntity taskEntity);
  Future<Either<Failure, Unit>> deleteTask(String id);
}
