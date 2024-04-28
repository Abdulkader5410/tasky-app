import 'package:ecommerce_app/cubit/user_cubit.dart';
import 'package:ecommerce_app/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.amber,
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(state);
          if (state is GetUserLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Text(state.userModel.fullName.firstName),
                // Text(state.userModel.fullName.lastName),
                Text(state.userModel.email),
                Text(state.userModel.password),
                Text(state.userModel.username),
                Text(state.userModel.address.city),
                Text(state.userModel.address.geo.lat),
                Text(state.userModel.address.geo.long),
              ],
            );
          } else if (state is GetUserLoading) {
            return const CircularProgressIndicator();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}