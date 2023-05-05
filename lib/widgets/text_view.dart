import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/resources/colors.dart';

class TextView extends StatelessWidget {
  const TextView(
      {Key? key,
      required this.text,
      this.fontColor = Colors.black54,
      this.fontWeight = FontWeight.w600,
      this.fontSize = 14,
      this.maxLines =2,
      this.isDecorated = false})
      : super(key: key);

  final String text;
  final FontWeight fontWeight;
  final Color fontColor;
  final double fontSize;
  final int maxLines;
  final bool isDecorated;

  @override
  Widget build(BuildContext context) {
    return Text(
      text, overflow: TextOverflow.ellipsis, maxLines: maxLines,
      style: GoogleFonts.inter(
          fontWeight: fontWeight, fontSize: fontSize, color: fontColor, decoration: isDecorated ? TextDecoration.underline : TextDecoration.none,),
    );
  }
}
