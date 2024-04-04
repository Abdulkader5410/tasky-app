import 'package:chataty/common/colors/coloors.dart';
import 'package:chataty/common/my themes/theme_provider.dart';
import 'package:chataty/common/widgets/alert_dialog.dart';
import 'package:chataty/common/widgets/loading_dialog.dart';
import 'package:chataty/features/auth/controller/auth_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  
  TextEditingController countryNameController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Enter your phone number",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
              onPressed: () {
                loadingDialog(context, "Changing theme ");
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    ref.watch(myThemeProvider.notifier).toggleLight();
                  },
                );
              },
              icon: const Icon(Icons.light_mode)),
          IconButton(
              onPressed: () {  loadingDialog(context, "Changing theme ");
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                ref.read(myThemeProvider.notifier).toggleDark();
                  },
                );
              },
              icon: const Icon(Icons.dark_mode))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              const Text(
                "Whatsapp will need to verify your phone number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              const Text(
                "What's your number ? ",
                style: TextStyle(
                    fontSize: 40,
                    color: Coloors.blue,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              Form(
                  child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: TextFormField(
                      controller: countryNameController,
                      cursorColor: Coloors.teal,
                      onTap: () {
                        showCountryCodePicker(context);
                      },
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Coloors.teal)),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Coloors.teal,
                          ),
                          hintText: "Ethiopia"),
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.15,
                        child: TextFormField(
                          onTap: () {
                            showCountryCodePicker(context);
                          },
                          controller: countryCodeController,
                          readOnly: true,
                          decoration: const InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Coloors.teal)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Coloors.teal)),
                              hintText: "+251",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.05,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        child: TextFormField(
                          keyboardAppearance: Theme.of(context).brightness,
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Coloors.teal)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Coloors.teal)),
                              hintText: "phone number"),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: ElevatedButton(
                      onPressed: () {
                        sendCodeToPhone();
                      },
                      child: const Text("Next"))),
            ]),
      ),
    );
  }

  sendCodeToPhone() {
    final phone = phoneNumberController.text;
    // final nameCountry = countryNameController.text;
    final codeCountry = countryCodeController.text;

    if (phone.isEmpty) {
      return alertDialog(
          context,
          'Please enter your phone number',
          const Icon(
            Icons.warning,
            color: Coloors.yellow,
          ));
    } else if (phone.length < 9) {
      return alertDialog(
          context,
          'The phone number you entred is too short',
          const Icon(
            Icons.warning,
            color: Coloors.yellow,
          ));
    } else if (phone.length > 10) {
      return alertDialog(
          context,
          'The phone number you entred is too long',
          const Icon(
            Icons.warning,
            color: Coloors.yellow,
          ));
    }
    ref
        .read(authControllerProvider)
        .sendSmsCode(context: context, phone: '$codeCountry$phone');
  }

  void showCountryCodePicker(BuildContext context) {
    showCountryPicker(
        context: context,
        onSelect: (country) {
          countryNameController.text = country.name;
          countryCodeController.text = "+${country.phoneCode}";
        },
        showPhoneCode: true,
        countryListTheme: CountryListThemeData(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottomSheetHeight: MediaQuery.sizeOf(context).height * 0.82,
            flagSize: 22,
            inputDecoration: const InputDecoration(
                fillColor: Coloors.teal,
                prefixIconColor: Coloors.teal,
                hintText: "Search",
                focusColor: Coloors.teal,
                prefixIcon: Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Coloors.greyDark)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Coloors.teal))),
            borderRadius: BorderRadius.circular(20)));
  }
}
