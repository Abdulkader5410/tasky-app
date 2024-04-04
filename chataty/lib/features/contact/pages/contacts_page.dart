import 'package:chataty/common/colors/coloors.dart';
import 'package:chataty/common/models/user_model.dart';
import 'package:chataty/common/routes/routes.dart';
import 'package:chataty/features/contact/controller/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends ConsumerWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Select Contacts",
            style: TextStyle(fontSize: 14),
          ),
          ref.watch(contactsControllerProvider).when(
            data: (allContacts) {
              return Text(
                "${allContacts[0].length} Contact${allContacts[0].length == 1 ? '' : 's'}",
                style: const TextStyle(fontSize: 12),
              );
            },
            error: (error, stackTrace) {
              return const SizedBox();
            },
            loading: () {
              return const Text("Counting");
            },
          ),
        ]),
      ),
      body: ref.read(contactsControllerProvider).when(
        data: (allContacts) {
          return ListView.builder(
            itemCount: allContacts[0].length + allContacts[1].length,
            itemBuilder: (context, index) {
              late UserModel firebaseContact ;
              late UserModel phonecontact ;


              if (index < allContacts[0].length) {
                firebaseContact = allContacts[0][index];
              } else {
                phonecontact = allContacts[1][index - allContacts[0].length];
              }

              print(firebaseContact);

              return index < allContacts[0].length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text("New Group"),
                                  leading: CircleAvatar(
                                    backgroundColor: Coloors.green,
                                    child:
                                        Icon(Icons.group, color: Coloors.light),
                                  ),
                                ),
                                ListTile(
                                  title: Text("New Contact"),
                                  leading: CircleAvatar(
                                    backgroundColor: Coloors.green,
                                    child: Icon(Icons.person_add,
                                        color: Coloors.light),
                                  ),
                                  trailing: Icon(
                                    Icons.qr_code,
                                    color: Coloors.green,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16, top: 8),
                                  child: Text("Contacts on WhatsApp"),
                                ),
                              ]),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.chatPage,
                                arguments: firebaseContact);
                          },
                          title: Text(firebaseContact.userName!),
                          subtitle:
                              const Text("Hey there ! I am using whatsapp"),
                          leading: CircleAvatar(
                            backgroundColor: Coloors.greyDark,
                            radius: 20,
                            backgroundImage:
                                firebaseContact.profileImageUrl!.isNotEmpty
                                    ? NetworkImage(
                                        firebaseContact.profileImageUrl!)
                                    : null,
                            child: firebaseContact.profileImageUrl!.isEmpty
                                ? const Icon(Icons.person)
                                : null,
                          ),
                        )
                      ],
                    )
                  //users have not this app
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == allContacts[0].length)
                          const Padding(
                            padding: EdgeInsets.only(left: 16, top: 8),
                            child: Text("Invite to use WhatsApp"),
                          ),
                        ListTile(
                          trailing: TextButton(
                              onPressed: () async {
                                Uri sms = Uri.parse(
                                    "sms:${phonecontact.phoneNumber}?body=ABD");
                                if (await canLaunchUrl(sms)) {
                                  launchUrl(sms);
                                } else {}
                              },
                              child: const Text(
                                "Invite",
                                style: TextStyle(color: Coloors.teal),
                              )),
                          title: Text(phonecontact.userName!),
                          leading: const CircleAvatar(
                            backgroundColor: Coloors.gretLight,
                            radius: 20,
                            child: Icon(Icons.person, color: Coloors.light),
                          ),
                        )
                      ],
                    );
            },
          );
        },
        error: (error, stackTrace) {
          return null;
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(
              color: Coloors.gretLight,
            ),
          );
        },
      ),
    );
  }
}
