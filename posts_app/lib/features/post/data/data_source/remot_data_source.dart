// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:posts_app/core/exception/server_exception.dart';
import 'package:posts_app/features/post/data/model/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPost();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int postId);
}

const BASE_URL = "sdf";

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPost() async {
    final response = await client.get(Uri.parse(BASE_URL), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body) as List;
      List<PostModel> postModels = decodedJson
          .map<PostModel>((postModel) => PostModel.fromJson(postModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};

    final response = await client.post(
        Uri.parse(
          BASE_URL,
        ),
        body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client
        .delete(Uri.parse(BASE_URL + "/posts/${postId.toString()}"), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response =
        await client.patch(Uri.parse(BASE_URL + "/posts/$postId"), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
