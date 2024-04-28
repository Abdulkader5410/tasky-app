import 'package:chating_app/screens/home_screen.dart';
import 'package:chating_app/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late Size mediaQuery;

Color darkRed = const Color(0xff8a031e);
Color darkpurple = const Color(0xff7f0f40);
Color orang = const Color(0xfffbbb24);
Color light = const Color(0xfff5efef);
Color black = const Color(0xff000000);
Color white = const Color(0xffffffff);
Color green = const Color(0xff33cc33);
Color gray = const Color(0xff555555);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: darkpurple, statusBarColor: darkpurple));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then(
    (_) {
      runApp(const MyApp());
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chaty',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.light(primary: darkpurple)),
        home: checkUser());
  }
}

Widget checkUser() {
  if (FirebaseAuth.instance.currentUser != null) {
    return const HomeScreen();
  } else {
    return const SplashScreen();
  }
}
