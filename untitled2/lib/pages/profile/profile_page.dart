import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/utilities/cuibt.dart';
import 'package:untitled2/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:untitled2/features/profile/presentation/ui/widgets/raw.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key,});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Pass passCuibt = Pass();

  GlobalKey<FormState> siginForm = GlobalKey();

  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    context.read<ProfileBloc>().add(const GetProfileUserEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is LoadedProfileState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Loaded Profile")));
            } else if (state is ErrorProfileState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            print("STATE $state");
            if (state is LoadedProfileState) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    RawWidget(
                      title: "Name",
                      content: state.user.displayName!,
                      isPhone: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RawWidget(
                      title: "Phone",
                      content: state.user.username!,
                      isPhone: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RawWidget(
                      title: "Level",
                      content: state.user.level!,
                      isPhone: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RawWidget(
                      title: "Year Experience",
                      content: "${state.user.experienceYears!}",
                      isPhone: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RawWidget(
                      title: "Location",
                      content: state.user.address!,
                      isPhone: false,
                    ),
                  ],
                ),
              );
            } else if (state is LoadingProfileState) {
              return const CircularProgressIndicator();
            } else if (state is ErrorProfileState) {
              return Text(state.message);
            } else {
              return Container(
                color: Colors.amber,
              );
            }
          },
        ),
      ),
    );
  }
}
