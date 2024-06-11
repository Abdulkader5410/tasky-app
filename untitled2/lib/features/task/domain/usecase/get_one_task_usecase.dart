import 'package:dartz/dartz.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';
import 'package:untitled2/features/task/domain/task_domain_repo/task_dom_repo.dart';

class GetOneTasksUC {
   final TaskDomRepo taaskDomRepo;

  GetOneTasksUC({ required this.taaskDomRepo});

  Future<Either<Failure, TaskResEntity>> call(String taskId) async{
    return await taaskDomRepo.getOneTask(taskId);
  }

}
