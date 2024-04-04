import 'package:flutter/material.dart';

class MainScrernNotifier with ChangeNotifier {
  int _pageIndex = 2;
  int get pageIndex => _pageIndex;
  void changIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}
