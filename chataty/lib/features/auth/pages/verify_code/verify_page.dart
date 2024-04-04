import 'package:chataty/common/colors/coloors.dart';
import 'package:chataty/common/my themes/saved_last_theme.dart';
import 'package:chataty/common/my themes/theme_provider.dart';
import 'package:chataty/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyPage extends ConsumerWidget {
  const VerifyPage({super.key, required this.phone, required this.smsCodeId});
  final String smsCodeId;
  final String phone;

  void verifySmsCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verify your phone number",
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
             Text(
              "You've tried to regiester  $phone  wait before requesting an SMS or Call with your code",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            const Text(
              "Edit your number ? ",
              style: TextStyle(
                  fontSize: 14,
                  color: Coloors.blue,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: TextFormField(
                
                onChanged: (value) {
                  if (value.length == 6) {
                    return verifySmsCode(context, ref, value);
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                cursorColor: Coloors.teal,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w300 , letterSpacing: 10),
                decoration: const InputDecoration(
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Coloors.greyDark)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Coloors.teal)),
                  hintText: "_ _ _ _ _ _",
                  
                ),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
            const Text(
              "Enter 6 digits code",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.07),
            ListTile(
                onTap: () {},
                title: const Text(
                  "Resend SMS",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
                leading: const Icon(
                  Icons.message,
                  color: Coloors.teal,
                )),
            ListTile(
                onTap: () {},
                title: const Text(
                  "Call Me",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
                leading: const Icon(
                  Icons.phone,
                  color: Coloors.teal,
                )),
          ]),
        ),
      ),
    );
  }
}
