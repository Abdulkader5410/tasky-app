import 'dart:io';

import 'package:chating_app/models/message.dart';
import 'package:chating_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs {
//for access auth
  static FirebaseAuth auth = FirebaseAuth.instance;

// for access to firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage firestorage = FirebaseStorage.instance;

  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static getTokenMessaging() async {
    await firebaseMessaging.requestPermission();
    await firebaseMessaging.getToken().then((token) {
      if (token != null) {
        me.pushToken = token;
      }
    });
  }

//to get info users
  static User get user => auth.currentUser!;
  static late UserModel me;

  static Future<bool> isUserExist() async {
    return (await firestore.collection("Users").doc(user.uid).get()).exists;
  }

  static Future<void> addUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final currUser = UserModel(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey i'am using ChatyApp",
        image: user.photoURL.toString(),
        isOnline: false,
        createdAt: time,
        lastActive: time,
        pushToken: '');

    return (await firestore
        .collection("Users")
        .doc(user.uid)
        .set(currUser.toJson()));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection("Users")
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> getMyInfo() async {
    await firestore.collection("Users").doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = UserModel.fromJson(user.data()!);
        await getTokenMessaging();
        updateActiveStatus(true);
      } else {
        addUser().then((value) => getMyInfo());
      }
    });
  }

  static Future<void> updateInfoUser() async {
    await firestore
        .collection("Users")
        .doc(user.uid)
        .update({"name": me.name, "about": me.about});
  }

  static Future<void> updateImageUser(File file) async {
    final ext = file.path.split('.').last;
    final ref = firestorage.ref().child("profile_pictures/${user.uid}.$ext");
    await ref.putFile(file, SettableMetadata(contentType: "image/$ext"));

    me.image = await ref.getDownloadURL();
    await firestore
        .collection("Users")
        .doc(user.uid)
        .update({"image": me.image});
  }

  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      UserModel userModel) {
    return firestore
        .collection("Chats/${getConversationId(userModel.id)}/Messages/")
        .orderBy("sent", descending: true)
        .snapshots();
  }

  static Future<void> sendMsg(
      UserModel userModel, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    MessageModel messageModel = MessageModel(
        sender: user.uid,
        reciver: userModel.id,
        sent: time,
        read: "",
        type: type,
        message: msg);

    final ref = firestore
        .collection("Chats/${getConversationId(userModel.id)}/Messages/");
    await ref.doc(time).set(messageModel.toJson());
  }

  static Future<void> updateReadStatus(MessageModel messageModel) async {
    final ref1 = firestore.collection(
        "Chats/${getConversationId(messageModel.sender)}/Messages/");
    await ref1
        .doc(messageModel.sent)
        .update({"read": DateTime.now().millisecondsSinceEpoch.toString()});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      UserModel userModel) {
    return firestore
        .collection("Chats/${getConversationId(userModel.id)}/Messages/")
        .orderBy("sent", descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<void> sendImageChat(UserModel userModel, File file) async {
    final ext = file.path.split('.').last;
    final ref = firestorage.ref().child(
        "images/${getConversationId(userModel.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext");
    await ref.putFile(file, SettableMetadata(contentType: "image/$ext"));

    final imageUrl = await ref.getDownloadURL();
    await sendMsg(userModel, imageUrl, Type.image);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      UserModel userModel) {
    return firestore
        .collection("Users")
        .where("id", isEqualTo: userModel.id)
        .snapshots();
  }

  static Future<void> updateActiveStatus(bool isOnline) async {
    await firestore.collection("Users").doc(user.uid).update({
      "isOnline": isOnline,
      "lastActive": DateTime.now().millisecondsSinceEpoch.toString(),
      "pushToken": me.pushToken
    });
  }

  static Future<void> deleteMsg(MessageModel messageModel) async {
    await firestore
        .collection(
            "Chats/${getConversationId(messageModel.reciver)}/Messages/")
        .doc(messageModel.sent)
        .delete();

    if (Type.image == messageModel.type) {
      await firestorage.refFromURL(messageModel.message).delete();
    }
  }
}
