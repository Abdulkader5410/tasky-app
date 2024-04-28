import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_1/component/alert.dart';
import 'package:flutter_fire_1/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visibilPass = true;

  TextEditingController tf_email_controller = TextEditingController();
  TextEditingController tf_pass_controller = TextEditingController();

  GlobalKey<FormState> fotmState = GlobalKey<FormState>();
  UserCredential? credential;


  signinUser(String currEmail, String currPass) async {
    var formDate = fotmState.currentState;
    if (formDate!.validate()) {
      showLoading(context);

      try {
        credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: currEmail, password: currPass);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();

          AwesomeDialog(
            context: context,
            title: "Error",
            body: const Center(
              heightFactor: 2,
              child: Text(
                "No user found for that email",
                style: TextStyle(
                    color: prupleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ).show();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: const Center(
              heightFactor: 2,
              child: Text(
                "Wrong password provided for that user",
                style: TextStyle(
                    color: prupleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ).show();
          print('Wrong password provided for that user.');
        }
      }
      print(" vaild");
      
      Navigator.of(context).pushReplacementNamed("homePage");

    } else {
      print("not vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
                color: tealColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(180),
                    bottomLeft: Radius.circular(180))),
            child: const Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                    textAlign: TextAlign.left,
                    "Note App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 70,
                ),
                Text(
                    textAlign: TextAlign.center,
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: fotmState,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 54,
                      child: TextFormField(
                          controller: tf_email_controller,
                          validator: (value) {
                            if (value!.length > 100) {
                              return "Email can't to be larger than 150 letter";
                            }
                            if (value.length < 2) {
                              return "Email can't to be less than 2 letter";
                            }
                            return null;
                          },
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.bottom,
                          cursorColor: prupleColor,
                          style: const TextStyle(
                              color: prupleColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide:
                                      const BorderSide(color: prupleColor)),
                              prefixIcon:
                                  const Icon(Icons.email, color: prupleColor),
                              hintText: "Enter Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 54,
                      child: TextFormField(
                          controller: tf_pass_controller,
                          validator: (value) {
                            if (value!.length > 100) {
                              return "Password can't to be larger than 150 letter";
                            }
                            if (value.length < 2) {
                              return "Password can't to be less than 4 letter";
                            }
                            return null;
                          },
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: visibilPass,
                          cursorColor: prupleColor,
                          style: const TextStyle(
                              color: prupleColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide:
                                      const BorderSide(color: prupleColor)),
                              prefixIcon: const Icon(Icons.password,
                                  color: prupleColor),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      visibilPass = !visibilPass;
                                    });
                                  },
                                  icon: Icon(
                                    visibilPass == true
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: prupleColor,
                                  )),
                              hintText: "Enter Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60)))),
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              color: tealColor,
              onPressed: () async {
                await signinUser(tf_email_controller.text.toString().trim(),
                    tf_pass_controller.text.toString());
                // ignore: use_build_context_synchronously
              },
              child: const Text(
                "Login",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                " You have not an Account ?",
                style: TextStyle(
                    color: prupleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("register");
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(
                      fontSize: 18,
                      color: tealColor,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
