// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/product_provider.dart';
import 'package:shop_app/models/sneakrs_model.dart';
import 'package:shop_app/views/shared/appStyle.dart';
import 'package:shop_app/views/shared/newShoes.dart';
import 'package:shop_app/views/shared/product_cart.dart';
import 'package:shop_app/views/ui/product_by_cart.dart';
import 'package:shop_app/views/ui/product_page.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifire>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: FutureBuilder<List<Sneakers>>(
                  future: _male,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error${snapshot.error}");
                    } else {
                      final male = snapshot.data;
                      return ListView.builder(
                          itemCount: male!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final shoe = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                productNotifier.shoesSize = shoe.sizes;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductPage(
                                            id: shoe.id,
                                            category: shoe.category)));
                              },
                              child: ProductCart(
                                category: shoe.category,
                                id: shoe.id,
                                price: '\$${shoe.price}',
                                name: shoe.name,
                                image: shoe.imageUrl[0],
                              ),
                            );
                          });
                    }
                  })),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest shoes',
                    style: appStyle(24, FontWeight.bold, Colors.black),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductByCart(
                                  tabIndex: tabIndex,
                                ),
                              ));
                        },
                        child: Text(
                          'Show all',
                          style: appStyle(16, FontWeight.w500, Colors.black),
                        ),
                      ),
                      const Icon(
                        AntIcons.caretRightFilled,
                        size: 20,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: FutureBuilder<List<Sneakers>>(
                      future: _male,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error${snapshot.error}");
                        } else {
                          final male = snapshot.data;
                          return ListView.builder(
                              itemCount: male!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final shoe = snapshot.data![index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: NewShoes(
                                    imageUrl: shoe.imageUrl[1],
                                  ),
                                );
                              });
                        }
                      })),
            ],
          )
        ],
      ),
    );
  }
}
