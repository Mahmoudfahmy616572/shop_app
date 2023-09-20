// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MainPageProvider with ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageIndex(int newIndex) {
    _pageIndex = newIndex;

    notifyListeners();
  }
}
