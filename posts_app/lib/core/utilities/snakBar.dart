// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:posts_app/core/app_theme/app_theme.dart';

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
