import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';
import 'package:google_play_book/pages/bottom_navigation_bar_home_page.dart';
import 'package:google_play_book/pages/create_shelf_page.dart';
import 'package:google_play_book/pages/library_page.dart';
import 'package:google_play_book/widgets/menu_option_view.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../data/data_vos/books_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';
import '../widgets/modal_bottom_sheet_for_menu.dart';

class ShelfDetails extends StatefulWidget {
  const ShelfDetails({Key? key, required this.shelf}) : super(key: key);
  final ShelfVO shelf;

  @override
  State<ShelfDetails> createState() => _ShelfDetailsState();
}

class _ShelfDetailsState extends State<ShelfDetails> {
  int viewTypeValue = 2;
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

  GooglePlayBookModel model = GooglePlayBookModelImpl();
  List<BooksVO>? savedBookList;
  List<BooksVO>? booksInShelves;
  bool isShowClearButton = false;
  bool isEditMode = false;

  @override
  void initState() {
    setState(() {
      booksInShelves = widget.shelf.books;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: WHITE_COLOR,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const IconView(
                  icon: Icons.keyboard_arrow_left,
                  iconColor: APP_PRIMARY_COLOR,
                  iconSize: 33),
            ),
            const Spacer(),
            InkWell(
              onTap: () => showModalBottomSheet(
                context: (context),
                builder: (context) => Container(
                  height: 160,
                  color: WHITE_COLOR,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: widget.shelf.shelfName ?? "",
                          fontColor: APP_PRIMARY_COLOR,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: GREY_COLOR,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isEditMode = true;
                            });
                            Navigator.of(context).pop();
                          },
                          child: const MenuOptionsView(
                              menuIcon: Icons.mode_edit_outline_outlined,
                              menuName: "Rename shelf"),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                            onTap: () {
                              model.deleteShelf(widget.shelf.shelfId!);
                              _navigateToHomePage(context);
                            },
                            child: const MenuOptionsView(
                                menuIcon: Icons.delete_outline_sharp,
                                menuName: "Delete shelf"))
                      ],
                    ),
                  ),
                ),
              ),
              child: const IconView(
                  icon: Icons.more_horiz,
                  iconColor: APP_PRIMARY_COLOR,
                  iconSize: 25),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            !isEditMode
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextView(
                          text: widget.shelf.shelfName ?? "",
                          fontColor: APP_PRIMARY_COLOR,
                          fontSize: 18,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextView(
                          text: "${widget.shelf.books?.length ?? 0} books",
                          fontColor: GREY_COLOR,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  )
                : RenameView(
                    onSubmit: (newShelf) {
                      setState(() {
                        model.renameShelf(widget.shelf.shelfId ?? 0, newShelf);
                        isEditMode = false;
                      });
                    },
                  ),
            const Divider(
              color: GREY_COLOR,
              thickness: 0.5,
            ),
            SizedBox(
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
                        itemCount: dummyChipLabels.length + 1,
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
                                    for (int i = 0;
                                        i < chipIsSelected.length;
                                        i++) {
                                      setState(() {
                                        chipIsSelected[i] = false;
                                        isShowClearButton = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: GREY_COLOR),
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
                                side: (chipIsSelected[index])
                                    ? const BorderSide(color: WHITE_COLOR)
                                    : const BorderSide(color: GREY_COLOR),
                                backgroundColor: WHITE_COLOR,
                                selectedColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                                showCheckmark: false,
                                label: Text(
                                  dummyChipLabels[index - 1],
                                ),
                                labelStyle: GoogleFonts.inter(
                                    color: (chipIsSelected[index])
                                        ? WHITE_COLOR
                                        : Colors.black87,
                                    fontWeight: FontWeight.w600),
                                selected: chipIsSelected[index],
                                onSelected: (val) {
                                  setState(() {
                                    chipIsSelected[index] = val;
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
                      _showModalBottomSheet(
                          context, "   Sort by", "Recent", "Title", "Author");
                    },
                    child: const SortButtonView(),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      _showModalBottomSheet(context, "   View as", "List",
                          "Large grid", "Small grid");
                    },
                    child: Icon(
                      (viewTypeValue == 1)
                          ? Icons.view_list_outlined
                          : Icons.view_module_outlined,
                      color: LIGHT_GREY_COLOR,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            (viewTypeValue == 1)
                ? BooksListView(
                    savedBookList: widget.shelf.books,
                  )
                : (viewTypeValue == 2)
                    ? LargeGridView(
                        savedBookList: widget.shelf.books,
                      )
                    : SmallGridView(
                        savedBookList: widget.shelf.books,
                        onTapAddToShelfInMenu: (index) {},
                      )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _navigateToHomePage(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BottomNavigationBarHomePage(),
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
                          color: Colors.black,
                          fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
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
                          color: Colors.black,
                          fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      focusColor: WHITE_COLOR,
                      hoverColor: WHITE_COLOR,
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
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
                          color: Colors.black,
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

class RenameView extends StatelessWidget {
  const RenameView({Key? key, required this.onSubmit}) : super(key: key);

  final Function(String newShelf) onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      // color: GREY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          cursorColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
          cursorHeight: 30,
          cursorWidth: 1,
          onSubmitted: (text) {
            onSubmit(text);
          },
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: LIGHT_THEME_TERTIARY_COLOR, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: LIGHT_THEME_SELECTED_CHIP_COLOR, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
