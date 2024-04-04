import 'package:chataty/common/models/user_model.dart';
import 'package:chataty/features/auth/repository/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo);
});

final userInfoProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getCurrUser();
});

class AuthController {
  final AuthRepo? authRepo;

  AuthController({required this.authRepo});

  void setOffline() async {
    authRepo!.setOffline();
  }

  void updateUserPresence() async {
    return authRepo!.updateUserPresence();
  }

  void updateActiveStatus(bool isOnline) async {
    authRepo!.updateActiveStatus(isOnline);
  }

  void saveUserInfoToFirestore(
      {required String userName,
      required var profileImage,
      required BuildContext context,
      required bool mounted}) {
    authRepo!.saveUserInfoToFirestore(
        userName: userName,
        profileImage: profileImage,
        context: context,
        mounted: mounted);
  }

  Future<UserModel?> getCurrUser() async {
    UserModel? userModel = await authRepo!.getCurrUser();
    return userModel;
  }

  void verifySmsCode(
      {required BuildContext context,
      required String smsCodeId,
      required String smsCode,
      required bool mounted}) async {
    authRepo!.verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sendSmsCode(
      {required BuildContext context, required String phone}) async {
    return authRepo!.sendSmsCode(context: context, phone: phone);
  }
}
