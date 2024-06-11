import 'package:dartz/dartz.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/features/task/domain/task_domain_repo/task_dom_repo.dart';

class DeleteTaskUC {
   final TaskDomRepo taskDomRepo;

  DeleteTaskUC({required this.taskDomRepo});

  Future<Either<Failure, Unit>> call(String id) async {
    return await taskDomRepo.deleteTask(id);
  }
}
