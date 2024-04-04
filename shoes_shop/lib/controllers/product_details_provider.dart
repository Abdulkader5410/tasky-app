import 'package:flutter/material.dart';

class ProDetScrernNotifier extends ChangeNotifier {
  int _activePage = 0;

  int get activePage => _activePage;

  set activePage(int newInex) {
    _activePage = newInex;
    notifyListeners();
  }

  List<dynamic> _shoesSize = [];

  List<dynamic> get shoesSize => _shoesSize;

  set shoesSize(List<dynamic> newShoesSize) {
    _shoesSize = newShoesSize;
    notifyListeners();
  }

  List<dynamic> _idList = [];
  List<dynamic> get idList => _idList;
  set idList(List<dynamic> newIdList) {
    _idList = newIdList;
    notifyListeners();
  }
}
