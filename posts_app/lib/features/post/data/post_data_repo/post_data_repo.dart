import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/core/exception/server_exception.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/post/data/data_source/local_data_source.dart';
import 'package:posts_app/features/post/data/data_source/remot_data_source.dart';
import 'package:posts_app/features/post/data/model/post_model.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';
import 'package:posts_app/features/post/domain/post_domain_repo/post_dom_repo.dart';

class PostDataRepo extends PostDomRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final Networkinfo networkinfo;

  PostDataRepo(
      {required this.networkinfo,required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPost() async {
    if (await networkinfo.isConnected) {
      try {
        final remote_posts = await remoteDataSource.getAllPost();
        localDataSource.cachePost(remote_posts);
        return Right(remote_posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final local_posts = await localDataSource.getAllPostCached();
        return Right(local_posts);
      } on EmptyCacheException {
        return Left(EmptyFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity postEntity) async {
    final postModel = PostModel(
         title: postEntity.title, body: postEntity.body);

    if (await networkinfo.isConnected) {
      try {
        return _getMessage(() {
          return remoteDataSource.addPost(postModel);
        });
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    if (await networkinfo.isConnected) {
      try {
        return _getMessage(() {
          return remoteDataSource.deletePost(postId);
        });
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity postEntity) async {
    final postModel = PostModel(
        id: postEntity.id, title: postEntity.title, body: postEntity.body);

    if (await networkinfo.isConnected) {
      try {
        return _getMessage(() {
          return remoteDataSource.updatePost(postModel);
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
}
