import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/utilities/cuibt.dart';
import 'package:untitled2/features/profile/presentation/ui/screens/profile_screen.dart';
import 'package:untitled2/features/signin/presentation/bloc/signin/signin_bloc.dart';
import 'package:untitled2/features/signup/presentation/ui/screens/signup_screen.dart';
import 'package:untitled2/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:untitled2/features/task/presentation/ui/add_or_update_screen.dart';
import 'package:untitled2/features/task/presentation/ui/task_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Pass passCuibt = Pass();

  GlobalKey<FormState> siginForm = GlobalKey();

  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SuccessSignInState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Loggoed Successfully")));

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const TaskPage()));
            } else if (state is ErrorSignInState) {
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
                  const SizedBox(height: 20),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 150,
                      child: Image.asset("assets/images/relax.jpg")),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

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
                          controller: phoneController)),
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
                            context.read<SignInBloc>().add(SignInUserEvent(
                                user: UserModel(
                                    password: passController.text,
                                    phone: phoneController.text),
                                context: context));
                          },
                          child: BlocBuilder<SignInBloc, SignInState>(
                            builder: (context, state) {
                              if (state is LoadingSignInState) {
                                return const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                );
                              } else if (state is SuccessSignInState) {}
                              return const Text(
                                "Sign In",
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
                      const Text(
                        "You have not any account ? ",
                        style: TextStyle(fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                        child: const Text(
                          "Sign Up",
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
      ]),
    );
  }
}
