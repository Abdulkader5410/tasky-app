import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../fav.dart';

class FavProvider extends ChangeNotifier {
  final favBox = Hive.box("box_fav");

  List<dynamic> _idList = [];
  List<dynamic> _favList = [];

  List<dynamic> get idList => _idList;
  List<dynamic> get favList => _favList;

  set idList(List<dynamic> newIdList) {
    _idList = newIdList;
    notifyListeners();
  }

  set favList(List<dynamic> newFavList) {
    _favList = newFavList;
    notifyListeners();
  }

  getFavList() {
    final fav = favBox.keys.map((key) {
      final item = favBox.get(key);

      return {
        "key": key,
        "id": item.id,
      };
    }).toList();

    favList = fav.toList();
    idList = favList.map((item) => item['id']).toList();
    notifyListeners();
  }

  List<dynamic> getAllFav() {
    List<dynamic> allFav = [];
    final fav = favBox.keys.map((key) {
      final item = favBox.get(key);

      return {
        "key": key,
        "id": item.id,
        "name": item.name,
        "category": item.category,
        "price": item.price,
        "imageUrl": item.imageUrl
      };
    }).toList();

    allFav = fav.reversed.toList();
    return allFav;
  }

  Future<void> creatFav(Fav fav) async {
    await favBox.add(fav);
    getFavList();
    notifyListeners();
  }

  Future<void> deleteFav(int key, final data) async {
    await favBox.delete(key);
    idList.removeWhere((element) => element == data['id']);
    notifyListeners();
  }
}
