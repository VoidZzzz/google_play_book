import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/pages/book_details_page.dart';
import 'package:google_play_book/pages/more_audiobooks_page.dart';
import 'package:google_play_book/pages/more_ebooks_pages.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/text_view.dart';
import '../custom_components/smart_list_view.dart';
import '../widgets/default_app_bar_view.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/icon_view.dart';
import '../widgets/modal_bottom_sheet_for_menu.dart';
import 'book_view.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const DefaultAppBarView(),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, isScroll) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                // backgroundColor: APP_PRIMARY_COLOR,
                collapsedHeight: 350,
                expandedHeight: 350,
                flexibleSpace: Column(
                  children: [
                    const CarouselView(),
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: APP_TERTIARY_COLOR,
                      controller: _controller,
                      tabs: const [
                        Tab(
                          text: "EBooks",
                        ),
                        Tab(
                          text: "AudioBooks",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  HorizontalEBooksListView(
                    listViewTitle: "More Like Ninjas in Pyjamas",
                    padding: const EdgeInsets.only(left: 20),
                    onTapMore: () => _navigateToMoreBooksPage(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HorizontalEBooksListView(
                    listViewTitle: "E-Books for you",
                    padding: const EdgeInsets.only(left: 20),
                    onTapMore: () => _navigateToMoreBooksPage(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HorizontalEBooksListView(
                    listViewTitle: "On your Wishlist",
                    padding: const EdgeInsets.only(left: 20),
                    onTapMore: () => _navigateToMoreBooksPage(context),
                  ),
                ],
              ),
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  HorizontalAudioBooksListView(
                    titleText: "Audiobooks for you",
                    onTapMore: () => _navigateToMoreAudiobooksPage(context),
                    onTapAudiobook: () => navigateToBookDetailsPage(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HorizontalAudioBooksListView(
                    titleText: "Self-heal",
                    onTapMore: () => _navigateToMoreAudiobooksPage(context),
                    onTapAudiobook: () => navigateToBookDetailsPage(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HorizontalAudioBooksListView(
                    titleText: "Educational",
                    onTapMore: () => _navigateToMoreAudiobooksPage(context),
                    onTapAudiobook: () => navigateToBookDetailsPage(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToMoreAudiobooksPage(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MoreAudiobooksPage(),
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
}

class HorizontalAudioBooksListView extends StatelessWidget {
  const HorizontalAudioBooksListView(
      {Key? key,
      required this.titleText,
      required this.onTapAudiobook,
      required this.onTapMore})
      : super(key: key);

  final String titleText;
  final Function onTapMore;
  final Function onTapAudiobook;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
            onTap: () => onTapMore(),
            child: CategoryTitleView(
              listViewTitle: titleText,
              padding: const EdgeInsets.only(left: 20),
            ),
          ),
          SizedBox(
            height: 225,
            child: SmartHorizontalListView(
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: AudiobooksView(
                        onTapAudiobook: onTapAudiobook,
                      ),
                    ),
                onListEndReached: () {},
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal),
          ),
        ],
      ),
    );
  }
}

class AudiobooksView extends StatelessWidget {
  const AudiobooksView({Key? key, required this.onTapAudiobook})
      : super(key: key);
  final Function onTapAudiobook;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapAudiobook(),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: 180,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  "images/audioBook.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 7,
                top: 5,
                child: InkWell(
                  onTap: () => showBottomSheetForMenu(context),
                  child: const IconView(
                      icon: Icons.more_horiz_outlined,
                      iconColor: GREY_COLOR,
                      iconSize: 25),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: APP_PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const IconView(
                      icon: Icons.headphones_outlined,
                      iconColor: WHITE_COLOR,
                      iconSize: 20),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 40,
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextView(
                  text: "The taking: A Novel",
                  fontSize: 15,
                  fontColor: Colors.white70,
                  maxLines: 1,
                ),
                TextView(
                  text: "Dean Kootz",
                  fontColor: Colors.white54,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HorizontalEBooksListView extends StatelessWidget {
  const HorizontalEBooksListView({
    Key? key,
    required this.listViewTitle,
    required this.onTapMore,
    this.padding = const EdgeInsets.only(left: 12),
  }) : super(key: key);

  final String listViewTitle;
  final EdgeInsets padding;
  final Function onTapMore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 295,
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
            onTap: () => onTapMore(),
            child: CategoryTitleView(
              listViewTitle: listViewTitle,
              padding: padding,
            ),
          ),
          SizedBox(
            height: 245,
            child: SmartHorizontalListView(
                itemCount: 5,
                itemBuilder: (context, index) => BookView(
                      padding: padding,
                      onTapMenu: () => showBottomSheetForMenu(context),
                      bottomDownloadPadding: 48,
                      downloadIconSize: 17,
                      downloadMargin: 2,
                      leftSamplePadding: 25,
                      topSamplePadding: 5,
                      sampleFontSize: 12,
                      sampleMargin: 3,
                    ),
                onListEndReached: () {},
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal),
          ),
        ],
      ),
    );
  }
}

class CategoryTitleView extends StatelessWidget {
  const CategoryTitleView(
      {Key? key,
      required this.listViewTitle,
      this.padding = const EdgeInsets.only(left: 12)})
      : super(key: key);

  final String listViewTitle;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Text(
              listViewTitle,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 35,
              color: APP_TERTIARY_COLOR,
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselView extends StatelessWidget {
  const CarouselView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 10,
        itemBuilder: (context, index, i) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              "images/dummySquareBook.jpg",
              fit: BoxFit.cover,
            ),
          );
        },
        options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 0.55,
            enableInfiniteScroll: false,
            reverse: false,
            initialPage: 0),
      ),
    );
  }
}
