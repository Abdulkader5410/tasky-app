import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/errors/error_model.dart';

class ServerException implements Exception {
  ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handleEx(DioException e) {
  switch (e.type) {
    case DioExceptionType.badCertificate:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.connectionTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.cancel:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.connectionError:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.receiveTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.sendTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.unknown:
      // throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      print("ERROR 1      ERROR 1     ERROR 1      ERROR 1");

    case DioExceptionType.badResponse:
      switch (e.response!.statusCode!) {
        case 400:
          // throw ServerException(
          //     errorModel: ErrorModel.fromJson(e.response!.data));
          print("ERROR 2     ERROR 2     ERROR 2       ERROR 2");

        case 401:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 403:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 404:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 409:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 422:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 504:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}
