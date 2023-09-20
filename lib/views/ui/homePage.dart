// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/product_provider.dart';
import 'package:shop_app/views/shared/appStyle.dart';
import 'package:shop_app/views/shared/home_Widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifire>(context);
    productProvider.getFemale();
    productProvider.getMale();
    productProvider.getkids();
    return Scaffold(
      backgroundColor: const Color(0xffE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/top_image.png'),
                      fit: BoxFit.fill)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Athletices shoes ',
                      style: appStyleWithHt(
                          42, FontWeight.bold, Colors.white, 1.5),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Collection',
                          style: appStyleWithHt(
                              42, FontWeight.bold, Colors.white, 1.5),
                        ),
                      ],
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
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.265),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    HomeWidget(
                      male: productProvider.male,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      male: productProvider.female,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      male: productProvider.kids,
                      tabIndex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
