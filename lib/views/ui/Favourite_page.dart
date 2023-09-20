// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/favourite_provider.dart';
import 'package:shop_app/mainScreen.dart';
import 'package:shop_app/models/constant.dart';
import 'package:shop_app/views/shared/appStyle.dart';

class FavouritPage extends StatefulWidget {
  const FavouritPage({super.key});

  @override
  State<FavouritPage> createState() => _FavouritPageState();
}

final _favBox = Hive.box('fav_box');
_deleteFav(int key) async {
  await _favBox.delete(key);
}

class _FavouritPageState extends State<FavouritPage> {
  @override
  Widget build(BuildContext context) {
    var favouritesProvider = Provider.of<FavouritProvider>(context);
    favouritesProvider.getAllData();

    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/top_image.png",
                  ),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'My Favourites',
              style: appStyle(27, FontWeight.bold, Colors.white),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 100),
                itemCount: favouritesProvider.fav.length,
                itemBuilder: (BuildContext context, int index) {
                  final shoe = favouritesProvider.fav[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0, 1),
                                  spreadRadius: 5,
                                  blurRadius: 0.3)
                            ]),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: CachedNetworkImage(
                                      imageUrl: shoe['imageUrl'],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12, left: 20),
                                    child: Column(children: [
                                      Text(
                                        shoe["name"],
                                        style: appStyle(
                                            16, FontWeight.bold, Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        shoe["category"],
                                        style: appStyle(
                                            14, FontWeight.w600, Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${shoe["price"]}',
                                            style: appStyle(16, FontWeight.w600,
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _deleteFav(shoe['key']);
                                      ids.removeWhere(
                                          (element) => element == shoe['id']);
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen()));
                                  },
                                  child: const Icon(Ionicons.heart_dislike),
                                ),
                              )
                            ]),
                      ),
                    ),
                  );
                }))
      ]),
    ));
  }
}
