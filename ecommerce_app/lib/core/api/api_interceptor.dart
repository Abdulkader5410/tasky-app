import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-language'] = "en";
    options.headers['content-type'] = "application/json";

    super.onRequest(options, handler);
  }
}
