import 'package:chataty/common/colors/coloors.dart';
import 'package:flutter/material.dart';

Future<dynamic> alertDialog(BuildContext context, String message , Icon icon) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: icon,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Ok",
                style: TextStyle(color: Coloors.teal),
              ))
        ],
        content: Text(message),
      );
    },
  );
}