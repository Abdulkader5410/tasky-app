import 'package:dartz/dartz.dart';
import 'package:untitled2/core/error/failure.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';
import 'package:untitled2/features/task/domain/task_domain_repo/task_dom_repo.dart';

class GetAllTasksUC {
   final TaskDomRepo taaskDomRepo;

  GetAllTasksUC({ required this.taaskDomRepo});

  Future<Either<Failure, List<TaskResEntity>>> call() async{
    return await taaskDomRepo.getAllTasks();
  }

}
