// import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled2/core/exception/server_exception.dart';

// abstract class SignUpLocalDataSource {
//   int getUserId();
//   String getUserAccessToken();
//   Future<Unit> cacheUserId(int userId);
//   Future<Unit> cacheUserAccessToken(String accessTtoken);
// }

// class SignUpLocalDataSourceImpl implements SignUpLocalDataSource {
//   final SharedPreferences sp;

//   SignUpLocalDataSourceImpl({required this.sp});

//   @override
//   Future<Unit> cacheUserId(int userId) {
//     sp.setInt("CACHED_USER_ID", userId);
//     return Future.value(unit);
//   }

//   @override
//   Future<Unit> cacheUserAccessToken(String accessTtoken) {
//     sp.setString("CACHED_USER_ACCESS_TOKEN", accessTtoken);
//     return Future.value(unit);
//   }

//   @override
//   int getUserId() {
//     final userId = sp.getInt("CACHED_USER_ID");
//     if (userId != null) {
//       return userId;
//     } else {
//       throw EmptyCacheException();
//     }
//   }

//   @override
//   String getUserAccessToken() {
//     final userToken = sp.getString("CACHED_USER_ACCESS_TOKEN");
//     if (userToken != null) {
//       return userToken;
//     } else {
//       throw EmptyCacheException();
//     }
//   }
// }
