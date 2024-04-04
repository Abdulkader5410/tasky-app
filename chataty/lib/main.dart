import 'package:chataty/common/my%20themes/saved_last_theme.dart';
import 'package:chataty/common/routes/routes.dart';
import 'package:chataty/features/auth/controller/auth_controller.dart';
import 'package:chataty/features/home/home_page.dart';
import 'package:chataty/features/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/my themes/my_theme.dart';
import 'common/my themes/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const ProviderScope(
    child: ProviderScope(child: MyApp()),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(myThemeProvider);

    return FutureBuilder<int>(
        future: SavedLastTheme.getTheme(),
        builder: (context, snapshot) {
          int lastTheme = snapshot.data ?? -1;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SizedBox());
          } else {
            return MaterialApp(
              
              theme: lastTheme == 0
                  ? MyCustomTheme().darkTheme
                  : lastTheme == 1
                      ? MyCustomTheme().lightTheme
                      : theme.isLightTheme == true
                          ? MyCustomTheme().lightTheme
                          : MyCustomTheme().darkTheme,
              debugShowCheckedModeBanner: false,
              home: ref.watch(userInfoProvider).when(data: (user) {
                if (user == null) {
                  return const WelcomPage();
                }
                return  const HomePage();
              }, error: (error, trace) {
                return Scaffold(
                  body: Center(
                      child: Container(
                    color: Colors.green,
                    child: const Text("Error"),
                  )),
                );
              }, loading: () {
                return Scaffold(
                  body: Center(
                      child: Container(
                    color: Colors.green,
                    child: const Text("Loading ..."),
                  )),
                );
              }),
              onGenerateRoute: Routes.onGenerateRout,
            );
          }
        });
  } 
}