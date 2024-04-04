import 'package:flutter/material.dart';
import 'package:shose_shop/models/sneakers_model.dart';
import 'package:shose_shop/services/helper.dart';
import 'package:shose_shop/views/shared/part_kids_shoes.dart';
import 'package:shose_shop/views/shared/part_men_shoes.dart';
import 'package:shose_shop/views/shared/part_women_shoes.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late Future<List<Sneakers>> men;
  late Future<List<Sneakers>> women;
  late Future<List<Sneakers>> kids;

  void getAllMenShoes() {
    men = Helper().getMenSneakers();
  }

  void getAllWomenShoes() {
    women = Helper().getWomenSneakers();
  }

  void getAllKidsShoes() {
    kids = Helper().getKidsSneakers();
  }

  @override
  Widget build(BuildContext context) {
    getAllMenShoes();
    getAllKidsShoes();
    getAllWomenShoes();
    return Stack(
      children: [
        Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70))),
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 40),
                        child: const Text(
                          "Athletics Shoes Collection",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(
                                child: Text(
                              "Men Shoes",
                              style: TextStyle(fontSize: 16),
                            )),
                            Tab(
                                child: Text(
                              "Women Shoes",
                              style: TextStyle(fontSize: 16),
                            )),
                            Tab(
                                child: Text(
                              "Kids Shoes",
                              style: TextStyle(fontSize: 16),
                            )),
                          ]),
                    ]))),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.25),
          child: TabBarView(controller: _tabController, children: [
            PartMenShoes(men: men),
            PartWomenShoes(women: women),
            PartKidsShoes(kids: kids),
          ]),
        ),
      ],
    );
  }
}
