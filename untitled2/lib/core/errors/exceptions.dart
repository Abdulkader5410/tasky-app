import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:untitled2/core/models/err_model.dart';

class ServerDioException implements Exception {
  ErrModel errModel;

  ServerDioException({required this.errModel});
  
}

void handleEx(DioException e) {
  switch (e.type) {
    case DioExceptionType.badCertificate:
      throw ServerDioException(
          errModel: ErrModel.fromJson(e.response!.data));

    case DioExceptionType.connectionTimeout:
      throw ServerDioException(
          errModel: ErrModel.fromJson(e.response!.data));

    case DioExceptionType.cancel:
      throw ServerDioException(
          errModel: ErrModel.fromJson(e.response!.data));

    case DioExceptionType.connectionError:
      throw ServerDioException(
          errModel: ErrModel.fromJson(e.response!.data));

    case DioExceptionType.receiveTimeout:
      throw ServerDioException(
          errModel: ErrModel.fromJson(e.response!.data));

    case DioExceptionType.sendTimeout:
      throw ServerDioException(
          errModel: ErrModel.fromJson(e.response!.data));

    case DioExceptionType.unknown:
      // throw ServerDioException(ErrModel: ErrModel.fromJson(e.response!.data));
      print("ERROR 1      ERROR 1     ERROR 1      ERROR 1");

    case DioExceptionType.badResponse:
      switch (e.response!.statusCode!) {
        case 400:
          // throw ServerDioException(
          //     ErrModel: ErrModel.fromJson(e.response!.data));
          print("ERROR 2     ERROR 2     ERROR 2       ERROR 2");

        case 401:
        log("RES ERR  ${e.response!.data}");
          throw ServerDioException(
              errModel: ErrModel.fromJson(e.response!.data));

        case 403:
          throw ServerDioException(
              errModel: ErrModel.fromJson(e.response!.data));

        case 404:
          throw ServerDioException(
              errModel: ErrModel.fromJson(e.response!.data));

        case 409:
          throw ServerDioException(
              errModel: ErrModel.fromJson(e.response!.data));

        case 422:
          throw ServerDioException(
              errModel: ErrModel.fromJson(e.response!.data));

        case 504:
          throw ServerDioException(
              errModel: ErrModel.fromJson(e.response!.data));
      }
  }
}
