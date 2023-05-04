import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/pages/shelf_details.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/default_app_bar_view.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../widgets/menu_option_view.dart';
import '../widgets/modal_bottom_sheet_for_menu.dart';
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
  List<String> dummyChipLabels = [
    "Ebooks",
    "Audiobooks",
    "Purchased",
    "Downloaded",
    "Sci_fi",
    "Drama",
    "Educational",
    "Manga"
  ];
  List<bool> chipIsSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const DefaultAppBarView(),
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
                    Column(
                      children: [
                        TabBar(
                          indicatorColor: APP_TERTIARY_COLOR,
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
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: dummyChipLabels.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15, left: 20),
                                child: InkWell(
                                  onTap: () {
                                    for (int i = 0;
                                        i < chipIsSelected.length;
                                        i++) {
                                      setState(() {
                                        chipIsSelected[i] = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: WHITE_COLOR),
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: FilterChip(
                                  backgroundColor: WHITE_COLOR,
                                  selectedColor: APP_TERTIARY_COLOR,
                                  showCheckmark: false,
                                  label: Text(
                                    dummyChipLabels[index - 1],
                                  ),
                                  selected: chipIsSelected[index],
                                  onSelected: (val) {
                                    setState(() {
                                      chipIsSelected[index] = val;
                                    });
                                  },
                                ),
                              );
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _showModalBottomSheet(context, "   Sort by",
                                  "Recent", "Title", "Author");
                            },
                            child: const SortButtonView(),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              _showModalBottomSheet(context, "   View as",
                                  "List", "Large grid", "Small grid");
                            },
                            child: Icon(
                              (viewTypeValue == 1)
                                  ? Icons.view_list_outlined
                                  : Icons.view_module_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    (viewTypeValue == 1)
                        ? BooksListView(
                            onTapMenu: () {
                              showBottomSheetForMenu(context);
                            },
                          )
                        : (viewTypeValue == 2)
                            ? const LargeGridView()
                            : const SmallGridView(),
                  ],
                ),
              ),
              Stack(
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ShelfDetails(),
                            ),
                          );
                        },
                        child: const ShelfView(),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CreateShelfPage(),
                        ),
                      ),
                      child: const CreateNewButton(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context, String title,
      String radioOne, String radioTwo, String radioThree) {
    return showModalBottomSheet(
      context: (context),
      builder: (context) => Container(
        color: APP_SECONDARY_COLOR,
        height: 230,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 20.0),
          child: Theme(
            data: Theme.of(context).copyWith(
                unselectedWidgetColor: WHITE_COLOR, disabledColor: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: WHITE_COLOR),
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
                      activeColor: APP_TERTIARY_COLOR,
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
                          color: WHITE_COLOR,
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
                          color: WHITE_COLOR,
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
                          color: WHITE_COLOR,
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

class CreateNewButton extends StatelessWidget {
  const CreateNewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        height: 43,
        width: 150,
        decoration: BoxDecoration(
            color: APP_TERTIARY_COLOR, borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IconView(
                  icon: Icons.create,
                  iconColor: APP_PRIMARY_COLOR,
                  iconSize: 25),
              SizedBox(
                width: 10,
              ),
              TextView(
                text: "Create new",
                fontColor: APP_PRIMARY_COLOR,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShelfView extends StatelessWidget {
  const ShelfView({
    Key? key,
  }) : super(key: key);

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
              SizedBox(
                height: 80,
                child: Image.asset(
                  "images/dummyBookList.webp",
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
                  "10 interactive Design Books To Read",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: WHITE_COLOR),
                ),
              ),
              Text(
                "2 books",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white54),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: WHITE_COLOR,
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
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Sort by: recent",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }
}

class BooksListView extends StatelessWidget {
  const BooksListView({Key? key, required this.onTapMenu}) : super(key: key);

  final Function onTapMenu;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 8,
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
                const BookCoverView(imageHeight: 85, imageWidth: 55),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Business Approach in 2025",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      Text(
                        "Thomas Ipsum",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                      Text(
                        "Ebook-sample",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.download_done,
                  color: Colors.grey,
                  size: 20,
                ),
                CondustrialMenuView(onTapMenu: onTapMenu)
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
        color: Colors.grey,
        size: 25,
      ),
    );
  }
}

class SmallGridView extends StatelessWidget {
  const SmallGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
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
          sampleFontSize: 13,
          onTapMenu: () => showBottomSheetForMenu(context),
        ),
      ),
    );
  }
}

class LargeGridView extends StatelessWidget {
  const LargeGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 15.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.625),
        itemBuilder: (context, index) => BookView(
          imageHeight: 250,
          imageWidth: 170,
          titleWidth: 170,
          rightMenuPadding: 5,
          bottomDownloadPadding: 49,
          rightDownloadPadding: 6,
          onTapMenu: () => showBottomSheetForMenu(context),
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