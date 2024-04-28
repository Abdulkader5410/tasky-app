// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chating_app/apis/apis.dart';
import 'package:chating_app/main.dart';
import 'package:chating_app/models/message.dart';
import 'package:chating_app/utilities/utilities.dart';
import 'package:chating_app/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.messageModel.sender
        ? _reciverMsg()
        : _senderMsg();
  }

  Widget _reciverMsg() {
    return InkWell(
      onLongPress: () {
        showCustomBottomSheet();
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: orang,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    widget.messageModel.type == Type.text
                        ? Text(
                            widget.messageModel.message,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: white,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              width: mediaQuery.width * 0.6,
                              height: mediaQuery.width * 0.6,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              imageUrl: widget.messageModel.message,
                              errorWidget: (context, url, error) {
                                return const Icon(
                                  Icons.image,
                                  size: 70,
                                );
                              },
                            ),
                          ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getFormatTime(widget.messageModel.sent),
                          style: TextStyle(fontSize: 10.0, color: white),
                        ),
                        const SizedBox(width: 10.0),
                        if (widget.messageModel.read.isNotEmpty)
                          Icon(
                            Icons.done_all,
                            size: 20,
                            color: green,
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _senderMsg() {
    if (widget.messageModel.read.isEmpty) {
      APIs.updateReadStatus(widget.messageModel);
    }

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: darkRed,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.messageModel.type == Type.text
                      ? Text(
                          widget.messageModel.message,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: white,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: CachedNetworkImage(
                            width: mediaQuery.width * 0.6,
                            height: mediaQuery.width * 0.6,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            imageUrl: widget.messageModel.message,
                            errorWidget: (context, url, error) {
                              return const Icon(
                                Icons.image,
                                size: 70,
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // if (widget.messageModel.read.isNotEmpty)
                      //   Icon(
                      //     Icons.done_all,
                      //     size: 20,
                      //     color: green,
                      //   ),
                      const SizedBox(width: 10.0),
                      Text(
                        getFormatTime(widget.messageModel.sent),
                        style: TextStyle(fontSize: 10.0, color: white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getFormatTime(String time) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  void showCustomBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      context: context,
      builder: (_) {
        return ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 25.0),
            InkWell(
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: widget.messageModel.message));
                Navigator.pop(context);
                Dialogs.showSnakBar(context, "Text Copied !");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.messageModel.read.isNotEmpty)
                    Icon(
                      Icons.copy,
                      size: 30,
                      color: orang,
                    ),
                  const SizedBox(width: 10.0),
                  Text(
                    "Copy Message",
                    style: TextStyle(fontSize: 16.0, color: black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            InkWell(
              onTap: () async {
                await APIs.deleteMsg(widget.messageModel).then((value) {
                  Navigator.pop(context);
                  Dialogs.showSnakBar(context, "Message deleted !");
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.messageModel.read.isNotEmpty)
                    Icon(
                      Icons.delete,
                      size: 30,
                      color: darkRed,
                    ),
                  const SizedBox(width: 10.0),
                  Text(
                    "Delete Message",
                    style: TextStyle(fontSize: 16.0, color: black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            Divider(color: black, thickness: 0.1),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.messageModel.read.isNotEmpty)
                  Icon(
                    Icons.done_all,
                    size: 30,
                    color: green,
                  ),
                const SizedBox(width: 10.0),
                Text(
                  "Time Sent  :  ${getFormatTime(widget.messageModel.sent)}",
                  style: TextStyle(fontSize: 16.0, color: black),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.messageModel.read.isNotEmpty)
                  Icon(
                    Icons.remove_red_eye,
                    size: 30,
                    color: gray,
                  ),
                const SizedBox(width: 10.0),
                Text(
                  widget.messageModel.read.isEmpty
                      ? "Not Seen Yet"
                      : "Read At :  ${Utilities.getTimeOfMsg(context, widget.messageModel.read)}",
                  style: TextStyle(fontSize: 16.0, color: black),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
