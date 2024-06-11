// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled2/core/exception/server_exception.dart';
// import 'package:untitled2/features/task/data/model/task_model.dart';

// abstract class TaskLocalDataSource {
//   Future<List<TaskModel>> getAllTaskCached();
//   Future<Unit> cacheTask(List<TaskModel> taskModels);
// }

// class TaskLocalDataSourceImpl implements TaskLocalDataSource {

//   final SharedPreferences sp;

//   TaskLocalDataSourceImpl({required this.sp});

//   @override
//   Future<Unit> cacheTask(List<TaskModel> taskModels) {
//     List listModelToJson = taskModels
//         .map<Map<String, dynamic>>((taskModel) => taskModel.toJson())
//         .toList();
//     sp.setString("CACHED_TASK", json.encode(listModelToJson));
//     return Future.value(unit);
//   }

//   @override
//   Future<List<TaskModel>> getAllTaskCached() {
//     final jsonData = sp.getString("CACHED_TASK");
//     if (jsonData != null) {
//       List decodeJsonData = json.decode(jsonData);
//       List<TaskModel> listJsonToModel = decodeJsonData
//           .map<TaskModel>((jsonPostModel) => TaskModel.fromJson(jsonPostModel))
//           .toList();
//       return Future.value(listJsonToModel);
//     } else {
//       throw EmptyCacheException();
//     }
//   }
// }
