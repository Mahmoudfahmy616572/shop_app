// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_app/views/shared/appStyle.dart';

class CategoryBTN extends StatelessWidget {
  const CategoryBTN(
      {super.key, this.onPress, required this.lable, required this.buttonClr});
  final void Function()? onPress;
  final String lable;
  final Color buttonClr;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width * 0.255,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Colors.black, style: BorderStyle.solid),
              borderRadius: const BorderRadius.all(Radius.circular(9))),
          child: Center(
            child: Text(
              lable,
              style: appStyle(20, FontWeight.w600, buttonClr),
            ),
          )),
    );
  }
}
