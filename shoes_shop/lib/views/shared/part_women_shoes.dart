import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shose_shop/controllers/product_details_provider.dart';
import 'package:shose_shop/models/sneakers_model.dart';
import 'package:shose_shop/views/screens/all_category_screen.dart';
import 'package:shose_shop/views/screens/product_details_screen.dart';
import 'package:shose_shop/views/shared/product_card.dart';
import 'new_shoes.dart';

class PartWomenShoes extends StatelessWidget {
  const PartWomenShoes({
    super.key,
    required this.women,
  });

  final Future<List<Sneakers>> women;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProDetScrernNotifier>(context);

    return Column(children: [
      SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.4,
          child: FutureBuilder<List<Sneakers>>(
            future: women,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error :  ${snapshot.error}");
              } else {
                final female = snapshot.data;
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: female!.length,
                    itemBuilder: (context, index) {
                      final shoe = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          productNotifier.shoesSize = shoe.sizeList;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      category: shoe.catygory, id: shoe.id)));
                        },
                        child: ProductCard(
                            name: shoe.name,
                            id: shoe.id,
                            image: shoe.imageUrl[0],
                            price: "\$${shoe.price}",
                            category: shoe.catygory),
                      );
                    });
              }
            },
          )),
      Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Latest Shoes",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings:
                          const RouteSettings(name: "curr_index", arguments: 1),
                      builder: (context) => const AllCategScreen(),
                    ));
              },
              child: const Row(
                children: [
                  Text("Show all"),
                  Icon(Icons.arrow_right),
                ],
              ),
            )
          ],
        ),
      ),
      SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.16,
          child: FutureBuilder<List<Sneakers>>(
            future: women,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error :  ${snapshot.error}");
              } else {
                final female = snapshot.data;
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: female!.length,
                    itemBuilder: (context, index) {
                      final shoe = snapshot.data![index];
                      return NewShoes(imageUrl: shoe.imageUrl[1]);
                    });
              }
            },
          )),
    ]);
  }
}
