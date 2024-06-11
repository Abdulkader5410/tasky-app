// ignore_for_file: non_constant_identifier_names

import 'package:ecommerce_app/core1/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

class ShowSnakBar {
  void MessageSnakBar({required BuildContext context, required message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
      color: Colors.greenAccent,
      child: Text(
        message,
        style: styleSubtites,
      ),
    )));
  }

  void ErrorSnakBar({required BuildContext context, required message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
      color: Colors.redAccent,
      child: Text(
        message,
        style: styleSubtites,
      ),
    )));
  }
}
