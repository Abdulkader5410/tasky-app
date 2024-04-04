import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/post/domain/post_domain_repo/post_dom_repo.dart';

class DeletePostUC {
  late final PostDomRepo postDomRepo;

  DeletePostUC(this.postDomRepo);

  Future<Either<Failure, Unit>> call(int id) async {
    return await postDomRepo.deletePost(id);
  }
}
