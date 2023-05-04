import 'package:flutter/material.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import 'book_details_page.dart';
import 'home_page.dart';

class MoreAudiobooksPage extends StatelessWidget {
  const MoreAudiobooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const IconView(
              icon: Icons.keyboard_arrow_left,
              iconColor: WHITE_COLOR,
              iconSize: 30),
        ),
        title: const TextView(
          text: "More Audiobooks",
          fontSize: 18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 240, crossAxisSpacing: 15),
          itemBuilder: (context, index) => AudiobooksView(
            onTapAudiobook: () => navigateToBookDetailsPage(context),),
        ),
      ),
    );
  }
}

Future<dynamic> navigateToBookDetailsPage(BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const BookDetails(isAudiobook: true,),
    ),
  );
}
