import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shose_shop/controllers/main_screen_notifier.dart';
import 'package:shose_shop/views/screens/cart_screen.dart';
import 'package:shose_shop/views/screens/home_screen.dart';
import 'package:shose_shop/views/screens/profile_screen.dart';
import 'package:shose_shop/views/screens/search_screen.dart';

import 'fav_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  List<Widget> screensList = const [
    FavScreen(),
    SearchScreen(),
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScrernNotifier>(
        builder: (context, mainScrernNotifier, child) {
      return Scaffold(
        body: screensList[mainScrernNotifier.pageIndex],
        bottomNavigationBar: Container(
            height: 50,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      mainScrernNotifier.changIndex(0);
                    },
                    icon: Icon(Icons.favorite_border_outlined,
                        color: mainScrernNotifier.pageIndex == 0
                            ? Colors.white
                            : Colors.grey,
                        size: 30)),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                    onPressed: () {
                      mainScrernNotifier.changIndex(1);
                    },
                    icon: Icon(Icons.search_outlined,
                        color: mainScrernNotifier.pageIndex == 1
                            ? Colors.white
                            : Colors.grey,
                        size: 30)),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                    onPressed: () {
                      mainScrernNotifier.changIndex(2);
                    },
                    icon: Icon(Icons.home_outlined,
                        color: mainScrernNotifier.pageIndex == 2
                            ? Colors.white
                            : Colors.grey,
                        size: 30)),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                    onPressed: () {
                      mainScrernNotifier.changIndex(3);
                    },
                    icon: Icon(Icons.shopping_cart_outlined,
                        color: mainScrernNotifier.pageIndex == 3
                            ? Colors.white
                            : Colors.grey,
                        size: 30)),
                const SizedBox(width: 16),
                IconButton(
                    onPressed: () {
                      mainScrernNotifier.changIndex(4);
                    },
                    icon: Icon(Icons.person_2_outlined,
                        color: mainScrernNotifier.pageIndex == 4
                            ? Colors.white
                            : Colors.grey,
                        size: 30))
              ],
            )),
      );
    });
  }
}
