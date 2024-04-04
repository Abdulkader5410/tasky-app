import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/exception/server_exception.dart';
import 'package:posts_app/features/post/data/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getAllPostCached();
  Future<Unit> cachePost(List<PostModel> postModels);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sp;

  LocalDataSourceImpl({required this.sp});

  @override
  Future<Unit> cachePost(List<PostModel> postModels) {
    List listModelToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sp.setString("CACHED_POST", json.encode(listModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getAllPostCached() {
    final jsonData = sp.getString("CACHED_POST");
    if (jsonData != null) {
      List decodeJsonData = json.decode(jsonData);
      List<PostModel> listJsonToModel = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(listJsonToModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
