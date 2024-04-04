import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shose_shop/controllers/fav_provider.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => FavScreenState();
}

class FavScreenState extends State<FavScreen> {
  List<dynamic> favList = [];

  @override
  Widget build(BuildContext context) {
    var favProvider = Provider.of<FavProvider>(context);
    favList = favProvider.getAllFav();

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.05,
        ),
        Container(
          margin: const EdgeInsets.only(right: 12, left: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Favorites",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.76,
          width: MediaQuery.sizeOf(context).width,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: favList.length,
            itemBuilder: (context, index) {
              final data = favList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slidable(
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(15),
                      autoClose: true,
                      flex: 1,
                      onPressed: (context) {
                        favProvider.deleteFav(data['key'], data);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: CupertinoIcons.heart_slash,
                      spacing: 10,
                      label: 'Delete',
                    ),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.01),
                  ]),
                  key: const ValueKey(0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    color: Colors.white,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.15,
                      width: MediaQuery.sizeOf(context).width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Stack(children: [
                            Icon(Icons.info),
                          ]),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.15,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data['name'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    data['category'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "\$${data['price']}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.15,
                            width: MediaQuery.sizeOf(context).width * 0.1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01,
                                  ),
                                  const Icon(Icons.favorite,
                                      color: Colors.black),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
