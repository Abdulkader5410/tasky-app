import 'package:dartz/dartz.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/task_domain_repo/task_dom_repo.dart';

class AddTaskUC {
  final TaskDomRepo taskDomRepo;

  AddTaskUC({required this.taskDomRepo});

  Future<Either<Failure, Unit>> call(TaskEntity taskEntity) async {
    return await taskDomRepo.addTask(taskEntity);
  }
}
