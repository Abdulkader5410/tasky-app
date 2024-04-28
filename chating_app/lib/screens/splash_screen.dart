// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:chating_app/apis/apis.dart';
import 'package:chating_app/main.dart';
import 'package:chating_app/screens/auth/login_screen.dart';
import 'package:chating_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 5),
      () async {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: darkpurple, statusBarColor: darkpurple));

        if (APIs.auth.currentUser != null) {
          await APIs.auth.currentUser!.reload();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: light,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 200),
              child: Center(
                child: Image.asset("images/logo.png", width: 150, height: 150),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Text("ChatyApp",
                  style: TextStyle(
                      color: darkpurple,
                      fontSize: 24,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ));
  }
}
