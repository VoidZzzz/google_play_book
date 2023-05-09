import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';
import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/divider_view.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../data/models/google_play_book_model_impl.dart';

class CreateShelfPage extends StatelessWidget {
  CreateShelfPage({Key? key}) : super(key: key);

  GooglePlayBookModel model = GooglePlayBookModelImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        leading: const IconView(
            icon: Icons.keyboard_arrow_left,
            iconColor: Colors.black87,
            iconSize: 30),
        title: const TextView(
          text: "Create shelf",
          fontSize: 18,
          fontColor: Colors.black87,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: APP_TERTIARY_COLOR)),
              ),
              child: TextFormField(
                autofocus: true,
                onFieldSubmitted: (str) {
                  model.createShelf(
                    ShelfVO(str, DateTime.now().microsecondsSinceEpoch, null,
                        false),
                  );
                  Navigator.of(context).pop();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: WHITE_COLOR,
                  hintText: 'Shelf name',
                  hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black45),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const DividerView(dividerColor: GREY_COLOR, dividerThickness: 0.5)
        ],
      ),
    );
  }
}
