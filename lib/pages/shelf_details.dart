import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/blocs/shelf_details_bloc.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';
import 'package:google_play_book/pages/bottom_navigation_bar_home_page.dart';
import 'package:google_play_book/widgets/menu_option_view.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';
import 'package:google_play_book/widgets/your_books_view.dart';
import 'package:provider/provider.dart';
import '../data/data_vos/books_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';

class ShelfDetails extends StatefulWidget {
  const ShelfDetails({Key? key, required this.shelf}) : super(key: key);
  final ShelfVO shelf;

  @override
  State<ShelfDetails> createState() => _ShelfDetailsState();
}

class _ShelfDetailsState extends State<ShelfDetails> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShelfDetailsBloc(widget.shelf),
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: WHITE_COLOR,
          automaticallyImplyLeading: false,
          title: Consumer<ShelfDetailsBloc>(
            builder: (context, bloc, Widget? child) => AppBarTitleView(
              onTapBack: () => Navigator.of(context).pop(),
              onTapMenu: () => showModalBottomSheetForRenameAndDelete(
                context,
                () {
                  bloc.deleteShelf(widget.shelf.shelfId!);
                  _navigateToHome(context);
                },
                () {
                  bloc.setEditModeToTrue();
                  Navigator.of(context).pop();
                },
              ),
            ),
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
              Consumer<ShelfDetailsBloc>(
                builder: (context, bloc, Widget? child) => !bloc.isEditMode
                    ? NormalView(widget: widget, widgetTwo: widget)
                    : Consumer<ShelfDetailsBloc>(
                        builder: (context, bloc, Widget? child) => RenameView(
                          onSubmit: (newShelf) {
                            bloc.renameShelf(widget.shelf.shelfId!, newShelf);
                            bloc.setEditModeToFalse();
                          },
                        ),
                      ),
              ),
              const Divider(
                color: GREY_COLOR,
                thickness: 0.5,
              ),
              Consumer<ShelfDetailsBloc>(
                builder: (context, bloc, Widget? child) => YourBooksView(
                    categoryChipLabels: bloc.categoryChipLabels,
                    isShowClearButton: bloc.isShowClearButton,
                    chipSelectedList: bloc.selectedChipsList,
                    viewTypeValue: bloc.viewTypeValue,
                    savedBookList: bloc.booksInShelf,
                    onTapCategoryChip: (val, index) {
                      bloc.setSelectedChipIndex(index: index, isSelected: true);
                      bloc.showClearBtn(value: true);
                    },
                    onTapSortByMenu: () => showModalBottomSheetSortByView(
                        context,
                        "   View as",
                        "Recent",
                        "Title",
                        "Author",
                        bloc,
                        bloc.viewTypeValue),
                    onTapViewTypeMenu: () => showModalBottomSheetLayoutView(
                          context,
                          "   View as",
                          "List",
                          "Large grid",
                          "Small grid",
                          bloc.viewTypeValue,
                          bloc,
                        ),
                    onTapClearButtonInChipView: () {
                      bloc.setToDefault(widget.shelf);
                    },
                    onTapAddToShelfInMenu: (index) {},
                    onTapAddToShelfInBookListView: (index) {}),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const BottomNavigationBarHomePage()));
  }

  Future<dynamic> showModalBottomSheetForRenameAndDelete(
      BuildContext context, Function onTapDelete, Function onTapRename) {
    return showModalBottomSheet(
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
                onTap: () => onTapRename(),
                child: const MenuOptionsView(
                    menuIcon: Icons.mode_edit_outline_outlined,
                    menuName: "Rename shelf"),
              ),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () => onTapDelete(),
                  child: const MenuOptionsView(
                      menuIcon: Icons.delete_outline_sharp,
                      menuName: "Delete shelf"))
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showModalBottomSheetLayoutView(
      BuildContext context,
      String title,
      String radioOne,
      String radioTwo,
      String radioThree,
      int value,
      ShelfDetailsBloc bloc) {
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
                      key: const ValueKey("ViewTypeRadioOne"),
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                      value: 1,
                      groupValue: value,
                      onChanged: (val) {
                        bloc.setViewTypeValue(val: val ?? 0);
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
                      key: const ValueKey("ViewTypeRadioTwo"),
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                      value: 2,
                      groupValue: value,
                      onChanged: (val) {
                        bloc.setViewTypeValue(val: val ?? 0);
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
                      key: const ValueKey("ViewTypeRadioThree"),
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                      value: 3,
                      groupValue: value,
                      onChanged: (val) {
                        bloc.setViewTypeValue(val: val ?? 0);
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

  Future<dynamic> showModalBottomSheetSortByView(
      BuildContext context,
      String title,
      String radioOne,
      String radioTwo,
      String radioThree,
      ShelfDetailsBloc bloc,
      int value) {
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
                      key: const ValueKey("SortByRadioOne"),
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                      value: 1,
                      groupValue: value,
                      onChanged: (val) {
                        bloc.sortBookByType(val: val ?? 0);
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
                      key: const ValueKey("SortByRadioTwo"),
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                      value: 2,
                      groupValue: value,
                      onChanged: (val) {
                        bloc.sortBookByType(val: val ?? 0);
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
                      key: const ValueKey("SortByRadioThree"),
                      activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                      value: 3,
                      groupValue: value,
                      onChanged: (val) {
                        bloc.sortBookByType(val: val ?? 0);
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

  Future<dynamic> _navigateToHomePage(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BottomNavigationBarHomePage(),
      ),
    );
  }
//
// Future<dynamic> _showModalBottomSheet(BuildContext context, String title,
//     String radioOne, String radioTwo, String radioThree) {
//   return showModalBottomSheet(
//     context: (context),
//     builder: (context) => Container(
//       color: WHITE_COLOR,
//       height: 230,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10, top: 20.0),
//         child: Theme(
//           data: Theme.of(context).copyWith(
//               unselectedWidgetColor: Colors.black,
//               disabledColor: Colors.blue),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.inter(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Divider(
//                 color: Colors.grey,
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
//                     value: 1,
//                     groupValue: viewTypeValue,
//                     onChanged: (val) {
//                       setState(() {
//                         viewTypeValue = val ?? 0;
//                       });
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   Text(
//                     radioOne,
//                     style: GoogleFonts.inter(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                         fontSize: 14),
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
//                     value: 2,
//                     groupValue: viewTypeValue,
//                     onChanged: (val) {
//                       setState(() {
//                         viewTypeValue = val ?? 0;
//                       });
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   Text(
//                     radioTwo,
//                     style: GoogleFonts.inter(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                         fontSize: 14),
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     focusColor: WHITE_COLOR,
//                     hoverColor: WHITE_COLOR,
//                     activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
//                     value: 3,
//                     groupValue: viewTypeValue,
//                     onChanged: (val) {
//                       setState(() {
//                         viewTypeValue = val ?? 0;
//                       });
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   Text(
//                     radioThree,
//                     style: GoogleFonts.inter(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                         fontSize: 14),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
}

class NormalView extends StatelessWidget {
  const NormalView({
    Key? key,
    required this.widget,
    required this.widgetTwo,
  }) : super(key: key);

  final ShelfDetails widget;
  final ShelfDetails widgetTwo;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextView(
              text: "${widget.shelf.books?.length ?? 0} books",
              fontColor: GREY_COLOR,
            ),
          ),
          const SizedBox(
            height: 8,
          )
        ],
      );
  }
}

class AppBarTitleView extends StatelessWidget {
  const AppBarTitleView(
      {Key? key, required this.onTapBack, required this.onTapMenu})
      : super(key: key);

  final Function onTapBack;
  final Function onTapMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => onTapBack(),
          child: const IconView(
              icon: Icons.keyboard_arrow_left,
              iconColor: APP_PRIMARY_COLOR,
              iconSize: 33),
        ),
        const Spacer(),
        InkWell(
          onTap: () => onTapMenu(),
          child: const IconView(
              icon: Icons.more_horiz,
              iconColor: APP_PRIMARY_COLOR,
              iconSize: 25),
        ),
      ],
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
