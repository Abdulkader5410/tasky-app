import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Sneakers>.from(jsonData.map((x) => Sneakers.fromJson(x)));
}

String sneakersToJson(List<Sneakers> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Sneakers {
  final String id;
  final String name;
  final String catygory;
  final String oldPrice;
  final String price;
  final String title;
  final String description;
  final List<String> imageUrl;
  final List<dynamic> sizeList;

  Sneakers({
    required this.id,
    required this.name,
    required this.catygory,
    required this.oldPrice,
    required this.price,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.sizeList,
  });

  factory Sneakers.fromJson(Map<String, dynamic> json) =>  Sneakers(
        id: json["id"],
        name: json["name"],
        catygory: json["catyory"],
        oldPrice: json["oldPrice"],
        price: json["price"],
        title: json["title"],
        description: json["description"],
        imageUrl:  List<String>.from(json["imageUrl"].map((x) => x)),
        sizeList:  List<dynamic>.from(json["sizeList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "catyory": catygory,
        "oldPrice": oldPrice,
        "price": price,
        "title": title,
        "description": description,
        "imageUrl":  List<dynamic>.from(imageUrl.map((x) => x)),
        "sizes":  List<dynamic>.from(sizeList.map((x) => x.toJson())),
      };
}
