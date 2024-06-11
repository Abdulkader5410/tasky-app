import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/utilities/cuibt.dart';
import 'package:untitled2/cubit/signin_cubit/signin_cubit.dart';
import 'package:untitled2/features/signup/presentation/ui/screens/signup_screen.dart';
import 'package:untitled2/features/task/presentation/ui/task_screen.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  Pass passCuibt = Pass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state is SigninSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Loggoed Successfully")));

              Future.delayed(
                Duration(seconds: 1),
                () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaskPage()));
                },
              );
            } else if (state is SigninFailure) {
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
                          controller:
                              context.read<SigninCubit>().phoneController)),
                  const SizedBox(
                    height: 15,
                  ),

                  // password field
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
                              context.read<SigninCubit>().passController,
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
                            // context.read<SignInBloc>().add(SignInUserEvent(
                            //     user: UserModel(
                            //         password: passController.text,
                            //         phone: phoneController.text),
                            //     context: context));

                            context.read<SigninCubit>().signin();
                          },
                          child: BlocBuilder<SigninCubit, SigninState>(
                            builder: (context, state) {
                              if (state is SigninLoading) {
                                return const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                );
                              } else {
                                return const Text(
                                  "Sign In",
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
