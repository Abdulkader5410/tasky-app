import 'package:flutter/material.dart';
import 'package:untitled2/features/start_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 3) , 
    () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartPage() )));

    return Container(
      color: Colors.deepPurple,
      child: Center(
        child: RichText(
            text: const TextSpan(style: TextStyle(fontSize: 35), children: [
          TextSpan(text: "Task", style: TextStyle(color: Colors.white)),
          TextSpan(text: "y", style: TextStyle(color: Colors.yellow)),
        ])),
      ),
    );
  }
}
