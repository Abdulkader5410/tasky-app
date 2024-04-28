import 'package:chating_app/apis/apis.dart';
import 'package:chating_app/main.dart';
import 'package:chating_app/models/message.dart';
import 'package:chating_app/models/user.dart';
import 'package:chating_app/screens/chat_screen.dart';
import 'package:chating_app/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final UserModel user;

  const ChatItem({super.key, required this.user});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  MessageModel? messageModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: light,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(user: widget.user),
              ));
        },
        child: StreamBuilder(
          stream: APIs.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final messageList =
                data?.map((e) => MessageModel.fromJson(e.data())).toList() ??
                    [];

            if (messageList.isNotEmpty) {
              messageModel = messageList[0];
            }

            return Column(
              children: [
                ListTile(
                    title: Text(widget.user.name),
                    subtitle: Text(messageModel != null
                        ? messageModel!.type == Type.image
                            ? "Image"
                            : messageModel!.message
                        : widget.user.about),
                    leading: CircleAvatar(
                        backgroundColor: darkpurple,
                        child: Icon(
                          color: light,
                          CupertinoIcons.person,
                          size: 30,
                        )),
                    trailing: messageModel == null
                        ? null
                        : messageModel!.read.isEmpty &&
                                messageModel!.sender != APIs.user.uid
                            ? Container(
                                color: green,
                                width: 14,
                                height: 14,
                              )
                            : Text(Utilities.getLastTimeOfMsg(
                                context, messageModel!.sent))),
                Divider(
                  thickness: 0.1,
                  color: darkpurple,
                )
              ],
            );
          },
        ));
  }
}
