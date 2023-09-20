import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/cart_provider.dart';
import 'package:shop_app/controllers/favourite_provider.dart';
import 'package:shop_app/controllers/mainPage_Provider.dart';
import 'package:shop_app/controllers/product_provider.dart';
import 'package:shop_app/mainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) {
        return ProductNotifire();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return MainPageProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return FavouritProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return CartProvider();
      },
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
