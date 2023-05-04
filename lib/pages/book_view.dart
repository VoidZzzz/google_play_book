import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import 'book_details_page.dart';

class BookView extends StatelessWidget {
  const BookView(
      {Key? key,
      this.imageHeight = 200,
      this.imageWidth = 130,
      this.titleHeight = 40,
      this.titleWidth = 130,
      this.padding = const EdgeInsets.only(left: 12),
      this.rightMenuPadding = 1,
      this.rightDownloadPadding = 3,
      this.isDownLoaded = true,
      this.bottomDownloadPadding = 50,
      this.downloadIconSize = 20,
      this.downloadMargin = 1,
      this.leftSamplePadding = 17,
      this.sampleFontSize = 14,
      this.sampleMargin = 5,
      this.topSamplePadding = 5,
        this.isSample = true,
      required this.onTapMenu})
      : super(key: key);

  final EdgeInsets padding;
  final double imageHeight;
  final double imageWidth;
  final double titleHeight;
  final double titleWidth;
  final double rightMenuPadding;
  final double rightDownloadPadding;
  final double bottomDownloadPadding;
  final Function onTapMenu;
  final double downloadMargin;
  final double downloadIconSize;
  final double leftSamplePadding;
  final double topSamplePadding;
  final double sampleMargin;
  final double sampleFontSize;
  final bool isDownLoaded;
  final bool isSample;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToBookDetails(context),
      child: Stack(
        children: [
          Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookCoverView(imageHeight: imageHeight, imageWidth: imageWidth),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: titleHeight,
                  width: titleWidth,
                  child: Text(
                    "Business Approach in 2025 by Thorum Ipsum",
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: rightMenuPadding,
            top: 1,
            child: InkWell(
              onTap: () => onTapMenu(),
              child: const IconView(
                  icon: Icons.more_horiz_outlined,
                  iconColor: GREY_COLOR,
                  iconSize: 25),
            ),
          ),
          Positioned(
            right: rightDownloadPadding,
            bottom: bottomDownloadPadding,
            child: Container(
              padding: EdgeInsets.all(downloadMargin),
              decoration: BoxDecoration(
                color: APP_SECONDARY_COLOR,
                borderRadius: BorderRadius.circular(2),
              ),
              child: IconView(
                  icon: isDownLoaded ? Icons.download_done : Icons.download,
                  iconColor: WHITE_COLOR,
                  iconSize: downloadIconSize),
            ),
          ),
          Visibility(
            visible: isSample,
            child: Positioned(
              left: leftSamplePadding,
              top: topSamplePadding,
              child: Container(
                padding: EdgeInsets.all(sampleMargin),
                decoration: BoxDecoration(
                  color: APP_SECONDARY_COLOR,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextView(
                  text: "Sample",
                  fontWeight: FontWeight.w500,
                  fontSize: sampleFontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _navigateToBookDetails(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BookDetails(),
      ),
    );
  }
}

class BookCoverView extends StatelessWidget {
  const BookCoverView({
    Key? key,
    required this.imageHeight,
    required this.imageWidth,
  }) : super(key: key);

  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      height: imageHeight,
      width: imageWidth,
      child: Image.asset(
        "images/ebook.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
