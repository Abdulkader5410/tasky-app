import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shose_shop/controllers/cart_provider.dart';
import 'package:shose_shop/controllers/fav_provider.dart';
import 'package:shose_shop/controllers/main_screen_notifier.dart';
import 'package:shose_shop/controllers/product_details_provider.dart';
import 'package:shose_shop/views/screens/main_screen.dart';

import 'fav.dart';
import 'models/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  final pathHive = Directory('${appDocDir.path}/hive');
  if (!pathHive.existsSync()) {
    pathHive.createSync(recursive: true);
  }

  Hive.init(pathHive.path);
  Hive.registerAdapter(CartAdapter());
  Hive.registerAdapter(FavAdapter());
  Hive.openBox("box_cart");
  Hive.openBox("box_fav");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScrernNotifier()),
    ChangeNotifierProvider(create: (context) => ProDetScrernNotifier()),
    ChangeNotifierProvider(create: (context) => FavProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [defaultLifecycleObserver],
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
