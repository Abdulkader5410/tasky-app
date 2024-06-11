// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled2/core/api/dio_consumer.dart';
import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/errors/exceptions.dart';
import 'package:untitled2/core/exception/server_exception.dart';
import 'package:untitled2/features/task/data/model/task_model.dart';
import 'package:untitled2/features/task/data/model/task_res_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskResModel>> getAllTasks();
  Future<TaskResModel> getOneTasks(String taskId);
  Future<Unit> addTask(TaskModel taskModel);
  Future<Unit> updateTask(TaskResModel taskModel);
  Future<Unit> deleteTask(String taskId);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  DioConsumer dio;

  List<TaskResModel>? taskModels;
  TaskResModel? taskModel;
  TaskRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TaskResModel>> getAllTasks() async {
    try {
      final response =
          await dio.get(EndPoints.addTask, queryParms: {'page': 1});

      log("RES TASKS >>>>   $response");

      // List<dynamic> decodedJson =  jsonDecode(response) as List<dynamic>;

      // log("decodedJson    >>>>>> $decodedJson");

      taskModels = response
          .map<TaskResModel>((taskModel) => TaskResModel.fromjson(taskModel))
          .toList();

      return Future.value(taskModels);
    } on DioException catch (e) {
      handleEx(e);
      return Future.value(taskModels);
    }
  }

  @override
  Future<Unit> addTask(TaskModel taskModel) async {
    try {
      final body = {
        ApiKey.image: taskModel.image,
        ApiKey.title: taskModel.title,
        ApiKey.desc: taskModel.desc,
        ApiKey.priority: taskModel.proirity,
        ApiKey.dueDate: taskModel.date,
      };

      final response = await dio.post(EndPoints.addTask, data: body);

      return Future.value(unit);
    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteTask(String taskId) async {
    try {
      final response = await dio.delete("${EndPoints.addTask}/${taskId}");
      return Future.value(unit);
    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateTask(TaskResModel taskModel) async {
    try {
      final body = {
        '_id': taskModel.id,
        ApiKey.image: taskModel.image,
        ApiKey.title: taskModel.title,
        ApiKey.desc: taskModel.desc,
        ApiKey.priority: taskModel.priority,
        ApiKey.dueDate: taskModel.title,
        'user': taskModel.user,
        'status': taskModel.status,
      };

      final response =
          await dio.put(EndPoints.addTask + "/${taskModel.id}", data: body);

      return Future.value(unit);
    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<TaskResModel> getOneTasks(String taskId) async {
    try {
      final response = await dio.get(EndPoints.addTask + taskId);

      log("RES TASKS >>>>   $response");

      // List<dynamic> decodedJson =  jsonDecode(response) as List<dynamic>;

      // log("decodedJson    >>>>>> $decodedJson");

      taskModel = response
          .map<TaskResModel>((taskModel) => TaskResModel.fromjson(taskModel))
          .toList();

      return Future.value(taskModel);
    } on DioException catch (e) {
      handleEx(e);
      return Future.value(taskModel);
    }
  }
}
