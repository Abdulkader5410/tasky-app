import 'package:hive/hive.dart';

part 'fav.g.dart';

@HiveType(typeId: 1)
class Fav {

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
  String? imageUrl;

  Fav(
      {required this.key,
      required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imageUrl});
}
