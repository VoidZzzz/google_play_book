import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
class SortButtonView extends StatelessWidget {
  const SortButtonView({
    Key? key,
  }) : super(key: key);

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
          "Sort by: Recent",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}