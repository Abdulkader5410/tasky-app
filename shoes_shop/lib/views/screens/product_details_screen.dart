import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shose_shop/controllers/fav_provider.dart';
import 'package:shose_shop/controllers/product_details_provider.dart';
import 'package:shose_shop/fav.dart';
import 'package:shose_shop/models/cart.dart';
import 'package:shose_shop/models/sneakers_model.dart';
import 'package:shose_shop/services/helper.dart';
import 'package:shose_shop/views/screens/fav_screen.dart';


class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {super.key, required this.category, required this.id});

  final String category;
  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();

  late Future<Sneakers> sneaker;
  Box? boxCart = Hive.box("box_cart");

  Future<void> _creatCart(Cart cart) async {
    await boxCart!.add(cart);
  }

  // Box? boxFav = Hive.box("box_fav");

  getShoes() {
    if (widget.category == "Men's Shoes") {
      sneaker = Helper().getMenSneakersById(widget.id);
    } else if (widget.category == "Women's Shoes") {
      sneaker = Helper().getWomenSneakersById(widget.id);
    } else if (widget.category == "Kids's Shoes") {
      sneaker = Helper().getKidsSneakersById(widget.id);
    }
  }

  // List<dynamic> favList = [];
  // List<dynamic> idList = [];

  @override
  void initState() {
    getShoes();
    super.initState();
  }

  String? selectSize;

  @override
  Widget build(BuildContext context) {
    var favProvider = Provider.of<FavProvider>(context);

    favProvider.getFavList;



    return Scaffold(
        backgroundColor: Colors.grey,
        body: FutureBuilder<Sneakers>(
            future: sneaker,
            builder: (context, snapshot) {
              return Consumer<ProDetScrernNotifier>(
                builder: (context, proDetScrernNotifier, child) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error :  ${snapshot.error}");
                  } else {
                    final sneaker = snapshot.data;
                    return WillPopScope(
                      onWillPop: () {
                        print(proDetScrernNotifier.shoesSize);
                        return Future(() => true);
                      },
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                            Container(
                              color: Colors.grey,
                              height: MediaQuery.sizeOf(context).height * 0.25,
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: (value) {
                                  proDetScrernNotifier.activePage = value;
                                },
                                itemCount: sneaker!.imageUrl.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CachedNetworkImage(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.22,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          fit: BoxFit.contain,
                                          imageUrl: sneaker.imageUrl[index]),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              color: Colors.grey,
                              height: MediaQuery.sizeOf(context).height * 0.02,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(
                                    sneaker.imageUrl.length,
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.01,
                                            width:
                                                proDetScrernNotifier
                                                            .activePage !=
                                                        index
                                                    ? MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.01
                                                    : MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.03,
                                            decoration: BoxDecoration(
                                                color: proDetScrernNotifier
                                                            .activePage !=
                                                        index
                                                    ? Colors.white
                                                    : Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        )),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.01),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30))),
                                height: MediaQuery.sizeOf(context).height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          sneaker.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (favProvider.idList
                                                  .contains(sneaker.id)) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FavScreen(),
                                                    ));
                                              } else {
                                                favProvider.creatFav(Fav(
                                                    key: "favKey",
                                                    id: sneaker.id,
                                                    name: sneaker.name,
                                                    category: sneaker.catygory,
                                                    price: sneaker.price,
                                                    imageUrl:
                                                        sneaker.imageUrl[0]));
                                              }
                                            },
                                            icon: favProvider.idList
                                                    .contains(sneaker.id)
                                                ? const Icon(
                                                    Icons.favorite_outlined)
                                                : const Icon(
                                                    Icons.favorite_border)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(sneaker.catygory,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${sneaker.price}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.35),
                                        const Text("Colors"),
                                        SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.02),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.red),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.02),
                                              const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      Colors.green),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.02),
                                              const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.blue),
                                            ]),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text("Select a size"),
                                        SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.05),
                                        const Text("View size guide",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.05,
                                      width: MediaQuery.sizeOf(context).width,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: proDetScrernNotifier
                                            .shoesSize.length,
                                        itemBuilder: (context, index) {
                                          final currSizes = proDetScrernNotifier
                                              .shoesSize[index];
                                          return Row(
                                            children: [
                                              Radio(
                                                activeColor: Colors.red,
                                                value: currSizes['size'],
                                                groupValue: selectSize,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectSize = value;
                                                  });
                                                },
                                              ),
                                              Text(currSizes['size']),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.01),
                                    Text(
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        sneaker.title),
                                    Text(
                                        maxLines: 5,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                        sneaker.description),
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.02,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.07,
                                      width: MediaQuery.sizeOf(context).width,
                                      child: MaterialButton(
                                        color: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        onPressed: () {
                                          _creatCart(Cart(
                                              key: "cartKey",
                                              id: sneaker.id,
                                              name: sneaker.name,
                                              category: sneaker.catygory,
                                              price: sneaker.price,
                                              size: selectSize,
                                              quantity: 0,
                                              imageUrl: sneaker.imageUrl[0]));
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Add to cart",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Icon(
                                              Icons.add_shopping_cart_outlined,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            }));
  }
}
