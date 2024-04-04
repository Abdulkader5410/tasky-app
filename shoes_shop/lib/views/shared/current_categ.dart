import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/sneakers_model.dart';

class CurrentCateg extends StatelessWidget {
  const CurrentCateg({super.key, required this.currentCateg});

  final Future<List<Sneakers>> currentCateg;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
      future: currentCateg,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error :  ${snapshot.error}");
        } else {
          final curr = snapshot.data;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            scrollDirection: Axis.vertical,
            itemCount: curr!.length,
            itemBuilder: (context, index) {
              final shoe = snapshot.data![index];

              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0, 0),
                            color: Colors.grey)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.2,
                              imageUrl: shoe.imageUrl[0],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ],
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          shoe.name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          shoe.catygory,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${shoe.price}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ]),
                ),
              );
            },
          );
        }
      },
    );
  }
}
