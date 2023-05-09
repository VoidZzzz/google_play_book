import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';
import 'package:google_play_book/pages/more_audiobooks_page.dart';
import 'package:google_play_book/pages/search_page.dart';
import 'package:google_play_book/pages/shelf_details.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/default_app_bar_view.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../data/data_vos/books_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';
import '../widgets/menu_option_view.dart';
import '../widgets/modal_bottom_sheet_for_menu.dart';
import 'book_details_page.dart';
import 'book_view.dart';
import 'create_shelf_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int viewTypeValue = 1;
  List<String> categoryChipLabels = [];
  List<bool> chipIsSelected = [];
  List<ShelfVO>? shelfList;

  GooglePlayBookModel model = GooglePlayBookModelImpl();
  List<BooksVO>? savedBookList;
  bool isShowClearButton = false;

  void chipList() {
    print(savedBookList?.first.saveTime);
    print(savedBookList?.last.saveTime);
    if (savedBookList != null) {
      for (int i = 0; i < savedBookList!.length; i++) {
        if (!(categoryChipLabels.contains(savedBookList?[i].categoryName)) &&
            savedBookList?[i].categoryName != null) {
          categoryChipLabels.add(savedBookList?[i].categoryName ?? "");
          chipIsSelected.add(false);
        }
      }
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    /// getAllShelves from DB
    model.getAllShelves().then((response) {
      shelfList = response;
    });

    /// getAllBooks from DB
    model.getSavedAllBooks().then((value) {
      setState(() {
        savedBookList = value;
      });
      chipList();
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
                collapsedHeight: 75,
                expandedHeight: 75,
                flexibleSpace: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TabViewAndDividerVIew(tabController: _tabController),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              yourBooksView(context),
              yourShelvesView(context, shelfList),
            ],
          ),
        ),
      ),
    );
  }

  Stack yourShelvesView(BuildContext context, List<ShelfVO>? shelfList) {
    return Stack(
      children: [
        ShelvesView(
          shelfList: shelfList ?? [],
          onTapShelf: (shelf) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ShelfDetails(
                shelf: shelf,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateShelfPage(),
              ),
            ),
            child: const CreateNewButton(),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView yourBooksView(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          categoryChipsView(),
          const SizedBox(
            height: 10,
          ),
          sortingViews(context),
          const SizedBox(
            height: 15,
          ),
          (viewTypeValue == 1)
              ? BooksListView(
                  savedBookList: savedBookList,
                )
              : (viewTypeValue == 2)
                  ? LargeGridView(savedBookList: savedBookList)
                  : SmallGridView(
                      savedBookList: savedBookList,
                    ),
        ],
      ),
    );
  }

  Padding sortingViews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _showModalBottomSheet(
                  context, "   Sort by", "Recent", "Title", "Author");
            },
            child: const SortButtonView(),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              _showModalBottomSheet(
                  context, "   View as", "List", "Large grid", "Small grid");
            },
            child: Icon(
              (viewTypeValue == 1)
                  ? Icons.view_list_outlined
                  : Icons.view_module_outlined,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox categoryChipsView() {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryChipLabels.length + 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Visibility(
                      visible: isShowClearButton,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15, left: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isShowClearButton = false;
                            });
                          },
                          child: Container(
                            width: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(18),
                                color: WHITE_COLOR),
                            child: const Icon(
                              Icons.clear,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FilterChip(
                        backgroundColor: WHITE_COLOR,
                        side: (chipIsSelected[index - 1])
                            ? const BorderSide(color: WHITE_COLOR)
                            : const BorderSide(color: GREY_COLOR),
                        selectedColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                        showCheckmark: false,
                        label: Text(
                          categoryChipLabels[index - 1],
                        ),
                        selected: chipIsSelected[index - 1],
                        onSelected: (val) {
                          setState(() {
                            chipIsSelected[index - 1] = val;
                            isShowClearButton = true;
                          });
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context, String title,
      String radioOne, String radioTwo, String radioThree) {
    return showModalBottomSheet(
      context: (context),
      builder: (context) => Container(
        color: WHITE_COLOR,
        height: 230,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 20.0),
          child: Theme(
            data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.black,
                disabledColor: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                      value: 1,
                      groupValue: viewTypeValue,
                      onChanged: (val) {
                        setState(() {
                          viewTypeValue = val ?? 0;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      radioOne,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: APP_TERTIARY_COLOR,
                      value: 2,
                      groupValue: viewTypeValue,
                      onChanged: (val) {
                        setState(() {
                          viewTypeValue = val ?? 0;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      radioTwo,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      focusColor: WHITE_COLOR,
                      hoverColor: WHITE_COLOR,
                      activeColor: APP_TERTIARY_COLOR,
                      value: 3,
                      groupValue: viewTypeValue,
                      onChanged: (val) {
                        setState(() {
                          viewTypeValue = val ?? 0;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      radioThree,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShelvesView extends StatelessWidget {
  const ShelvesView(
      {Key? key, required this.shelfList, required this.onTapShelf})
      : super(key: key);

  final List<ShelfVO> shelfList;
  final Function(ShelfVO) onTapShelf;

  @override
  Widget build(BuildContext context) {
    return (shelfList.isNotEmpty)
        ? ListView.builder(
            itemCount: shelfList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => onTapShelf(
                shelfList[index],
              ),
              child: ShelfView(
                shelf: shelfList[index],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            // color: Colors.red,
            child: const Center(
                child: TextView(
              text: "Empty",
              fontSize: 20,
              fontColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
            )),
          );
  }
}

class TabViewAndDividerVIew extends StatelessWidget {
  const TabViewAndDividerVIew({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          unselectedLabelColor: Colors.black54,
          labelColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
          indicatorColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Your Books",
            ),
            Tab(
              text: "Your Shelves",
            ),
          ],
        ),
        const Divider(
          color: GREY_COLOR,
        )
      ],
    );
  }
}

class CreateNewButton extends StatelessWidget {
  const CreateNewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 43,
          width: 150,
          decoration: BoxDecoration(
            color: LIGHT_THEME_SELECTED_CHIP_COLOR,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                  color: GREY_COLOR,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3,
                  blurRadius: 5),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                IconView(
                    icon: Icons.create_outlined,
                    iconColor: WHITE_COLOR,
                    iconSize: 25),
                SizedBox(
                  width: 10,
                ),
                TextView(
                  text: "Create new",
                  fontColor: WHITE_COLOR,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ShelfView extends StatelessWidget {
  const ShelfView({Key? key, required this.shelf}) : super(key: key);

  final ShelfVO shelf;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                clipBehavior: Clip.antiAlias,
                width: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Image.network(
                  "https://www.pixelstalk.net/wp-content/uploads/2016/08/Breaking-Bad-HD-Wallpaper-for-Iphone.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 230,
                child: Text(
                  shelf.shelfName ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
              ),
              Text(
                "${shelf.books?.length ?? 0} books",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class SortButtonView extends StatelessWidget {
  const SortButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.sort,
          color: LIGHT_GREY_COLOR,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Sort by: Recent",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}

class BooksListView extends StatelessWidget {
  const BooksListView({Key? key, required this.savedBookList})
      : super(key: key);

  final List<BooksVO>? savedBookList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: savedBookList?.length ?? 0,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookDetails(
                          bookDetails: savedBookList?[index], bookLists: null),
                    ),
                  ),
                  child: Container(
                    height: 80,
                    width: 55,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                      savedBookList?[index].bookImage ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.52,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        savedBookList?[index].title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        savedBookList?[index].author ?? "",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Ebook-sample",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.download_done,
                  color: Colors.black87,
                  size: 20,
                ),
                CondustrialMenuView(
                  onTapMenu: () => showBottomSheetForMenu(
                      context, savedBookList?[index], () {}),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CondustrialMenuView extends StatelessWidget {
  const CondustrialMenuView({
    Key? key,
    required this.onTapMenu,
  }) : super(key: key);

  final Function onTapMenu;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapMenu(),
      child: const Icon(
        Icons.more_horiz,
        color: Colors.black54,
        size: 25,
      ),
    );
  }
}

class SmallGridView extends StatelessWidget {
  const SmallGridView({Key? key, required this.savedBookList})
      : super(key: key);

  final List<BooksVO>? savedBookList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: savedBookList?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.54),
        itemBuilder: (context, index) => BookView(
          imageHeight: 170,
          imageWidth: 170,
          titleWidth: 170,
          bottomDownloadPadding: 56,
          downloadIconSize: 15,
          leftSamplePadding: 15,
          topSamplePadding: 3,
          sampleMargin: 3,
          titleColor: Colors.black87,
          authorColor: Colors.black54,
          sampleFontSize: 13,
          onTapMenu: () =>
              showBottomSheetForMenu(context, savedBookList?[index], () {}),
          bookCover: savedBookList?[index].bookImage ?? "",
          bookName: savedBookList?[index].title ?? "",
          bookAuthorName: savedBookList?[index].author ?? "",
          onTapBookView: () {
            navigateToDetailsPage(context, index);
          },
        ),
      ),
    );
  }

  Future<dynamic> navigateToDetailsPage(BuildContext context, int index) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            BookDetails(bookDetails: savedBookList?[index], bookLists: null),
      ),
    );
  }
}

class LargeGridView extends StatelessWidget {
  const LargeGridView({Key? key, required this.savedBookList})
      : super(key: key);

  final List<BooksVO>? savedBookList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 15.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: savedBookList?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.625),
        itemBuilder: (context, index) => BookView(
          imageHeight: 250,
          imageWidth: 170,
          titleWidth: 170,
          titleColor: Colors.black87,
          authorColor: Colors.black54,
          rightMenuPadding: 5,
          bottomDownloadPadding: 49,
          rightDownloadPadding: 6,
          onTapMenu: () =>
              showBottomSheetForMenu(context, savedBookList?[index], () {}),
          bookCover: savedBookList?[index].bookImage ?? "",
          bookName: savedBookList?[index].title ?? "",
          bookAuthorName: savedBookList?[index].author ?? "",
          onTapBookView: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookDetails(
                  bookDetails: savedBookList?[index], bookLists: null),
            ),
          ),
        ),
      ),
    );
  }
}

class LargeGridBookNameView extends StatelessWidget {
  const LargeGridBookNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 5, right: 12),
      child: SizedBox(
        height: 37,
        width: 180,
        child: Text(
          "Business in 2025 by Thomas Ipsum",
          style: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class GridBookView extends StatelessWidget {
  const GridBookView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 12),
      child: Container(
        height: 250,
        width: 170,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Image.asset(
          "images/dummyBookList.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
