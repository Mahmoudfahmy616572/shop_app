import 'package:flutter/material.dart';
import 'package:shop_app/models/sneakrs_model.dart';
import 'package:shop_app/services/helper.dart';

class ProductNotifire extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _shoesSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;
  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoesSize => _shoesSizes;
  set shoesSize(List<dynamic> newShoeSize) {
    _shoesSizes = newShoeSize;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoesSizes.length; i++) {
      if (i == index) {
        _shoesSizes[i]['isSelected'] = !_shoesSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  late Future<Sneakers> sneaker;

  void getMale() {
    male = Helper().getMaleSneakers();
  }

  void getFemale() {
    female = Helper().getFemaleSneakers();
  }

  void getkids() {
    kids = Helper().getKidsSneakers();
  }

  void getShoes(String category, String id) {
    if (category == "Men's Running") {
      sneaker = Helper().getMaleSneakersById(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getFemaleSneakersById(id);
    } else {
      sneaker = Helper().getKidsSneakersById(id);
    }
  }
}
