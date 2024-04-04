import 'package:flutter/material.dart';

Future<dynamic> loadingDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            const CircularProgressIndicator(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            Text(
              textAlign: TextAlign.center,
              maxLines: 10,
              message,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          ],
        ),
      );
    },
  );
}
