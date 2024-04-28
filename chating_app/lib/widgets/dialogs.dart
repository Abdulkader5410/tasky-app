import 'package:chating_app/main.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showSnakBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        behavior: SnackBarBehavior.floating,
        content: Text(msg)));
  }

  static void showSnakBarSuccess(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin:
            const EdgeInsets.only(bottom: 200, top: 200, left: 20, right: 20),
        padding:
            const EdgeInsets.only(bottom: 50, top: 50, left: 20, right: 20),
        backgroundColor: green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        behavior: SnackBarBehavior.floating,
        content: Center(
            child: ListTile(
          title: Text(
            msg,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: white),
          ),
          trailing: Icon(Icons.check, color: white, size: 40),
        ))));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
  }
}
