import 'package:flutter/material.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../resources/colors.dart';
import 'icon_view.dart';
class CreateNewButton extends StatelessWidget {
  const CreateNewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          key: const ValueKey("CreateButton"),
          height: 43,
          width: 150,
          decoration: BoxDecoration(
            color: LIGHT_THEME_SELECTED_CHIP_COLOR,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                  color: GREY_COLOR,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3,
                  blurRadius: 5),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                IconView(
                    icon: Icons.create_outlined,
                    iconColor: WHITE_COLOR,
                    iconSize: 25),
                SizedBox(
                  width: 10,
                ),
                TextView(
                  text: "Create new",
                  fontColor: WHITE_COLOR,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}