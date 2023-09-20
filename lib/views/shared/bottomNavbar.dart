// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/mainPage_Provider.dart';
import 'package:shop_app/views/shared/BottomNav.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
        builder: (context, mainPageProvider, child) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(12)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            BottomNav(
                icon: mainPageProvider.pageIndex == 0
                    ? Ionicons.home
                    : Ionicons.home_outline,
                onTap: () {
                  mainPageProvider.pageIndex = 0;
                }),
            BottomNav(
                icon: mainPageProvider.pageIndex == 1
                    ? Ionicons.search_sharp
                    : Ionicons.search,
                onTap: () {
                  mainPageProvider.pageIndex = 1;
                }),
            BottomNav(
                icon: mainPageProvider.pageIndex == 2
                    ? Ionicons.heart
                    : Ionicons.heart_circle_outline,
                onTap: () {
                  mainPageProvider.pageIndex = 2;
                }),
            BottomNav(
                icon: mainPageProvider.pageIndex == 3
                    ? Ionicons.cart
                    : Ionicons.cart_outline,
                onTap: () {
                  mainPageProvider.pageIndex = 3;
                }),
            BottomNav(
                icon: mainPageProvider.pageIndex == 4
                    ? Ionicons.person
                    : Ionicons.person_outline,
                onTap: () {
                  mainPageProvider.pageIndex = 4;
                }),
          ]),
        ),
      ));
    });
  }
}
