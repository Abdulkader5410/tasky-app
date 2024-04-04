import 'package:chataty/common/models/user_model.dart';
import 'package:chataty/features/auth/pages/login/login_page.dart';
import 'package:chataty/features/auth/pages/profile_info/profile_info_page.dart';
import 'package:chataty/features/auth/pages/verify_code/verify_page.dart';
import 'package:chataty/features/chat/pages/chat_page.dart';
import 'package:chataty/features/chat/pages/user_chat_profile.dart';
import 'package:chataty/features/contact/pages/contacts_page.dart';
import 'package:chataty/features/home/home_page.dart';
import 'package:chataty/features/welcome/welcome.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String welcomePage = "welcomePage";
  static const String loginPage = "loginPage";
  static const String signupPage = "signupPage";
  static const String verifyPage = "verifyPage";
  static const String profileInfoPage = "profileInfoPage";
  static const String homePage = "homePage";
  static const String contactsPage = "contactsPage";
  static const String chatPage = "chatPage";
  static const String userChatProfile = "userChatProfile";

  static Route<dynamic> onGenerateRout(RouteSettings settings) {
    switch (settings.name) {
      case welcomePage:
        return MaterialPageRoute(
          builder: (context) => const WelcomPage(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case profileInfoPage:
        final String? imageProfileUrl = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) =>
              ProfileInfoPage(imageProfileUrl: imageProfileUrl),
        );
      case verifyPage:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) =>
              VerifyPage(phone: args['phone'], smsCodeId: args['smsCodeId']),
        );
      case homePage:

        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case contactsPage:
        return MaterialPageRoute(
          builder: (context) => const ContactsPage(),
        );
      case chatPage:
        final UserModel userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => ChatPage(userModel: userModel));

              case userChatProfile:
        final UserModel userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => UserChatProfile(userModel: userModel));
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("No Routes !")),
          ),
        );
    }
  }
}
