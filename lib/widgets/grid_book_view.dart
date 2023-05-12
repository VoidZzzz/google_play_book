
import 'package:flutter/material.dart';
class GridBookView extends StatelessWidget {
  const GridBookView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 12),
      child: Container(
        height: 250,
        width: 170,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Image.asset(
          "images/dummyBookList.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}