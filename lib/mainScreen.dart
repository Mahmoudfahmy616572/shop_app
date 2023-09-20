// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/mainPage_Provider.dart';
import 'package:shop_app/views/shared/bottomNavbar.dart';
import 'package:shop_app/views/ui/Favourite_page.dart';
import 'package:shop_app/views/ui/cartPage.dart';
import 'package:shop_app/views/ui/homePage.dart';
import 'package:shop_app/views/ui/profilePage.dart';
import 'package:shop_app/views/ui/searchPage.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const FavouritPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
        builder: (context, mainPageProvider, child) {
      return Scaffold(
        body: pageList[mainPageProvider.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
