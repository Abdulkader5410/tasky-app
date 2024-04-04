import 'package:chataty/common/colors/coloors.dart';
import 'package:chataty/common/routes/routes.dart';
import 'package:flutter/material.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  navigteToLoginPage(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.loginPage, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/circle.png",
              width: 250, height: 250, color: Coloors.teal),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          const Text(
            "welcome to Chataty",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
          GestureDetector(
            onTap: () {
              showBottomSheetLang(context);
            },
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.45,
                child: GestureDetector(
                  onTap: () {
                    navigteToLoginPage(context);
                  },
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.language,
                          color: Coloors.teal,
                        ),
                        Text(
                          "English",
                          style: TextStyle(
                              color: Coloors.teal,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Coloors.teal,
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void showBottomSheetLang(BuildContext context) {
    var rad = false;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.8,
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
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.05,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.1,
                  ),
                  const Text(
                    "App Language",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Divider(
                thickness: 0.6,
                color: Coloors.dark,
              ),
              RadioListTile(
                activeColor: Coloors.teal,
                title: const Text("English", style: TextStyle(fontSize: 16)),
                value: rad,
                groupValue: false,
                onChanged: (value) {},
              )
            ],
          ),
        );
      },
    );
  }
}
