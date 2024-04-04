import 'package:flutter/material.dart';
import 'package:posts_app/core/app_theme/app_theme.dart';
import 'package:posts_app/features/post/presentation/ui/post_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: const PostPage(),
    );
  }
}
