import 'package:flutter/material.dart';
import 'package:shose_shop/models/sneakers_model.dart';
import 'package:shose_shop/services/helper.dart';
import 'package:shose_shop/views/shared/current_categ.dart';


class AllCategScreen extends StatefulWidget {
  const AllCategScreen({super.key});

  @override
  State<AllCategScreen> createState() => _AllCategScreenState();
}

class _AllCategScreenState extends State<AllCategScreen>
    with TickerProviderStateMixin {
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
  void initState() {
    super.initState();
    getAllMenShoes();
    getAllKidsShoes();
    getAllWomenShoes();
  }

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;

    late final TabController tabController =
        TabController(length: 3, vsync: this, initialIndex: index);

    return Scaffold(
        body: Stack(
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
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.05,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  filtter();
                                },
                                icon: const Icon(
                                  Icons.filter_list_alt,
                                  color: Colors.white,
                                ))
                          ]),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: tabController,
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
          child: TabBarView(
            controller: tabController,
            children: [
              CurrentCateg(currentCateg: men),
              CurrentCateg(currentCateg: women),
              CurrentCateg(currentCateg: kids),
            ],
          ),
        ),
      ],
    ));
  }

  Future<dynamic> filtter() {
    double value = 100;
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  height: MediaQuery.sizeOf(context).height * 0.01,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                ),
                const SizedBox(
                  height: 7,
                ),
                const Text("Filter",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 14,
                ),
                const Text("Gender", style: TextStyle(fontSize: 16)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {},
                            child: const Text("Men",
                                style: TextStyle(fontSize: 14))),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {},
                            child: const Text("Women",
                                style: TextStyle(fontSize: 14))),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {},
                            child: const Text("Kids",
                                style: TextStyle(fontSize: 14)))
                      ]),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text("Category", style: TextStyle(fontSize: 16)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {},
                            child: const Text("Shoes",
                                style: TextStyle(fontSize: 14))),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {},
                            child: const Text("Apparreis",
                                style: TextStyle(fontSize: 14))),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {},
                            child: const Text("Accessori",
                                style: TextStyle(fontSize: 14)))
                      ]),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text("price", style: TextStyle(fontSize: 16)),
                Slider(
                  secondaryTrackValue: 200,
                  max: 500,
                  value: value,
                  label: value.toString(),
                  thumbColor: Colors.black,
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  onChanged: (double value) {},
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text("Brand", style: TextStyle(fontSize: 16)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Image.asset(
                              "images/iv.jpg",
                              width: 50,
                              height: 50,
                            )),
                        InkWell(
                            onTap: () {},
                            child: Image.asset(
                              "images/iv.jpg",
                              width: 50,
                              height: 50,
                            )),
                        InkWell(
                            onTap: () {},
                            child: Image.asset(
                              "images/iv.jpg",
                              width: 50,
                              height: 50,
                            )),
                        InkWell(
                            onTap: () {},
                            child: Image.asset(
                              "images/iv.jpg",
                              width: 50,
                              height: 50,
                            )),
                      ]),
                ),
                const SizedBox(
                  height: 7,
                ),
              ]),
        );
      },
    );
  }
}
