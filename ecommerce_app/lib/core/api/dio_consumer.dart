

import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/api_interceptor.dart';
import 'package:ecommerce_app/core/api/endpoints.dart';
import 'package:ecommerce_app/core/errors/exceptions.dart';


class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParms,
  }) async {
    try {
      final res = await dio.get(path, data: data, queryParameters: queryParms);
      return res.data;
    } on DioException catch (e) {
      handleEx(e);
    }
  }

  @override
  Future delete(String path,
      {dynamic data,
      Map<String, dynamic>? queryParms,
      bool isFormData = false}) async {
    try {
      final res = await dio.delete(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParms);
      return res.data;
    } on DioException catch (e) {
      handleEx(e);
    }
  }

  @override
  Future patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParms,
      bool isFormData = false}) async {
    try {
      final res = await dio.patch(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParms);
      return res.data;
    } on DioException catch (e) {
      handleEx(e);
    }
  }

  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParms,
      bool isFormData = false}) async {
    try {
      final res = await dio.post(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParms);
      return res.data;
    } on DioException catch (e) {
      handleEx(e);
    }
  }
}
