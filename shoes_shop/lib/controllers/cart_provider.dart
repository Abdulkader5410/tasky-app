import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shose_shop/models/cart.dart';

class CartProvider extends ChangeNotifier {
  final cartBox = Hive.box("box_cart");

  List<dynamic> _idList = [];
  List<dynamic> _cartList = [];

  List<dynamic> get idList => _idList;
  List<dynamic> get cartList => _cartList;

  set idList(List<dynamic> newIdList) {
    _idList = newIdList;
    notifyListeners();
  }

  set cartList(List<dynamic> newCartList) {
    _cartList = newCartList;
    notifyListeners();
  }

  getCartList() {
    final fav = cartBox.keys.map((key) {
      final item = cartBox.get(key);

      return {
        "key": key,
        "id": item.id,
      };
    }).toList();

    cartList = fav.toList();
    idList = cartList.map((item) => item['id']).toList();
    notifyListeners();
  }

  List<dynamic> getAllCart() {
    List<dynamic> allCart = [];
    final cart = cartBox.keys.map((key) {
      Cart item = cartBox.get(key);

      return {
        "key": key,
        "id": item.id,
        "name": item.name,
        "category": item.category,
        "price": item.price,
        "size": item.size,
        "quantity": item.quantity,
        "imageUrl": item.imageUrl
      };
    }).toList();

    allCart = cart.reversed.toList();

    return allCart;
  }

  Future<void> creatCart(Cart cart) async {
    await cartBox.add(cart);
    getCartList();
    notifyListeners();
  }

  Future<void> deleteCart(int key, final data) async {
    await cartBox.delete(key);
    idList.removeWhere((element) => element == data['id']);
    notifyListeners();
  }

  increamentCart(String cartId) {
    cartList.firstWhere(
      (element) {
        return element.id == cartId;
      },
      
    );
  }

  decreamentCart(String cartId) {}
}
