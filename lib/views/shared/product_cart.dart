import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/favourite_provider.dart';
import 'package:shop_app/views/shared/appStyle.dart';
import 'package:shop_app/views/ui/Favourite_page.dart';

class ProductCart extends StatefulWidget {
  const ProductCart(
      {super.key,
      required this.name,
      required this.id,
      required this.category,
      required this.image,
      required this.price});
  final String name;
  final String id;
  final String category;
  final String image;
  final String price;

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {

  @override
  Widget build(BuildContext context) {
    var favouritesProvider =
        Provider.of<FavouritProvider>(context, listen: true);
    favouritesProvider.getFavourite();
    bool isSelected = true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                offset: Offset(1, 1),
                blurRadius: 0.6,
                color: Colors.white)
          ]),
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.contain)),
                ),
                Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                        onTap: () async {
                          if (favouritesProvider.ids.contains(widget.id)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FavouritPage()));
                          } else {
                            favouritesProvider.createFav({
                              "id": widget.id,
                              "name": widget.name,
                              "price": widget.price,
                              "imageUrl": widget.image,
                              "category": widget.category,
                            });
                          }
                          setState(() {});
                        },
                        child: favouritesProvider.ids.contains(widget.id)
                            ? const Icon(AntIcons.heartFilled)
                            : const Icon(AntIcons.heartOutlined)))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appStyleWithHt(
                          36, FontWeight.bold, Colors.black, 1.1),
                    ),
                    Text(
                      widget.category,
                      style: appStyleWithHt(
                          18, FontWeight.bold, Colors.black, 1.5),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appStyle(30, FontWeight.w600, Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          'Color',
                          style: appStyle(18, FontWeight.w600, Colors.grey),
                        ),
                        SizedBox(
                          child: ChoiceChip(
                            label: const Text(''),
                            selected: isSelected,
                            visualDensity: VisualDensity.compact,
                            selectedColor: Colors.black,
                          ),
                        )
                      ],
                    )
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
