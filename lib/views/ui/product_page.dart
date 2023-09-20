import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/favourite_provider.dart';
import 'package:shop_app/controllers/product_provider.dart';
import 'package:shop_app/models/constant.dart';
import 'package:shop_app/models/sneakrs_model.dart';
import 'package:shop_app/services/helper.dart';
import 'package:shop_app/views/shared/appStyle.dart';
import 'package:shop_app/views/ui/Favourite_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  late Future<Sneakers> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFemaleSneakersById(widget.id);
    } else {
      _sneaker = Helper().getKidsSneakersById(widget.id);
    }
  }

  Future<void> _creatCart(Map<String, dynamic> newcart) async {
    await _cartBox.add(newcart);
  }

  final _favBox = Hive.box('fav_box');

  getFavourite() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        'key': key,
        'id': item['id'],
      };
    }).toList();
    favs = favData.toList();
    ids = favs.map((item) => item['id']).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    var favouritProvider = Provider.of<FavouritProvider>(context, listen: true);
    favouritProvider.getFavourite();
    return Scaffold(body: Consumer<ProductNotifire>(
      builder: (context, productNotifire, child) {
        return FutureBuilder<Sneakers>(
            future: _sneaker,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              } else if (snapshot.hasError) {
                return Text("Error${snapshot.error}");
              } else {
                final sneaker = snapshot.data;
                return CustomScrollView(slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leadingWidth: 0,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              productNotifire.shoesSize.clear();
                            },
                            child:
                                const Icon(Ionicons.close, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: null,
                            child: const Icon(
                              Ionicons.ellipsis_horizontal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                    snap: false,
                    floating: true,
                    backgroundColor: Colors.transparent,
                    expandedHeight: MediaQuery.of(context).size.height,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.49,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                                controller: pageController,
                                itemCount: sneaker!.imageUrl.length,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (page) {
                                  productNotifire.activePage = page;
                                },
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.39,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          right: 20,
                                          child: Consumer<FavouritProvider>(
                                            builder: (context, favouritProvider,
                                                child) {
                                              return GestureDetector(
                                                  onTap: () async {
                                                    if (favouritProvider.ids
                                                        .contains(widget.id)) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const FavouritPage()));
                                                    } else {
                                                      favouritProvider
                                                          .createFav({
                                                        "id": sneaker.id,
                                                        "name": sneaker.name,
                                                        "price": sneaker.price,
                                                        "imageUrl":
                                                            sneaker.imageUrl[0],
                                                        "category":
                                                            sneaker.category,
                                                      });
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: favouritProvider.ids
                                                          .contains(sneaker.id)
                                                      ? const Icon(
                                                          AntIcons.heartFilled)
                                                      : const Icon(AntIcons
                                                          .heartOutlined));
                                            },
                                          )),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List<Widget>.generate(
                                                sneaker.imageUrl.length,
                                                (index) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4),
                                                      child: CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                              productNotifire
                                                                          .activePage !=
                                                                      index
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black),
                                                    )),
                                          )),
                                    ],
                                  );
                                })),
                        Positioned(
                            bottom: 30,
                            height: MediaQuery.of(context).size.height * 0.645,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30)),
                              child: Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height *
                                      0.645,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SingleChildScrollView(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              sneaker.name,
                                              style: appStyle(
                                                  40,
                                                  FontWeight.bold,
                                                  Colors.black),
                                            ),
                                            Row(
                                              children: [
                                                Text(sneaker.name,
                                                    style: appStyle(
                                                        20,
                                                        FontWeight.w500,
                                                        Colors.grey)),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                RatingBar.builder(
                                                  onRatingUpdate: (rating) {},
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                  initialRating: 4,
                                                  minRating: 12,
                                                  itemCount: 5,
                                                  allowHalfRating: true,
                                                  itemSize: 22,
                                                  direction: Axis.horizontal,
                                                  itemBuilder: ((context, _) =>
                                                      const Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("\$${sneaker.price}",
                                                    style: appStyle(
                                                        20,
                                                        FontWeight.w600,
                                                        Colors.black)),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Colors",
                                                      style: appStyle(
                                                          15,
                                                          FontWeight.w600,
                                                          Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Select sizes',
                                                  style: appStyle(
                                                      20,
                                                      FontWeight.w600,
                                                      Colors.black),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'View size guide',
                                                  style: appStyle(
                                                      20,
                                                      FontWeight.w600,
                                                      Colors.grey),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: productNotifire
                                                    .shoesSize.length,
                                                itemBuilder: (context, index) {
                                                  final sizes = productNotifire
                                                      .shoesSize[index];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: ChoiceChip(
                                                      label: Text(
                                                        sizes['size'],
                                                        style: appStyle(
                                                            18,
                                                            FontWeight.w500,
                                                            sizes['isSelected']
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                      selectedColor:
                                                          Colors.black,
                                                      selected: productNotifire
                                                              .shoesSize[index]
                                                          ['isSelected'],
                                                      onSelected: (newState) {
                                                        if (productNotifire
                                                            .sizes
                                                            .contains(sizes[
                                                                'size'])) {
                                                          productNotifire.sizes
                                                              .remove(sizes[
                                                                  'size']);
                                                        } else {
                                                          productNotifire.sizes
                                                              .add(sizes[
                                                                  'size']);
                                                        }
                                                        productNotifire
                                                            .toggleCheck(index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60)),
                                                      side: const BorderSide(
                                                          color: Colors.black,
                                                          width: 1,
                                                          style: BorderStyle
                                                              .solid),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                                indent: 10,
                                                endIndent: 10,
                                                color: Colors.black),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(
                                                sneaker.title,
                                                style: appStyle(
                                                    26,
                                                    FontWeight.w700,
                                                    Colors.black),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              child: Text(
                                                sneaker.description,
                                                textAlign: TextAlign.justify,
                                                style: appStyle(
                                                    14,
                                                    FontWeight.normal,
                                                    Colors.black),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    _creatCart({
                                                      'id': sneaker.id,
                                                      "name": sneaker.name,
                                                      'category':
                                                          sneaker.category,
                                                      "sizes": sneaker.sizes,
                                                      "imageUrl":
                                                          sneaker.imageUrl[0],
                                                      'price': sneaker.price,
                                                      'qty': 1
                                                    });
                                                    productNotifire.sizes
                                                        .clear();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Container(
                                                      height: 50,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Center(
                                                          child: Text(
                                                        'add to bag',
                                                        style: appStyle(
                                                            18,
                                                            FontWeight.w700,
                                                            Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  )),
                            ))
                      ],
                    )),
                  ),
                ]);
              }
            });
      },
    ));
  }
}
