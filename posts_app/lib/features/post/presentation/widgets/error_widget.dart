import 'package:flutter/material.dart';
import 'package:posts_app/core/app_theme/app_theme.dart';

class ErrorgWidget extends StatelessWidget {
  final message;

  const ErrorgWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: styleSubtites),
    );
  }
}
