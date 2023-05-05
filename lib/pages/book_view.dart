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
        this.bookAuthorName = "Thomas Ipsum",
        this.titleColor = GREY_COLOR,
        this.authorColor = GREY_COLOR,
      required this.onTapMenu,
      required this.bookCover,
      required this.bookName,
      required this.onTapBookView})
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
  final String bookCover;
  final String bookName;
  final Function onTapBookView;
  final String bookAuthorName;
  final Color titleColor;
  final Color authorColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapBookView(),
      child: Stack(
        children: [
          Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookCoverView(
                  imageHeight: imageHeight,
                  imageWidth: imageWidth,
                  bookCover: bookCover,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: titleHeight,
                  width: titleWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookName,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: titleColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        bookAuthorName,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: authorColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextView(
                  text: "Sample",
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.white70,
                  fontSize: sampleFontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookCoverView extends StatelessWidget {
  const BookCoverView(
      {Key? key,
      required this.imageHeight,
      required this.imageWidth,
      required this.bookCover})
      : super(key: key);

  final double imageHeight;
  final double imageWidth;
  final String bookCover;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      height: imageHeight,
      width: imageWidth,
      child: Image.network(
        bookCover,
        fit: BoxFit.cover,
      ),
    );
  }
}
