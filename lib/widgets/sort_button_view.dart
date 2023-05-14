import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
class SortButtonView extends StatelessWidget {
  const SortButtonView({
    Key? key,
    required this.sortByValue
  }) : super(key: key);
  final int sortByValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.sort,
          key: ValueKey("SortingLayoutKey"),
          color: LIGHT_GREY_COLOR,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          (sortByValue == 1)? "Sort by: Recent" : (sortByValue == 2) ? " Sort by: Title" : "sort by: Author",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}