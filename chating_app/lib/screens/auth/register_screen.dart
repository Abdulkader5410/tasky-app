import 'package:chating_app/main.dart';
import 'package:chating_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool visibilPass = true;

  TextEditingController tfNameController = TextEditingController();
  TextEditingController tfEmailController = TextEditingController();
  TextEditingController tfPassController = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // UserCredential? credential;

  // signupUser(String currEmail, String currPassword) async {
  //   var formDate = fotmState.currentState;

  //   if (formDate!.validate()) {
  //     showLoading(context);
  //     try {
  //       credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: currEmail,
  //         password: currPassword,
  //       );
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'weak-password') {
  //         Navigator.of(context).pop();
  //         AwesomeDialog(
  //           context: context,
  //           title: "Error",
  //           body: const Center(
  //             heightFactor: 2,
  //             child: Text(
  //               "The password provided is too weak",
  //               style: TextStyle(
  //                   color: prupleColor,
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w300),
  //             ),
  //           ),
  //         ).show();
  //         print('The password provided is too weak.');
  //       } else if (e.code == 'email-already-in-use') {
  //         Navigator.of(context).pop();
  //         AwesomeDialog(
  //           context: context,
  //           title: "Error",
  //           body: const Center(
  //             heightFactor: 2,
  //             child: Text(
  //               "The account already exists for that email",
  //               style: TextStyle(
  //                   color: prupleColor,
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w300),
  //             ),
  //           ),
  //         ).show();
  //         print('The account already exists for that email.');
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //     await FirebaseFirestore.instance.collection("users").add({
  //       "fullname": tf_name_controller.text.toString(),
  //       "email": tf_email_controller.text.toString()
  //     });

  //     print("vaild");
  //     Navigator.of(context).pushReplacementNamed("homePage");
  //   } else {
  //     print("not vaild");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: light,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Transform.rotate(
                  angle: 180 * 3.141 / 180,
                  child: SvgPicture.asset(
                    "images/wave.svg",
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: formState,
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: const Offset(-15, -220),
                          child: Text(
                              textAlign: TextAlign.center,
                              "Wellcom you in ChatyApp",
                              style: TextStyle(
                                  color: light,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Transform.translate(
                          offset: const Offset(-90, -160),
                          child: Text(
                              textAlign: TextAlign.center,
                              "Sign Up",
                              style: TextStyle(
                                  color: light,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -60),
                          child: SizedBox(
                            height: 54,
                            child: TextFormField(
                                controller: tfNameController,
                                validator: (value) {
                                  if (value!.length > 100) {
                                    return "Full Name can't to be larger than 150 letter";
                                  }
                                  if (value.length < 2) {
                                    return "Full Name can't to be less than 2 letter";
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.bottom,
                                cursorColor: darkpurple,
                                style: TextStyle(
                                    color: darkpurple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: darkpurple)),
                                    prefixIcon:
                                        Icon(Icons.person, color: darkpurple),
                                    hintText: "Enter Full Name",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: darkpurple)))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Transform.translate(
                          offset: const Offset(0, -60),
                          child: SizedBox(
                            height: 54,
                            child: TextFormField(
                                controller: tfEmailController,
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
                                cursorColor: darkpurple,
                                style: TextStyle(
                                    color: darkpurple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: darkpurple)),
                                    prefixIcon:
                                        Icon(Icons.email, color: darkpurple),
                                    hintText: "Enter Email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: darkpurple)))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Transform.translate(
                          offset: const Offset(0, -60),
                          child: SizedBox(
                            height: 54,
                            child: TextFormField(
                                controller: tfPassController,
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
                                cursorColor: darkpurple,
                                style: TextStyle(
                                    color: darkpurple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: darkpurple)),
                                    prefixIcon:
                                        Icon(Icons.password, color: darkpurple),
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
                                          color: darkpurple,
                                        )),
                                    hintText: "Enter Password",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide:
                                            BorderSide(color: darkpurple)))),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Transform.translate(
                offset: const Offset(0, -40),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 50,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: darkpurple,
                    onPressed: () async {
                      // await signupUser(tf_email_controller.text.toString().trim(),
                      //     tf_pass_controller.text.toString());
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 18,
                          color: light,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Transform.translate(
                offset: const Offset(0, -50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have An Account ?",
                      style: TextStyle(
                          color: darkpurple,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 16,
                            color: darkpurple,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
