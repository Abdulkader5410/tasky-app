import 'package:chataty/common/colors/coloors.dart';
import 'package:chataty/common/my themes/saved_last_theme.dart';
import 'package:chataty/common/my themes/theme_provider.dart';
import 'package:chataty/features/auth/controller/auth_controller.dart';
import 'package:chataty/features/home/widgets/calls_tab.dart';
import 'package:chataty/features/home/widgets/chats_tab.dart';
import 'package:chataty/features/home/widgets/status_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    ref.read(authControllerProvider).updateUserPresence();
    ref.read(authControllerProvider).updateActiveStatus(true);

    SystemChannels.lifecycle.setMessageHandler((message) async {
      if (ref.read(authControllerProvider).authRepo!.auth!.currentUser !=
          null) {
        if (message.toString().contains('resume')) {
          ref.read(authControllerProvider).updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          ref.read(authControllerProvider).updateActiveStatus(false);
        }
        if (message.toString().contains('inactive')) {
          ref.read(authControllerProvider).updateActiveStatus(false);
        }
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          title: const Text("WhatsApp",
              style: TextStyle(fontWeight: FontWeight.w400)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
            IconButton(
                onPressed: () {
                   ref.read(myThemeProvider.notifier).toggleLight();
                      SavedLastTheme.savedTheme(1);
                },
                icon: const Icon(Icons.light_mode)),
            IconButton(
                onPressed: () {
                  ref.read(myThemeProvider.notifier).toggleDark();
                      SavedLastTheme.savedTheme(0);
                },
                icon: const Icon(Icons.dark_mode))
          ],
          bottom: const TabBar(
            indicatorColor: Coloors.teal,
            indicatorWeight: 3,
            tabs: [
              Tab(
                child: Text("CHATS"),
              ),
              Tab(
                child: Text("STATUS"),
              ),
              Tab(
                child: Text("CALLS"),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          ChatsTab(),
          StatusTab(),
          CallsTab(),
        ]),
      ),
    );
  }
}
