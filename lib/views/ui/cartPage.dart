// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/cart_provider.dart';
import 'package:shop_app/mainScreen.dart';
import 'package:shop_app/views/shared/CheckOut_btn.dart';
import 'package:shop_app/views/shared/appStyle.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();

    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "my Cart",
                        style: appStyle(35, FontWeight.bold, Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView.builder(
                        itemCount: cartProvider.cart.length,
                        itemBuilder: (context, index) {
                          final data = cartProvider.cart[index];

                          return Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        onPressed: (context) => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen()))
                                        },
                                        backgroundColor:
                                            const Color(0xFF000000),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade500,
                                                spreadRadius: 5,
                                                blurRadius: 0.3,
                                                offset: const Offset(0, 1))
                                          ]),
                                      child: Stack(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          data['imageUrl'],
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20, left: 12),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data['name'],
                                                            style: appStyle(
                                                                16,
                                                                FontWeight.bold,
                                                                Colors.black),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(data["category"],
                                                              style: appStyle(
                                                                  22,
                                                                  FontWeight
                                                                      .w600,
                                                                  Colors.grey)),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "\$${data["price"]}",
                                                                style: appStyle(
                                                                    22,
                                                                    FontWeight
                                                                        .w600,
                                                                    Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                width: 40,
                                                              ),
                                                              Text(
                                                                "Size",
                                                                style: appStyle(
                                                                    22,
                                                                    FontWeight
                                                                        .w600,
                                                                    Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                "33",
                                                                style: appStyle(
                                                                    18,
                                                                    FontWeight
                                                                        .w600,
                                                                    Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          )
                                                        ]),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          16))),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                cartProvider
                                                                    .increment();
                                                              },
                                                              child: const Icon(
                                                                Ionicons
                                                                    .add_circle,
                                                                size: 20,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                          Text(
                                                              data['qty']
                                                                  .toString(),
                                                              style: appStyle(
                                                                16,
                                                                FontWeight.w600,
                                                                Colors.black,
                                                              )),
                                                          InkWell(
                                                              onTap: () {
                                                                cartProvider
                                                                    .decrement();
                                                              },
                                                              child: const Icon(
                                                                Ionicons
                                                                    .remove_circle,
                                                                size: 20,
                                                                color:
                                                                    Colors.grey,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Positioned(
                                              bottom: -2,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.black),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    cartProvider.cartDelete(
                                                        data['key']);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MainScreen()));
                                                  },
                                                  child: const Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      )),
                                ),
                              ));
                        }),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CheckOutBtn(
                  lable: "Proceed to Checkout",
                  onTap: () {},
                ),
              )
            ],
          ),
        ));
  }

  void doNothing(BuildContext context) {}
}
