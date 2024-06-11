import 'package:flutter/material.dart';

class ErrorgWidget extends StatelessWidget {
  final message;

  const ErrorgWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: TextStyle(fontSize: 16)),
    );
  }
}
