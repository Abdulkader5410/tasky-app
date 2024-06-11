import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/api/endpoints.dart';
import 'package:untitled2/core/cache/cache.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // options.headers[ApiKey.accessToken] =

    //     CacheHelper().getData(key: ApiKey.accessToken) != null
    //         ? "Bearer Token ${CacheHelper().getData(key: ApiKey.accessToken)}"
    //         : null;

    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = await sp.getString("access_token");
    
    options.headers["Authorization"] = token != null ? "Bearer ${token}" : null;

    super.onRequest(options, handler);
  }
}
