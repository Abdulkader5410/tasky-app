import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.name,
      required this.id,
      required this.image,
      required this.price,
      required this.category});

  final String name;
  final String id;
  final String image;
  final String price;
  final String category;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: MediaQuery.sizeOf(context).height * 0.2,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CachedNetworkImage(
                  //   width: MediaQuery.sizeOf(context).width * 0.2,
                  //   height: MediaQuery.sizeOf(context).width * 0.2,
                  //   imageUrl: widget.image,
                  //   placeholder: (context, url) =>
                  //       const CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => const SizedBox(),
                  // ),
                  Icon(
                    Icons.info,
                    size: 100,
                  )
                ],
              ),
              Text(
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                widget.name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                widget.category,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.price,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  const Text(
                    "\t\t\t\t\t\tColors\t\t",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: ChoiceChip(
                      label: Text(" "),
                      selected: true,
                      selectedColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
