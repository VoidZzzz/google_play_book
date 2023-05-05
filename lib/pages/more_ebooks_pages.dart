import 'package:flutter/material.dart';
import 'package:google_play_book/pages/book_view.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../widgets/modal_bottom_sheet_for_menu.dart';
import 'library_page.dart';

class MoreEbooksPage extends StatelessWidget {
  const MoreEbooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitleView(),
        leading: const AppBarLeadingView(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 3),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.62),
          itemBuilder: (context, index) => BookView(
            imageHeight: 250,
            imageWidth: 180,
            titleWidth: 180,
            rightMenuPadding: 5,
            bottomDownloadPadding: 57,
            rightDownloadPadding: 5,
            onTapMenu: () => showBottomSheetForMenu(context), bookCover: '', bookName: '',
            onTapBookView: (){},
          ),
        ),
      ),
    );
  }
}

class AppBarLeadingView extends StatelessWidget {
  const AppBarLeadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconView(
        icon: Icons.keyboard_arrow_left, iconColor: WHITE_COLOR, iconSize: 25);
  }
}

class AppBarTitleView extends StatelessWidget {
  const AppBarTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextView(
      text: "More Like Business Approach in 2025",
      fontSize: 16,
    );
  }
}
