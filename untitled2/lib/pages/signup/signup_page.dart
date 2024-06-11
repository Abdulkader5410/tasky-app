import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/utilities/cuibt.dart';
import 'package:untitled2/cubit/signup_cubit/signup_cubit.dart';
import 'package:untitled2/cubit/signup_cubit/signup_state.dart';
import 'package:untitled2/features/signin/presentation/ui/screens/signin_screen.dart';
import 'package:untitled2/features/signup/presentation/bloc/signup/signup_bloc.dart';
import 'package:untitled2/pages/signin/signin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Registered Successfully")));
              Future.delayed(
                const Duration(seconds: 1),
                () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SigninPage(),
                      ));
                },
              );
            } else if (state is SignupFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errMsg)));
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
                          controller:
                              context.read<SignupCubit>().nameController)),
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
                        controller:
                            context.read<SignupCubit>().phoneController),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // const Text("Email"),
                  SizedBox(
                      height: 55,
                      child: TextFormField(
                          cursorHeight: 25,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                              hintText: "Year of experience",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                          controller:
                              context.read<SignupCubit>().yearController)),
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
                          controller:
                              context.read<SignupCubit>().addressController)),
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
                          controller:
                              context.read<SignupCubit>().passController,
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
                            // context.read<SignUpBloc>().add(SignUpUserEvent(
                            //     user: UserModel(
                            //         address: addressController.text,
                            //         displayName: nameController.text,
                            //         experienceYears:
                            //             int.parse(yearController.text),
                            //         level: level,
                            //         password: passController.text,
                            //         phone: phoneController.text)));

                            context.read<SignupCubit>().signup(level!);
                          },
                          child: BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              if (state is LoadingSignUpState) {
                                return const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                );
                              } else {
                                return const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                );
                              }
                            },
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have any account ? ",
                        style: TextStyle(fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SigninPage(),
                              ));
                        },
                        child: const Text(
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
