import 'package:flutter/material.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/resources/strings.dart';
import 'package:google_play_book/widgets/icon_view.dart';

import '../widgets/text_view.dart';

class AboutBookDetailsPage extends StatelessWidget {
  const AboutBookDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const IconView(
              icon: Icons.keyboard_arrow_left,
              iconColor: Colors.black87,
              iconSize: 30),
        ),
        title: const TextView(
          text: "About this ebook",
          fontColor: Colors.black87,
          fontSize: 18,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: TextView(
              text: BOOK_DETAILS_DUMMY_OVERVIEW_TEXT,
              fontSize: 15,
              maxLines: 999,
              fontColor: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
