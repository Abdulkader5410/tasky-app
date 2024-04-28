import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_1/AddNotePage.dart';
import 'package:flutter_fire_1/HomePage.dart';
import 'package:flutter_fire_1/auth/Login.dart';
import 'package:flutter_fire_1/auth/SignupPage.dart';

const Color tealColor = Color.fromARGB(255, 0, 215, 165);
const Color prupleColor = Color.fromARGB(255, 92, 0, 50);
bool? isLogeed;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogeed = false;
  } else {
    isLogeed = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogeed! ? HomePage() : const Login(),
      theme: ThemeData(
        focusColor: const Color.fromARGB(255, 0, 222, 214),
        primaryColor: const Color.fromARGB(255, 0, 222, 214),
        disabledColor: const Color.fromARGB(255, 192, 192, 192),
      ),
      routes: {
        "register": (context) => const SignupPage(),
        "login": (context) => const Login(),
        "homePage": (context) => HomePage(),
        "addNotePage": (context) => AddNotePage()
      },
    );
  }
}
