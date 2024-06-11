// import 'package:shared_preferences/shared_preferences.dart';

// class CacheHelper {
//   late SharedPreferences sp;

//   init() async {
//     sp = await SharedPreferences.getInstance();
//   }

//   String? getDataString({required String key}) {
//     return sp.getString(key);
//   }

//   Future<bool> saveData({required String key, required dynamic value}) async {
//     if (value is bool) {
//       return await sp.setBool(key, value);
//     } else if (value is String) {
//       return await sp.setString(key, value);
//     } else if (value is int) {
//       return await sp.setInt(key, value);
//     } else {
//       return await sp.setDouble(key, value);
//     }
//   }

//   Future<bool> put({required String key, required dynamic value}) async {
//     if (value is bool) {
//       return await sp.setBool(key, value);
//     } else if (value is String) {
//       return await sp.setString(key, value);
//     } else if (value is int) {
//       return await sp.setInt(key, value);
//     } else {
//       return await sp.setDouble(key, value);
//     }
//   }

//   dynamic getData({required String key}) {
//     return sp.get(key);
//   }

//   Future<bool> removeData({
//     required String key,
//   }) async {
//     return await sp.remove(key);
//   }

//    Future<bool> clearData() async {
//     return await sp.clear();
//   }

//   Future<bool> ContainesKey({required String key}) async {
//     return sp.containsKey(key);
//   }
// }
