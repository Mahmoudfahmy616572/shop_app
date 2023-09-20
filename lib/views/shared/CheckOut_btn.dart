// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_app/views/shared/appStyle.dart';

class CheckOutBtn extends StatelessWidget {
  const CheckOutBtn({super.key, required this.lable, required this.onTap});
  final String lable;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              lable,
              style: appStyle(20, FontWeight.w700, Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
