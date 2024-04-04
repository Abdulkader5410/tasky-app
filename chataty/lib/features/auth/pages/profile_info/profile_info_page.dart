// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chataty/common/colors/coloors.dart';
import 'package:chataty/common/my themes/saved_last_theme.dart';
import 'package:chataty/common/my themes/theme_provider.dart';
import 'package:chataty/common/routes/routes.dart';
import 'package:chataty/common/widgets/alert_dialog.dart';
import 'package:chataty/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileInfoPage extends ConsumerStatefulWidget {
  const ProfileInfoPage({super.key, this.imageProfileUrl});

  final String? imageProfileUrl;

  @override
  ConsumerState<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends ConsumerState<ProfileInfoPage> {
  File? currImage;

  pickedImageFromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          currImage = File(pickedImage.path);
        });
      }
    } catch (ex) {
      alertDialog(
          context,
          ex.toString(),
          const Icon(
            Icons.warning,
            color: Coloors.yellow,
          ));
    }
  }

  pickedImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          currImage = File(pickedImage.path);
        });
      }
    } catch (ex) {
      alertDialog(
          context,
          ex.toString(),
          const Icon(
            Icons.warning,
            color: Coloors.yellow,
          ));
    }
  }

  late TextEditingController userNameController;

  saveUserInfoToFirestore() {
    String userName = userNameController.text;

    if (userName.isEmpty) {
      return alertDialog(
          context,
          "Please enter your UserName",
          const Icon(
            Icons.warning,
            color: Coloors.yellow,
          ));
    } else if (userName.length < 3 || userName.length > 25) {
      return alertDialog(
          context,
          "The length of UserName should be between 3 ~ 25 letters",
          const Icon(
            Icons.warning,
            color: Coloors.yellow,
          ));
    }

    ref.read(authControllerProvider).saveUserInfoToFirestore(
        userName: userName,
        profileImage: currImage ?? widget.imageProfileUrl,
        context: context,
        mounted: mounted);
  }

  @override
  void initState() {
    userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile information",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
              onPressed: () {
                
                    ref.read(myThemeProvider.notifier).toggleLight();
                    SavedLastTheme.savedTheme(1);
              },
              icon: const Icon(Icons.light_mode)),
          IconButton(
              onPressed: () {
              ref.read(myThemeProvider.notifier).toggleDark();
                    SavedLastTheme.savedTheme(0);
              },
              icon: const Icon(Icons.dark_mode))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            const Text("Please provide your name and an optional profile photo",
                textAlign: TextAlign.center),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: Coloors.dark,
                                  borderRadius: BorderRadius.circular(20)),
                              width: MediaQuery.sizeOf(context).width * 0.1,
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.02,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Chataty",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.06,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => pickedImageFromCamera(),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => pickedImageFromGallery(),
                                  child: const Icon(
                                    Icons.photo_library_outlined,
                                    size: 40,
                                  ),
                                )
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Camera",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: currImage != null || widget.imageProfileUrl != null
                    ? SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: MediaQuery.sizeOf(context).height * 0.22,
                        child: ClipOval(
                          child: currImage != null
                              ? Image.file(
                                  File(currImage!.path),
                                  fit: BoxFit.cover,
                                )
                              : Image.network(widget.imageProfileUrl!),
                        ),
                      )
                    : Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: MediaQuery.sizeOf(context).height * 0.22,
                        decoration: BoxDecoration(
                            color: Coloors.greyDark,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Coloors.light,
                          size: 50,
                        ),
                      )),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: TextFormField(
                controller: userNameController,
                cursorColor: Coloors.teal,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Coloors.teal)),
                    hintText: "Typing your name here"),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: ElevatedButton(
                        onPressed: () {
                          saveUserInfoToFirestore();
                        },
                        child: const Text("Save"))),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.homePage);
                        },
                        child: const Text("Skip"))),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
