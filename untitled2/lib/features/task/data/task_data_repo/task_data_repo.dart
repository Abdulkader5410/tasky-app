import 'package:dartz/dartz.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/core/exception/server_exception.dart';
import 'package:untitled2/core/network/network_info.dart';
import 'package:untitled2/features/task/data/data_source/task_local_data_source.dart';
import 'package:untitled2/features/task/data/data_source/task_remot_data_source.dart';
import 'package:untitled2/features/task/data/model/task_model.dart';
import 'package:untitled2/features/task/data/model/task_res_model.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';
import 'package:untitled2/features/task/domain/task_domain_repo/task_dom_repo.dart';

class TaskDataRepo extends TaskDomRepo {
  final TaskRemoteDataSource taskRemoteDataSource;
  // final TaskLocalDataSourceImpl taskLocalDataSource;
  final Networkinfo networkinfo;

  TaskDataRepo({
    required this.networkinfo,
    required this.taskRemoteDataSource,
    // required this.taskLocalDataSource
  });

  @override
  Future<Either<Failure, List<TaskResEntity>>> getAllTasks() async {
    if (await networkinfo.isConnected) {
      try {
        final remote_tasks = await taskRemoteDataSource.getAllTasks();
        // taskLocalDataSource.cacheTask(remote_tasks);
        return Right(remote_tasks);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addTask(TaskEntity taskEntity) async {
    final taskModel = TaskModel(
        desc: taskEntity.desc,
        date: taskEntity.date,
        image: taskEntity.image,
        proirity: taskEntity.proirity,
        title: taskEntity.title);

    if (await networkinfo.isConnected) {
      try {
        return _getMessage(() {
          return taskRemoteDataSource.addTask(taskModel);
        });
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(String taskId) async {
    if (await networkinfo.isConnected) {
      try {
        return _getMessage(() {
          return taskRemoteDataSource.deleteTask(taskId);
        });
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTask(TaskResEntity taskEntity) async {
    final taskModel = TaskResModel(
        id: taskEntity.id,
        desc: taskEntity.desc,
        status: 'wating',
        image: taskEntity.image,
        priority: taskEntity.priority,
        title: taskEntity.title);

    if (await networkinfo.isConnected) {
      try {
        return _getMessage(() {
          return taskRemoteDataSource.updateTask(taskModel);
        });
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() addOrdelOrupdatePost) async {
    if (await networkinfo.isConnected) {
      try {
        addOrdelOrupdatePost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, TaskResEntity>> getOneTask(String taskId) async {
    if (await networkinfo.isConnected) {
      try {
        final remote_task = await taskRemoteDataSource.getOneTasks(taskId);
        // taskLocalDataSource.cacheTask(remote_tasks);
        return Right(remote_task);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
