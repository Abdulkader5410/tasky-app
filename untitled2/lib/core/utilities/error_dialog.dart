import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void showErrorDialog(DioException ex, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(ex.message!),
      );
    },
  );
}
