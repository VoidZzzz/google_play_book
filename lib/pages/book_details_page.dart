import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/pages/about_book_details_page.dart';
import 'package:google_play_book/pages/home_page.dart';
import 'package:google_play_book/pages/rating_details_page.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/divider_view.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../resources/strings.dart';
import '../widgets/rating_overview_with_progress_bar_indicator.dart';
import '../widgets/rating_view_by_users.dart';
import '../widgets/text_view.dart';
import 'more_ebooks_pages.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({Key? key, this.isAudiobook = false}) : super(key: key);
  final bool isAudiobook;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool seeMoreIsTapped = false; // <==== Ebook details SEE MORE flag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const AppBarView(),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, isScroll) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            collapsedHeight: 380,
            expandedHeight: 380,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  BookCoverAndDescriptionView(isAudiobook: widget.isAudiobook),
                  BookRatingAndTypeView(
                    isAudiobook: widget.isAudiobook,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 35,
                          width: 170,
                          decoration: BoxDecoration(
                              color: APP_PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: WHITE_COLOR)),
                          child: const Center(
                            child: TextView(
                              text: "Free Sample",
                              fontWeight: FontWeight.w600,
                              fontColor: APP_TERTIARY_COLOR,
                            ),
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 170,
                          decoration: BoxDecoration(
                            color: APP_TERTIARY_COLOR,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: TextView(
                              text: "Buy \$2.5",
                              fontWeight: FontWeight.w600,
                              fontColor: APP_PRIMARY_COLOR,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "List price: ",
                                style: GoogleFonts.inter(
                                    fontSize: 13, fontWeight: FontWeight.w400)),
                            TextSpan(
                              text: "\$2.99",
                              style: GoogleFonts.inter(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  const DividerView(
                      dividerColor: GREY_COLOR, dividerThickness: 1)
                ],
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: InkWell(
                  onTap: () => _navigateToAboutBooksDetailsScreen(context),
                  child: SizedBox(
                    height: 130,
                    child: Column(
                      children: [
                        const SectionTitleAndSeemoreButtonView(
                          text: "About this ebook",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          BOOK_DETAILS_DUMMY_OVERVIEW_TEXT,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.normal,
                              color: Colors.white54,
                              fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () => _navigateToRatingDetailsScreen(context),
                      child: const SectionTitleAndSeemoreButtonView(
                        text: "Ratings and reviews",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const RatingOverViewWithProgressBarIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: RatingViewByUsers(
                      userName: "Tanner League",
                      userComment:
                          "Another good edition to the shockingly former bully of Peter Parker",
                      reviewDate: "Jun 10, 2016",
                      userImage: "images/cat2.jpg",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: RatingViewByUsers(
                      userImage: "images/cat1.jpg",
                      userName: "Danny O'Neal",
                      userComment:
                          "Great art and interesting story. What more can you ask for",
                      reviewDate: "Oct 2, 2023",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: RatingViewByUsers(
                      userImage: "images/cat3.jpg",
                      userName: "P J",
                      userComment:
                          "The dilemma Flash has with the symbiote the demon and himself keep the story captivating",
                      reviewDate: "Nov 23, 2019",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  HorizontalEBooksListView(
                    listViewTitle: "More by Thomas Ipsum",
                    onTapMore: () => _navigateToMoreBooksPage(context),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  HorizontalEBooksListView(
                    listViewTitle: "Similar ebooks",
                    onTapMore: () => _navigateToMoreBooksPage(context),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextView(
                      text: "Rate this ebook",
                      fontSize: 18,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextView(
                      text: "Tell others what you think",
                      fontWeight: FontWeight.w400,
                      fontColor: Colors.white70,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: RatingBar.builder(
                          unratedColor: GREY_COLOR,
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: APP_TERTIARY_COLOR,
                              ),
                          onRatingUpdate: (val) {}),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: GREY_COLOR, width: 0.5)),
                      child: const Center(
                        child: TextView(
                          text: "Write a review",
                          fontColor: APP_TERTIARY_COLOR,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DividerView(
                        dividerColor: GREY_COLOR, dividerThickness: 0.5),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextView(
                      text: "Ebook details",
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  seeMoreIsTapped
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: columnForMoreView(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: columnForLessView(),
                        ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: const [
                        IconView(
                            icon: Icons.info_outline,
                            iconColor: GREY_COLOR,
                            iconSize: 20),
                        SizedBox(
                          width: 15,
                        ),
                        TextView(text: "Google play refund policy"),
                        Spacer()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToMoreBooksPage(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MoreEbooksPage(),
      ),
    );
  }

  Future<dynamic> _navigateToRatingDetailsScreen(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RatingDetailsPage(),
      ),
    );
  }

  Column columnForMoreView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BookDetailsTextRowView(
          title: "Language",
          value: "English",
        ),
        const BookDetailsTextRowView(
          title: "Features",
          value: "Original pages",
          isDecorated: true,
        ),
        const BookDetailsTextRowView(
          title: "Seller",
          value: "Google Ireland Ltd",
        ),
        const BookDetailsTextRowView(
          title: "Author",
          value: "Thomas Ipsum",
        ),
        const BookDetailsTextRowView(
          title: "Illustrator",
          value: "Thony Silas",
        ),
        const BookDetailsTextRowView(
          title: "Publisher",
          value: "Marvel Entertainment",
          isDecorated: true,
        ),
        const BookDetailsTextRowView(
          title: "Published on",
          value: "Feb 20, 2016",
        ),
        const BookDetailsTextRowView(
          title: "ISBN",
          value: "9781350654325",
        ),
        const BookDetailsTextRowView(
          title: "ISBN",
          value: "9781350654325",
        ),
        const BookDetailsTextRowView(
            title: "Best for",
            value: "web, tablet, phone, eReader",
            isDecorated: true),
        const BookDetailsTextRowView(
          title: "Pages",
          value: "31",
        ),
        const BookDetailsTextRowView(
          title: "Content",
          value: "DRM protected",
        ),
        const BookDetailsTextRowView(
          title: "Genres",
          value: "Comics, Novel",
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () => setState(() {
            seeMoreIsTapped = !seeMoreIsTapped;
          }),
          child: const TextView(
            text: "Less",
            fontColor: APP_TERTIARY_COLOR,
          ),
        ),
      ],
    );
  }

  Column columnForLessView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BookDetailsTextRowView(
          title: "Language",
          value: "English",
        ),
        const BookDetailsTextRowView(
          title: "Features",
          value: "Original pages",
          isDecorated: true,
        ),
        const BookDetailsTextRowView(
          title: "Seller",
          value: "Google Ireland Ltd",
        ),
        const BookDetailsTextRowView(
          title: "Author",
          value: "Thomas Ipsum",
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () => setState(() {
            seeMoreIsTapped = !seeMoreIsTapped;
          }),
          child: const TextView(
            text: "More",
            fontColor: APP_TERTIARY_COLOR,
          ),
        ),
      ],
    );
  }

  Future<dynamic> _navigateToAboutBooksDetailsScreen(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AboutBookDetailsPage(),
      ),
    );
  }
}

class BookDetailsTextRowView extends StatelessWidget {
  const BookDetailsTextRowView(
      {Key? key,
      required this.title,
      required this.value,
      this.isDecorated = false})
      : super(key: key);

  final String title;
  final String value;
  final bool isDecorated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextView(
                text: title,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextView(
                text: value,
                fontColor: isDecorated ? APP_TERTIARY_COLOR : Colors.white70,
                isDecorated: isDecorated,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SectionTitleAndSeemoreButtonView extends StatelessWidget {
  const SectionTitleAndSeemoreButtonView({Key? key, required this.text})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextView(
          text: text,
          fontSize: 18,
        ),
        const Spacer(),
        const IconView(
            icon: Icons.keyboard_arrow_right,
            iconColor: APP_TERTIARY_COLOR,
            iconSize: 30),
      ],
    );
  }
}

class BookRatingAndTypeView extends StatelessWidget {
  const BookRatingAndTypeView({Key? key, required this.isAudiobook})
      : super(key: key);
  final bool isAudiobook;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    "4.3",
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        color: GREY_COLOR,
                        fontWeight: FontWeight.w600),
                  ),
                  const IconView(
                      icon: Icons.star, iconColor: GREY_COLOR, iconSize: 25),
                ],
              ),
              Text(
                "155 reviews",
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const IconView(
                  icon: Icons.book_outlined,
                  iconColor: GREY_COLOR,
                  iconSize: 25),
              Text(
                isAudiobook ? "Audiobook" : "Ebook",
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                isAudiobook ? "5hr 27min" : "31",
                style: GoogleFonts.inter(
                    fontSize: 18,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                isAudiobook ? "Unabridged" : "pages",
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const IconView(
                  icon: Icons.home_rounded,
                  iconColor: GREY_COLOR,
                  iconSize: 25),
              Text(
                "Eligible",
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: GREY_COLOR,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class BookCoverAndDescriptionView extends StatelessWidget {
  const BookCoverAndDescriptionView({Key? key, required this.isAudiobook})
      : super(key: key);
  final bool isAudiobook;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          BookCoverView(isAudiobook: isAudiobook,),
          const SizedBox(
            width: 15,
          ),
          BookDescriptionTextsView(isAudiobook: isAudiobook)
        ],
      ),
    );
  }
}

class BookCoverView extends StatelessWidget {
  const BookCoverView({Key? key, required this.isAudiobook}) : super(key: key);

  final bool isAudiobook;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isAudiobook ? 150 : 180,
      width: 120,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Image.asset(
        isAudiobook ? "images/audioBook.jpg" : "images/ebook.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}

class BookDescriptionTextsView extends StatelessWidget {
  const BookDescriptionTextsView({
    Key? key,
    required this.isAudiobook
  }) : super(key: key);

  final bool isAudiobook;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 217,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isAudiobook ? "The Becoming of Elden Lord" : "Vikings: The taking of Rome",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, fontSize: 23, color: WHITE_COLOR),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "(Legacy Edition)",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, fontSize: 22, color: WHITE_COLOR),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Thomas Ipsum",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, fontSize: 16, color: WHITE_COLOR),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Titan Series",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white54),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Released Nov 11, 2015",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white54),
          )
        ],
      ),
    );
  }
}

class AppBarView extends StatelessWidget {
  const AppBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        IconView(
            icon: Icons.keyboard_arrow_left,
            iconColor: WHITE_COLOR,
            iconSize: 30),
        Spacer(),
        IconView(icon: Icons.search, iconColor: WHITE_COLOR, iconSize: 25),
        SizedBox(
          width: 15,
        ),
        IconView(
            icon: Icons.bookmark_add_outlined,
            iconColor: WHITE_COLOR,
            iconSize: 22),
        SizedBox(
          width: 15,
        ),
        IconView(
            icon: Icons.more_horiz_outlined,
            iconColor: WHITE_COLOR,
            iconSize: 25),
      ],
    );
  }
}
