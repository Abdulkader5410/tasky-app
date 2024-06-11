import 'package:flutter/material.dart';
import 'package:untitled2/pages/signin/signin_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset(
                "assets/images/relax.jpg",
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                textAlign: TextAlign.center,
                "Task Management  &  To-Do List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const Text(
              textAlign: TextAlign.center,
              "This Productive tool is designed to help toy better manage your task project-wise conveniently!",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurple)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SigninPage()));
                    },
                    child: Text(
                      "Let's Start   ${String.fromCharCode(0x21a0)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
