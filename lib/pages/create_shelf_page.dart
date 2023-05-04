import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/divider_view.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

class CreateShelfPage extends StatelessWidget {
  const CreateShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        leading: const IconView(
            icon: Icons.keyboard_arrow_left,
            iconColor: WHITE_COLOR,
            iconSize: 30),
        title: const TextView(
          text: "Create shelf",
          fontSize: 18,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: APP_TERTIARY_COLOR)
                ),
              ),
              child: TextFormField(
                autofocus: true,
                onFieldSubmitted: (str) => Navigator.of(context).pop(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: WHITE_COLOR,
                  hintText: 'Shelf name',
                  hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black45),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          DividerView(dividerColor: GREY_COLOR, dividerThickness: 0.5)
        ],
      ),
    );
  }
}
