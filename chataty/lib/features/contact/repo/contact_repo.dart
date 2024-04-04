import 'package:chataty/common/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsRepoProvider =
    Provider((ref) => ContactRepo(firestore: FirebaseFirestore.instance));

class ContactRepo {
  final FirebaseFirestore firestore;

  ContactRepo({required this.firestore});

  Future<List<List>> getAllContacts() async {
    List<UserModel> firebaseContactsList = [];
    List<UserModel> phoneContactsList = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection("users").get();
        final phoneContacts =
            await FlutterContacts.getContacts(withProperties: true);

        bool isContactsFound = false;

        for (var conPhone in phoneContacts) {
          for (var conFire in userCollection.docs) {
            var firebaseContacts = UserModel.fromMap(conFire.data());

            if (conPhone.phones[0].number.replaceAll(' ', '') ==
                firebaseContacts.phoneNumber) {
              firebaseContactsList.add(firebaseContacts);
              isContactsFound = true;
              break;
            }
          }

          if (!isContactsFound) {
            phoneContactsList.add(UserModel(
                userName: conPhone.displayName,
                uid: '',
                profileImageUrl: '',
                active: false,
                lastseen: 0,
                phoneNumber: conPhone.phones[0].number.replaceAll(' ', ''),
                groupId: []));
          }
          isContactsFound = false;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return [firebaseContactsList, phoneContactsList];
  }
}
