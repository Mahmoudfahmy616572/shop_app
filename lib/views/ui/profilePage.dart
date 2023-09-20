// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_app/views/shared/appStyle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'ProfilePage',
        style: appStyle(40, FontWeight.bold, Colors.black),
      )),
    );
  }
}
