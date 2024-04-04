import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart {

  @HiveField(0)
  String? key;
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? category;
  @HiveField(4)
  String? price;
  @HiveField(5)
  String? size;
  @HiveField(6)
  int? quantity;
  @HiveField(7)
  String? imageUrl;

  Cart(
      {required this.key,
      required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.size,
      required this.quantity,
      required this.imageUrl});
}
