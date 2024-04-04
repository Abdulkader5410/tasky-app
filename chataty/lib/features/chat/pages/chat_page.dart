import 'package:chataty/common/colors/coloors.dart';
import 'package:chataty/common/models/user_model.dart';
import 'package:chataty/common/my themes/saved_last_theme.dart';
import 'package:chataty/common/my themes/theme_provider.dart';
import 'package:chataty/common/routes/routes.dart';
import 'package:chataty/common/utils/my_date_utils.dart';
import 'package:chataty/features/auth/controller/auth_controller.dart';
import 'package:chataty/features/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cProvider =
    StateNotifierProvider<ChatController, bool>((ref) => ChatController());

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.read(authControllerProvider).updateUserPresence();

    final isTyping = ref.watch(cProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 25,
                )),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.02,
            ),
            CircleAvatar(
              backgroundColor: Coloors.greyDark,
              radius: 20,
              backgroundImage: widget.userModel.profileImageUrl!.isNotEmpty
                  ? NetworkImage(widget.userModel.profileImageUrl!)
                  : null,
              child: widget.userModel.profileImageUrl!.isEmpty
                  ? const Icon(Icons.person)
                  : null,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.05,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.userChatProfile,
                    arguments: widget.userModel);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userModel.userName!,
                      style: const TextStyle(fontSize: 14)),
                  Text(
                      widget.userModel.active == true
                          ? "Online"
                          : MyDateUtils().getLastAcvtiveTime(
                              context: context,
                              lastActive: widget.userModel.lastseen),
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w300)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(
              onPressed: () {
               ref.read(myThemeProvider.notifier).toggleLight();
                    SavedLastTheme.savedTheme(1);
              },
              icon: const Icon(Icons.light_mode, size: 25),
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(
              onPressed: () {
                ref.read(myThemeProvider.notifier).toggleDark();
                    SavedLastTheme.savedTheme(0);
              },
              icon: const Icon(Icons.dark_mode, size: 25),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).dividerColor),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                            controller: textEditingController,
                            onChanged: (value) {
                              ref
                                  .read(cProvider.notifier)
                                  .change(textEditingController.text);
                            },
                            maxLines: 10,
                            minLines: 1,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Typing here",
                                hintStyle: TextStyle(fontSize: 14))),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attachment)),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_outlined)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 25,
                backgroundColor: Coloors.teal,
                child: Center(
                  child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {},
                      icon: Icon(isTyping ? Icons.abc : Icons.ac_unit)),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
