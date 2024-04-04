import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shose_shop/controllers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  List<dynamic> cartList = [];

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartList = cartProvider.getAllCart();

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.05,
        ),
        Container(
          margin: const EdgeInsets.only(right: 12, left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.black,
                onPressed: () {},
                child: const Row(children: [
                  Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.check, color: Colors.white, size: 25),
                ]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.76,
          width: MediaQuery.sizeOf(context).width,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: cartList.length,
            itemBuilder: (context, index) {
              final data = cartList[index];
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
                        cartProvider.deleteCart(data['key'], data);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
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
                            // CachedNetworkImage(
                            //     fit: BoxFit.fill,
                            //     height:
                            //         MediaQuery.sizeOf(context).height * 0.15,
                            //     width: MediaQuery.sizeOf(context).width * 0.3,
                            //     errorWidget: (context, url, error) {
                            //       return const SizedBox();
                            //     },
                            //     imageUrl: data['imageUrl']),
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
                                  Text(
                                    "Size : ${data['size']}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ),
                          Consumer<CartProvider>(
                            builder: (context, cartPro, child) {
                              return SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                                width: MediaQuery.sizeOf(context).width * 0.15,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          cartPro.increamentCart(data['id']);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: const Icon(Icons.add,
                                                color: Colors.white)),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.015),
                                      const Center(
                                        child: Text(
                                          "cartPro",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.015),
                                      GestureDetector(
                                        onTap: () {
                                          cartPro.decreamentCart(data['id']);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: const Icon(
                                                CupertinoIcons.minus)),
                                      ),
                                    ]),
                              );
                            },
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
