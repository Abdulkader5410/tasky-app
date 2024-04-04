import 'package:chataty/common/routes/routes.dart';
import 'package:flutter/material.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({super.key});

  @override
  State<ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Chats")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.contactsPage);
        },
        child: const Text("Chats"),
      ),
    );
  }
}
