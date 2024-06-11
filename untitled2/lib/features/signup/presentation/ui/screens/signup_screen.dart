import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/utilities/cuibt.dart';
import 'package:untitled2/features/signin/presentation/ui/screens/signin_screen.dart';
import 'package:untitled2/features/signup/presentation/bloc/signup/signup_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Pass passCuibt = Pass();

  GlobalKey<FormState> loginForm = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? level;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SuccessSignUpState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Registered Successfully")));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ));
            } else if (state is ErrorSignUpState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            print("STATE $state");
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 150,
                      child: Image.asset("assets/images/relax.jpg")),
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // const Text("First Name"),
                  SizedBox(
                      height: 55,
                      child: TextFormField(
                          cursorHeight: 25,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                          controller: nameController)),
                  const SizedBox(
                    height: 15,
                  ),
                  // const Text("Last Name"),
                  SizedBox(
                    height: 55,
                    child: TextFormField(
                      cursorHeight: 25,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                          hintText: "Phone",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          )),
                      controller: phoneController,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // const Text("Email"),
                  SizedBox(
                      height: 55,
                      child: TextFormField(
                          cursorHeight: 25,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                              hintText: "Year of experience",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                          controller: yearController)),
                  const SizedBox(
                    height: 15,
                  ),
                  // const Text("Username"),
                  SizedBox(
                    height: 60,
                    child: DropdownButtonFormField(
                      hint: const Text(
                        "Choose experience level",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "senior",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: 2,
                            child: Text(
                              "midLevel",
                              style: TextStyle(fontSize: 12),
                            )),
                        DropdownMenuItem(
                            value: 3,
                            child: Text(
                              "junior",
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                      onChanged: (value) {
                        if (value == 1) {
                          level = "senior";
                        } else if (value == 2) {
                          level = "midLevel";
                        } else if (value == 3) {
                          level = "junior";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // const Text("Password"),
                  SizedBox(
                      height: 55,
                      child: TextFormField(
                          cursorHeight: 25,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                              hintText: "Address",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                          controller: addressController)),
                  const SizedBox(
                    height: 15,
                  ),
                  // const Text("Gender"),
                  BlocBuilder<Pass, bool>(
                    bloc: passCuibt,
                    builder: (context, state) {
                      return SizedBox(
                        height: 55,
                        child: TextFormField(
                          obscureText: !state,
                          cursorHeight: 25,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  passCuibt.togglePass();
                                },
                                child: Icon(
                                  state
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                          controller: passController,
                        ),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)))),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.deepPurple)),
                          onPressed: () {
                            context.read<SignUpBloc>().add(SignUpUserEvent(
                                user: UserModel(
                                    address: addressController.text,
                                    displayName: nameController.text,
                                    experienceYears:
                                        int.parse(yearController.text),
                                    level: level,
                                    password: passController.text,
                                    phone: phoneController.text)));
                          },
                          child: BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, state) {
                              if (state is LoadingSignUpState) {
                                return const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                );
                              } else if (state is SuccessSignUpState) {}
                              return const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              );
                            },
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have any account ? ",
                        style: TextStyle(fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              decoration: TextDecoration.underline,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
