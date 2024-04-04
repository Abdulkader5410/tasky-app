import 'package:flutter/material.dart';

class NewShoes extends StatelessWidget {
  final String imageUrl;
  const NewShoes({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        width: MediaQuery.sizeOf(context).width * 0.227,
        height: MediaQuery.sizeOf(context).height * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CachedNetworkImage(
              
            //   width: MediaQuery.sizeOf(context).width * 0.15,
            //   height: MediaQuery.sizeOf(context).width * 0.15,
            //   imageUrl: /*imageUrl*/ "images/iv.jpg",
            //   placeholder: (context, url) => const CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => SizedBox(),
            // ),
            Icon(Icons.info , size: 50,)
          ],
        ),
      ),
    );
  }
}
