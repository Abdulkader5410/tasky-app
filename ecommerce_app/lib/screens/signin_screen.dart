import 'package:ecommerce_app/cubit/user_cubit.dart';
import 'package:ecommerce_app/cubit/user_state.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SigninStateSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Success")));
          } else if (state is SigninStateFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        builder: (context, state) {
          print("STATE $state");
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 250,
                      child: Image.asset("assets/images/test_image.png")),
                  const Text(
                    "SignIn",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  const Text("Email"),
                  TextFormField(
                    controller: context.read<UserCubit>().emailControllerSignin,
                  ),
                  const SizedBox(height: 10),
                  const Text("Password"),
                  TextFormField(
                    controller: context.read<UserCubit>().passControllerSignin,
                  ),
                  const SizedBox(height: 10),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password",
                      )),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 1.5,
                      child: MaterialButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          // context.read<UserCubit>().signIn();
                          context.read<UserCubit>().getUserProfile();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ));
                        },
                        child: state is SigninStateLoading
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                              )
                            : const Text("Sign in"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ? "),
                      Text("Sign Up"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
