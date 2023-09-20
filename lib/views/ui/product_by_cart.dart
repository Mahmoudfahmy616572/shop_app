import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/product_provider.dart';
import 'package:shop_app/views/shared/Latest_shoes.dart';
import 'package:shop_app/views/shared/appStyle.dart';
import 'package:shop_app/views/shared/category_BTN.dart';
import 'package:shop_app/views/shared/custom_spacer.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  List<String> brand = [
    'assets/images/adidas.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
  ];

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifire>(context);
    productProvider.getMale();
    productProvider.getFemale();
    productProvider.getkids();
    return Scaffold(
      backgroundColor: const Color(0xffE2E2E2),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/top_image.png'),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                filter();
                              },
                              child: const Icon(
                                Ionicons.menu,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    TabBar(
                      padding: EdgeInsets.zero,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      labelColor: Colors.white,
                      labelStyle: appStyle(24, FontWeight.bold, Colors.white),
                      unselectedLabelColor: Colors.grey.withOpacity(0.4),
                      tabs: const <Widget>[
                        Tab(
                          text: 'Men shoes',
                        ),
                        Tab(
                          text: 'Women shoes',
                        ),
                        Tab(
                          text: 'Kids shoes',
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 16,
                  right: 12),
              child: TabBarView(controller: _tabController, children: [
                LatestShoes(male: productProvider.male),
                LatestShoes(male: productProvider.female),
                LatestShoes(male: productProvider.kids),
              ]),
            )
          ])),
    );
  }

  Future<dynamic> filter() {
    double value = 100;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Colors.white54,
        context: context,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.84,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: 5,
                  decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(children: [
                    const CustomSapcer(),
                    Text(
                      "Filter",
                      style: appStyle(40, FontWeight.bold, Colors.black),
                    ),
                    const CustomSapcer(),
                    Text(
                      "Gender",
                      style: appStyle(20, FontWeight.bold, Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        CategoryBTN(
                          lable: 'Men',
                          buttonClr: Colors.black,
                        ),
                        CategoryBTN(
                          lable: 'Women',
                          buttonClr: Colors.grey,
                        ),
                        CategoryBTN(
                          lable: 'Kids',
                          buttonClr: Colors.grey,
                        ),
                      ],
                    ),
                    const CustomSapcer(),
                    Text(
                      "Category",
                      style: appStyle(20, FontWeight.bold, Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        CategoryBTN(
                          lable: 'Shoes',
                          buttonClr: Colors.black,
                        ),
                        CategoryBTN(
                          lable: 'Apperrels',
                          buttonClr: Colors.grey,
                        ),
                        CategoryBTN(
                          lable: 'Accessories',
                          buttonClr: Colors.grey,
                        ),
                      ],
                    ),
                    const CustomSapcer(),
                    Text(
                      "Price",
                      style: appStyle(20, FontWeight.bold, Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Slider(
                        value: value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.grey,
                        max: 500,
                        divisions: 50,
                        label: value.toString(),
                        onChanged: (double value) {}),
                    const CustomSapcer(),
                    Text(
                      "Brand",
                      style: appStyle(20, FontWeight.bold, Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 80,
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: brand.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: Image.asset(
                                  brand[index],
                                  height: 60,
                                  width: 80,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ))
                  ]),
                )
              ]),
            ));
  }
}
