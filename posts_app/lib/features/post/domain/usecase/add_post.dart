import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';
import 'package:posts_app/features/post/domain/post_domain_repo/post_dom_repo.dart';

class AddPostUC {
  late final PostDomRepo postDomRepo;

  AddPostUC(this.postDomRepo);

  Future<Either<Failure, Unit>> call(PostEntity postEntity) async {
    return await postDomRepo.addPost(postEntity);
  }
}
