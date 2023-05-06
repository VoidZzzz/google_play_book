import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/colors.dart';

class MenuOptionsView extends StatelessWidget {
  const MenuOptionsView(
      {Key? key, required this.menuIcon, required this.menuName})
      : super(key: key);

  final IconData menuIcon;
  final String menuName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          menuIcon,
          color: APP_PRIMARY_COLOR,
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          menuName,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 15,color: APP_PRIMARY_COLOR),
        ),
      ],
    );
  }
}