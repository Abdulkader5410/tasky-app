import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chating_app/apis/apis.dart';
import 'package:chating_app/main.dart';
import 'package:chating_app/models/message.dart';
import 'package:chating_app/models/user.dart';
import 'package:chating_app/utilities/utilities.dart';
import 'package:chating_app/widgets/message_item.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  const ChatScreen({super.key, required this.user});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> messageList = [];
  final msgConroller = TextEditingController();
  bool isShowEmoji = false, isUploadingImage = false;

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (isShowEmoji) {
              setState(() {
                isShowEmoji = !isShowEmoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            backgroundColor: white,
            appBar: AppBar(
                automaticallyImplyLeading: false, flexibleSpace: _appBar()),
            body: Column(children: [
              Expanded(
                child: StreamBuilder(
                  stream: APIs.getAllMessages(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        messageList = data
                                ?.map((e) => MessageModel.fromJson(e.data()))
                                .toList() ??
                            [];
                        if (messageList.isNotEmpty) {
                          return ListView.builder(
                            reverse: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: messageList.length,
                            itemBuilder: (context, index) {
                              return MessageItem(
                                  messageModel: messageList[index]);
                            },
                          );
                        } else {
                          return const Center(child: Text("No Chats"));
                        }
                    }
                  },
                ),
              ),
              if (isUploadingImage)
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              _chatInput(),
              if (isShowEmoji)
                SizedBox(
                  height: mediaQuery.height * 0.35,
                  child: EmojiPicker(
                    textEditingController: msgConroller,
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    ),
                  ),
                )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
        onTap: () {},
        child: StreamBuilder(
          stream: APIs.getUserInfo(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final userList =
                data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];

            return Row(children: [
              const SizedBox(
                width: 6,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: white,
                    size: 30,
                  )),
              const SizedBox(
                width: 10,
              ),
              ClipOval(
                child: CachedNetworkImage(
                  width: mediaQuery.width * 0.14,
                  height: mediaQuery.height * 0.08,
                  fit: BoxFit.cover,
                  imageUrl: userList.isNotEmpty
                      ? userList[0].image
                      : widget.user.image,
                  errorWidget: (context, url, error) {
                    return CircleAvatar(
                        backgroundColor: darkpurple,
                        child: Icon(
                          color: white,
                          CupertinoIcons.person,
                          size: 30,
                        ));
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    userList.isNotEmpty ? userList[0].name : widget.user.name,
                    style: TextStyle(
                        fontSize: 16,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                      textAlign: TextAlign.start,
                      userList.isNotEmpty
                          ? userList[0].isOnline
                              ? "Online"
                              : Utilities.getLastActiveTimeOfUser(
                                  context, userList[0].lastActive)
                          : Utilities.getLastActiveTimeOfUser(
                              context, widget.user.lastActive),
                      style: TextStyle(fontSize: 12, color: white)),
                ],
              ),
            ]);
          },
        ));
  }

  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: light, borderRadius: BorderRadius.circular(25)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isShowEmoji = !isShowEmoji;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.smiley,
                        color: darkpurple,
                        size: 30,
                      )),
                  SizedBox(
                    width: mediaQuery.width * 0.35,
                    child: TextFormField(
                      onTap: () {
                        if (isShowEmoji) {
                          setState(() => isShowEmoji = !isShowEmoji);
                        }
                      },
                      controller: msgConroller,
                      maxLines: null,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: darkpurple,
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                      decoration: const InputDecoration(
                          hintText: "Typing here....",
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      final ImagePicker imagePicker = ImagePicker();
                      final List<XFile> listPickedImages =
                          await imagePicker.pickMultiImage(imageQuality: 70);
                      if (listPickedImages.isNotEmpty) {
                        for (var i in listPickedImages) {
                          setState(() => isUploadingImage = true);
                          APIs.sendImageChat(widget.user, File(i.path));
                        }
                        setState(() => isUploadingImage = false);
                      }
                    },
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => LinearGradient(
                          tileMode: TileMode.mirror,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue, green]).createShader(bounds),
                      child: const Icon(
                        CupertinoIcons.photo_on_rectangle,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      final ImagePicker imagePicker = ImagePicker();
                      final XFile? pickedImage = await imagePicker.pickImage(
                          source: ImageSource.camera);
                      if (pickedImage != null) {
                        setState(() => isUploadingImage = true);
                        APIs.sendImageChat(widget.user, File(pickedImage.path));
                        setState(() => isUploadingImage = false);
                      }
                    },
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => LinearGradient(
                          tileMode: TileMode.mirror,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [orang, darkpurple]).createShader(bounds),
                      child: const Icon(
                        CupertinoIcons.camera,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ]),
          ),
          CircleAvatar(
            backgroundColor: white,
            child: MaterialButton(
              onPressed: () {
                if (msgConroller.text.isNotEmpty) {
                  APIs.sendMsg(widget.user, msgConroller.text, Type.text);
                  msgConroller.text = '';
                }
              },
              child: Icon(
                CupertinoIcons.paperplane,
                size: 30,
                color: darkpurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
