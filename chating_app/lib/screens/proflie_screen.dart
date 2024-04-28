// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chating_app/apis/apis.dart';
import 'package:chating_app/main.dart';
import 'package:chating_app/models/user.dart';
import 'package:chating_app/screens/auth/login_screen.dart';
import 'package:chating_app/widgets/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? image;

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: darkpurple, statusBarColor: darkpurple));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    onPressed: () async {
                      Dialogs.showProgressBar(context);
                      await APIs.updateActiveStatus(false);
                      await APIs.auth.signOut().then((value) async {
                        await GoogleSignIn().signOut();
                        Navigator.pop(context);
                        APIs.auth = FirebaseAuth.instance;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      });
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      size: 30,
                    ),
                  ))
            ],
            elevation: 1,
            backgroundColor: darkpurple,
            centerTitle: true,
            title: const Text("My Profile")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: mediaQuery.height * 0.01,
                  width: mediaQuery.height * 0.55,
                ),
                image != null
                    ? ClipOval(
                        child: Image.file(
                          File(image!),
                          width: mediaQuery.height * 0.2,
                          height: mediaQuery.height * 0.2,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: CachedNetworkImage(
                          width: mediaQuery.height * 0.2,
                          height: mediaQuery.height * 0.2,
                          fit: BoxFit.cover,
                          imageUrl: widget.user.image,
                          errorWidget: (context, url, error) {
                            return CircleAvatar(
                                backgroundColor: darkpurple,
                                child: Icon(
                                  color: white,
                                  Icons.person_outlined,
                                  size: 30,
                                ));
                          },
                        ),
                      ),
                Transform.translate(
                  offset: Offset(
                      mediaQuery.width * 0.13, mediaQuery.height * -0.08),
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    color: light,
                    onPressed: () {
                      _showCustomBottomSheet();
                    },
                    child: Icon(Icons.edit, color: darkpurple, size: 25),
                  ),
                ),
                Transform.translate(
                  offset:
                      Offset(mediaQuery.height * 0, mediaQuery.width * -0.06),
                  child: Text(
                    widget.user.email,
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.04,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: mediaQuery.height * 0.08,
                        child: TextFormField(
                            onSaved: (newValue) =>
                                APIs.me.name = newValue ?? '',
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : "Required Field",
                            initialValue: widget.user.name,
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.bottom,
                            cursorColor: darkpurple,
                            style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: darkpurple)),
                                prefixIcon: Icon(CupertinoIcons.person,
                                    color: darkpurple),
                                label: const Text("Name"),
                                hintText: "eg. Abdulkader Alabdo",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide:
                                        BorderSide(color: darkpurple)))),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.04,
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.08,
                        child: TextFormField(
                            onSaved: (newValue) =>
                                APIs.me.about = newValue ?? '',
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : "Required Field",
                            initialValue: widget.user.about,
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.bottom,
                            cursorColor: darkpurple,
                            style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: darkpurple)),
                                prefixIcon: Icon(CupertinoIcons.info_circle,
                                    color: darkpurple),
                                label: const Text("About"),
                                hintText: "eg. Flutter Developer",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide:
                                        BorderSide(color: darkpurple)))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.1,
                ),
                SizedBox(
                  width: mediaQuery.width * 0.9,
                  height: mediaQuery.height * 0.08,
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: darkpurple,
                      onPressed: () {
                        formKey.currentState!.save();
                        APIs.updateInfoUser().then((value) {
                          Dialogs.showSnakBarSuccess(
                              context, "Updated Successfully");
                        });
                      },
                      child: Text(
                        "Edit Info",
                        style: TextStyle(color: white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      context: context,
      builder: (_) {
        return ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            const Text(
              textAlign: TextAlign.center,
              "Choose the profile image",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  onTap: () async {
                    final ImagePicker imagePicker = ImagePicker();

                    final XFile? pickedImage = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {
                        image = pickedImage.path;
                      });
                      APIs.updateImageUser(File(image!));
                      Navigator.pop(context);
                    } else {
                      Dialogs.showSnakBar(
                          context, "Not picture has been chosen !");
                      Navigator.pop(context);
                    }
                  },
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => LinearGradient(
                        tileMode: TileMode.mirror,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, green]).createShader(bounds),
                    child: const Icon(
                      CupertinoIcons.photo_on_rectangle,
                      size: 60,
                    ),
                  )),
              SizedBox(
                width: mediaQuery.width * 0.2,
              ),
              InkWell(
                  onTap: () async {
                    final ImagePicker imagePicker = ImagePicker();

                    final XFile? pickedImage =
                        await imagePicker.pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      setState(() {
                        image = pickedImage.path;
                      });
                      APIs.updateImageUser(File(image!));
                      Navigator.pop(context);
                    } else {
                      Dialogs.showSnakBar(
                          context, "Not picture has been chosen !");
                    }
                  },
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => LinearGradient(
                        tileMode: TileMode.mirror,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [orang, darkpurple]).createShader(bounds),
                    child: const Icon(
                      CupertinoIcons.camera,
                      size: 60,
                    ),
                  ))
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Gallery"),
              SizedBox(
                width: mediaQuery.width * 0.2,
              ),
              const Text("Camera"),
            ]),
          ],
        );
      },
    );
  }
}
