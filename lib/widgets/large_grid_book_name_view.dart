import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LargeGridBookNameView extends StatelessWidget {
  const LargeGridBookNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 5, right: 12),
      child: SizedBox(
        height: 37,
        width: 180,
        child: Text(
          "Business in 2025 by Thomas Ipsum",
          style: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}