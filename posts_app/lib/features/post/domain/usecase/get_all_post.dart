import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';
import 'package:posts_app/features/post/domain/post_domain_repo/post_dom_repo.dart';

class GetAllPsotsUC {
  late final PostDomRepo postDomRepo;

  GetAllPsotsUC(this.postDomRepo);

  Future<Either<Failure, List<PostEntity>>> call() async{
    return await postDomRepo.getAllPost();
  }

}
