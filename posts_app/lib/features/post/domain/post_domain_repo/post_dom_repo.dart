import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';

abstract class PostDomRepo {
  Future<Either<Failure, List<PostEntity>>> getAllPost();
  Future<Either<Failure, Unit>> addPost(PostEntity postEntity);
  Future<Either<Failure, Unit>> updatePost(PostEntity postEntity);
  Future<Either<Failure, Unit>> deletePost(int id);
}
