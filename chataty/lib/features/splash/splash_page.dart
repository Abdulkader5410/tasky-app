// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:chataty/features/welcome/welcome.dart';
import 'package:flutter/material.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const WelcomPage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/splash_light.png",
            width: 230, height: 230),
      ),
    );
  }
}
