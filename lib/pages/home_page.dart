import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/data/models/google_play_book_model_impl.dart';
import 'package:google_play_book/network/api_constants.dart';
import 'package:google_play_book/pages/book_details_page.dart';
import 'package:google_play_book/pages/more_audiobooks_page.dart';
import 'package:google_play_book/pages/more_ebooks_pages.dart';
import 'package:google_play_book/pages/search_page.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/text_view.dart';
import '../custom_components/smart_list_view.dart';
import '../data/data_vos/books_vo.dart';
import '../data/data_vos/lists_vo.dart';
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

  /// model
  GooglePlayBookModel model = GooglePlayBookModelImpl();
  List<ListsVO>? bookList;
  List<BooksVO>? saveBookList;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);

    /// network call
    model.getOverview(API_KEY).then((response) {
      setState(() {
        bookList = response.results?.lists;
      });
      debugPrint(bookList.toString());
    }).catchError(
      (error) {
        debugPrint(
          error.toString(),
        );
      },
    );

    model.getSavedAllBooks().then((value) {
      setState(() {
        saveBookList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: DefaultAppBarView(
            onTapSearch: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, isScroll) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                collapsedHeight: (saveBookList?.isEmpty ?? true) ? 60 : 350,
                expandedHeight: (saveBookList?.isEmpty ?? true) ? 60 : 350,
                flexibleSpace: Column(
                  children: [
                    CarouselView(
                      bookList: saveBookList ?? [],
                      savedBooksLength: saveBookList?.length ?? 0,
                    ),
                    TabBar(
                      labelStyle:
                          GoogleFonts.inter(fontWeight: FontWeight.w600),
                      labelColor: APP_TERTIARY_COLOR,
                      unselectedLabelColor: Colors.black87,
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
                    listViewTitle: bookList?[0].displayName ?? "",
                    padding: const EdgeInsets.only(left: 20),
                    onTapMore: () => _navigateToMoreBooksPage(
                        context, bookList?[0].listName ?? ""),
                    bookList: bookList?[0],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HorizontalEBooksListView(
                    listViewTitle: bookList?[1].displayName ?? "",
                    padding: const EdgeInsets.only(left: 20),
                    onTapMore: () => _navigateToMoreBooksPage(
                        context, bookList?[1].listName ?? ""),
                    bookList: bookList?[1],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HorizontalEBooksListView(
                    listViewTitle: bookList?[2].displayName ?? "",
                    padding: const EdgeInsets.only(left: 20),
                    onTapMore: () => _navigateToMoreBooksPage(
                        context, bookList?[2].listName ?? ""),
                    bookList: bookList?[2],
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

  Future<dynamic> _navigateToMoreBooksPage(
      BuildContext context, String listName) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MoreEbooksPage(
          listName: listName,
        ),
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
                  onTap: () => showBottomSheetForMenu(context, null),
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
                  text: "Tarnished: The true path to Elden Lord",
                  fontSize: 15,
                  fontColor: Colors.black87,
                  maxLines: 1,
                ),
                TextView(
                  text: "Dean Kootz",
                  fontColor: Colors.black54,
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
  const HorizontalEBooksListView(
      {Key? key,
      required this.listViewTitle,
      required this.onTapMore,
      this.padding = const EdgeInsets.only(left: 12),
      required this.bookList})
      : super(key: key);

  final String listViewTitle;
  final EdgeInsets padding;
  final Function onTapMore;
  final ListsVO? bookList;

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
            child: (bookList != null)
                ? ListView.builder(
                    itemBuilder: (context, index) => BookView(
                      bookCover: bookList?.books?[index].bookImage ?? "",
                      bookName: bookList?.books?[index].title ?? "",
                      padding: padding,
                      onTapMenu: () => showBottomSheetForMenu(
                          context, bookList?.books?[index]),
                      bottomDownloadPadding: 48,
                      downloadIconSize: 17,
                      authorColor: Colors.black54,
                      titleColor: Colors.black87,
                      downloadMargin: 2,
                      leftSamplePadding: 25,
                      topSamplePadding: 5,
                      sampleFontSize: 12,
                      sampleMargin: 3,
                      onTapBookView: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookDetails(
                            bookDetails: bookList?.books?[index],
                            bookLists: bookList,
                          ),
                        ),
                      ),
                    ),
                    itemCount: bookList?.books?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                  )
                : const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: LIGHT_THEME_SELECTED_CHIP_COLOR,
                      ),
                    ),
                  ),
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
                  color: Colors.black87),
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
  final List<BooksVO> bookList;
  final int savedBooksLength;

  const CarouselView({
    Key? key,
    required this.savedBooksLength,
    required this.bookList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: savedBooksLength > 0,
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: bookList.length,
          itemBuilder: (context, index, i) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: GREY_COLOR,
                      offset: Offset(2.0, 5.0),
                      blurRadius: 4.0,
                      spreadRadius: 3.0,
                    ), //BoxShadow
                  ]),
              child: Image.network(
                "${bookList[index].bookImage}",
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
      ),
    );
  }
}
