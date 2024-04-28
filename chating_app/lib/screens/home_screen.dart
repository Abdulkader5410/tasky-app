// ignore_for_file: use_build_context_synchronously

import 'package:chating_app/apis/apis.dart';
import 'package:chating_app/main.dart';
import 'package:chating_app/models/user.dart';
import 'package:chating_app/screens/proflie_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/chat_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> userList = [];
  final List<UserModel> searchList = [];
  bool isSearching = false;

  @override
  void initState() {
    APIs.getMyInfo();
    super.initState();

    SystemChannels.lifecycle.setMessageHandler((message) async{
      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          await APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          await APIs.updateActiveStatus(false);
        }
         if (message.toString().contains('inactive')) {
          await APIs.updateActiveStatus(false);
        }
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: darkpurple, statusBarColor: darkpurple));
    return WillPopScope(
      onWillPop: () async {
        if (isSearching) {
          setState(() {
            isSearching = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                elevation: 2,
                backgroundColor: darkpurple,
                onPressed: () {},
                isExtended: true,
                tooltip: "Add Friend",
                // label: Text(
                //   "Add freind",
                //   style: TextStyle(
                //       color: white, fontSize: 14, fontWeight: FontWeight.w400),
                // ),
                child: Icon(
                  CupertinoIcons.person_add,
                  color: white,
                  size: 30,
                )),
            appBar: AppBar(
                leading: isSearching
                    ? null
                    : const Icon(CupertinoIcons.home, size: 25),
                actions: [
                  Transform.translate(
                      offset: const Offset(-15, 0),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              isSearching = !isSearching;
                            });
                          },
                          icon: isSearching
                              ? const Icon(
                                  CupertinoIcons.clear,
                                  size: 30,
                                )
                              : const Icon(
                                  CupertinoIcons.search,
                                  size: 30,
                                ))),
                  Transform.translate(
                      offset: const Offset(-10, 0),
                      child: IconButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(user: APIs.me),
                              ));
                        },
                        icon: const Icon(
                          CupertinoIcons.person,
                          size: 30,
                        ),
                      )),
                ],
                elevation: 1,
                backgroundColor: darkpurple,
                centerTitle: true,
                title: isSearching
                    ? Container(
                        height: 45,
                        width: 230,
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        decoration: BoxDecoration(
                            color: light,
                            borderRadius: BorderRadius.circular(25)),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          style: TextStyle(fontSize: 16, color: black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 16, color: black),
                            hintText: "Search on users",
                          ),
                          autofocus: true,
                          cursorColor: darkpurple,
                          onChanged: (value) {
                            searchList.clear();
                            for (var i in userList) {
                              if (i.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase())) {
                                searchList.add(i);
                              }
                              setState(() {
                                searchList;
                              });
                            }
                          },
                        ),
                      )
                    : const Text("Chaty")),
            body: Padding(
              padding: const EdgeInsets.all(6),
              child: StreamBuilder(
                stream: APIs.getAllUsers(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      userList = data
                              ?.map((e) => UserModel.fromJson(e.data()))
                              .toList() ??
                          [];
                      if (userList.isNotEmpty) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              isSearching ? searchList.length : userList.length,
                          itemBuilder: (context, index) {
                            return ChatItem(
                                user: isSearching
                                    ? searchList[index]
                                    : userList[index]);
                          },
                        );
                      } else {
                        return const Center(child: Text("No Chats"));
                      }
                  }
                },
              ),
            )),
      ),
    );
  }
}
