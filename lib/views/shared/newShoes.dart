// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewShoes extends StatelessWidget {
  final String imageUrl;
  const NewShoes({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            blurRadius: 0.8,
            color: Colors.white,
            offset: Offset(0, 1),
            spreadRadius: 1.5)
      ], color: Colors.grey, borderRadius: BorderRadius.circular(19)),
      width: MediaQuery.of(context).size.width * 0.28,
      height: MediaQuery.of(context).size.height * 12,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
      ),
    );
  }
}
