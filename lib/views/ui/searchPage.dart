// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_app/views/shared/appStyle.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'SearchPage',
        style: appStyle(40, FontWeight.bold, Colors.black),
      )),
    );
  }
}
