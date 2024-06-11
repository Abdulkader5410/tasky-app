
import 'package:dartz/dartz.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';
import 'package:untitled2/features/task/domain/task_domain_repo/task_dom_repo.dart';

class UpdateTasktUC {
  final TaskDomRepo taskDomRepo;

  UpdateTasktUC({required this.taskDomRepo});

  Future<Either<Failure, Unit>> call(TaskResEntity taskEntity) async {
    return await taskDomRepo.updateTask(taskEntity);
  }
}
