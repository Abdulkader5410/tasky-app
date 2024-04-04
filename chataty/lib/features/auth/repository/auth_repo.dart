// ignore_for_file: use_build_context_synchronously

import 'package:chataty/common/models/user_model.dart';
import 'package:chataty/common/repo/firestore_repo.dart';
import 'package:chataty/common/routes/routes.dart';
import 'package:chataty/common/widgets/alert_dialog.dart';
import 'package:chataty/common/widgets/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider((ref) {
  return AuthRepo(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      realtime: FirebaseDatabase.instance,
      ref: ref);
});

class AuthRepo {
  FirebaseAuth? auth;
  FirebaseFirestore? firestore;
  FirebaseDatabase? realtime;
  ProviderRef ref;

  AuthRepo({
    required this.auth,
    required this.firestore,
    required this.realtime,
    required this.ref,
  });

void setOffline() async {
    Map<String, dynamic> offline = {
      'active': false,
      'lastseen': DateTime.now().millisecondsSinceEpoch
    };
    await realtime!.ref().child(auth!.currentUser!.uid).update(offline);
  }

void updateActiveStatus(bool isOnline) async {
    await firestore!.collection("users").doc(auth!.currentUser!.uid).update({
      "active": isOnline,
      "lastseen": DateTime.now().millisecondsSinceEpoch,
      
    });
  }

  void updateUserPresence()async{
    Map<String,dynamic> online = {
      'active':true,
      'lastseen':DateTime.now().millisecondsSinceEpoch
    } ;
    Map<String,dynamic> offline = {
      'active':false,
      'lastseen':DateTime.now().millisecondsSinceEpoch
    } ;

    final connectedRef = realtime!.ref('.info/connected');

    connectedRef.onValue.listen((event) async{
      final isConn = event.snapshot.value as bool? ?? false;
      if(isConn){
        await realtime!.ref().child(auth!.currentUser!.uid).update(online);
      }
      else{
          await realtime!.ref().child(auth!.currentUser!.uid).onDisconnect().update(offline);
      }
     });

  }

  Future<UserModel?> getCurrUser() async {
    UserModel? userModel;
    if (auth != null) {
      final userInfo = await firestore!
          .collection('users')
          .doc(auth!.currentUser?.uid)
          .get();
      if (userInfo.data() == null) return userModel;
      return userModel = UserModel.fromMap(userInfo.data()!);
    }
    return userModel;
  }

  void saveUserInfoToFirestore(
      {required String userName,
      required var profileImage,
      required BuildContext context,
      required bool mounted}) async {
    try {
      loadingDialog(context, "Saving your info ...");
      String uid = auth!.currentUser!.uid;
      String imageProfileUrl = profileImage is String ? profileImage : '';
      if (profileImage != null && profileImage is! String) {
        imageProfileUrl = await ref
            .read(firestoreRepoProvider)
            .storeFileToFirestore('profileImage/$uid', profileImage);
      }
      UserModel userModel = UserModel(
          userName: userName,
          uid: uid,
          profileImageUrl: imageProfileUrl,
          active: true,
          lastseen: DateTime.now().millisecondsSinceEpoch,
          phoneNumber: auth!.currentUser!.phoneNumber,
          groupId: []);

      await firestore!.collection('users').doc(uid).set(userModel.toMap());

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homePage, (route) => false);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  void verifySmsCode(
      {required BuildContext context,
      required String smsCodeId,
      required String smsCode,
      required bool mounted}) async {
    try {
      loadingDialog(context, "Verifiying code ...");
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth!.signInWithCredential(credential);
      if (!mounted) return;
      UserModel? user = await getCurrUser();
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.profileInfoPage, (route) => false,
          arguments: user?.profileImageUrl);
    } on FirebaseAuthException {
      Navigator.pop(context);
      alertDialog(
          context,
          "The code number you entered is worng , please check your message box and try again",
          const Icon(
            Icons.close,
            color: Colors.red,
          ));
    }
  }

  void sendSmsCode(
      {required BuildContext context, required String phone}) async {
    try {
      loadingDialog(context, "Sending a verification code to $phone");
      await auth!.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await auth!.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          alertDialog(
              context, error.message.toString(), const Icon(Icons.info));
        },
        codeSent: (smsCodeId, resendSmsCodeId) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.verifyPage, (route) => false,
              arguments: {'phone': phone, 'smsCodeId': smsCodeId});
        },
        codeAutoRetrievalTimeout: (String smsCodeId) {},
      );
    } on FirebaseAuth catch (ex) {
      Navigator.pop(context);
      alertDialog(context, ex.toString(), const Icon(Icons.info));
    }
  }
}
