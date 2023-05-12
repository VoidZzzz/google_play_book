import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/blocs/your_books_bloc.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';
import 'package:google_play_book/pages/add_to_shelf_page.dart';
import 'package:google_play_book/pages/search_page.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/default_app_bar_view.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';
import 'package:provider/provider.dart';

import '../data/data_vos/books_vo.dart';
import '../widgets/modal_bottom_sheet_for_menu.dart';
import '../widgets/tabview_and_divider_view.dart';
import '../widgets/your_books_view.dart';
import '../widgets/your_shelves_vew.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YourBooksBloc(),
      child: SafeArea(
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
                Selector<YourBooksBloc, List<String>>(
                  shouldRebuild: (previous, next) => previous != next,
                  selector: (BuildContext context, bloc) =>
                      bloc.categoryChipLabels,
                  builder: (context, categoryChipLabels, Widget? child) {
                    final bloc =
                        Provider.of<YourBooksBloc>(context, listen: false);
                    return Selector<YourBooksBloc, List<bool>>(
                      shouldRebuild: (previous, next) => previous != next,
                      selector: (BuildContext context, bloc) =>
                          bloc.chipIsSelected,
                      builder: (context, chipIsSelected, Widget? child) {
                        return Selector<YourBooksBloc, List<BooksVO>?>(
                          shouldRebuild: (previous, next) => previous != next,
                          selector: (BuildContext context, bloc) =>
                              bloc.savedBookList,
                          builder: (context, savedBookList, Widget? child) {
                            return Selector<YourBooksBloc, bool>(
                              shouldRebuild: (previous, next) =>
                                  previous != next,
                              selector: (BuildContext context, bloc) =>
                                  bloc.isShowClearButton,
                              builder:
                                  (context, isShowClearButton, Widget? child) {
                                return Selector<YourBooksBloc, int>(
                                  shouldRebuild: (previous, next) =>
                                      previous != next,
                                  selector: (BuildContext context, bloc) =>
                                      bloc.viewTypeValue,
                                  builder:
                                      (context, viewTypeValue, Widget? child) {
                                    return YourBooksView(
                                      savedBookList: savedBookList,
                                      categoryChipLabels: categoryChipLabels,
                                      isShowClearButton: isShowClearButton,
                                      chipIsSelected: chipIsSelected,
                                      viewTypeValue: viewTypeValue,
                                      onTapCategoryChip: (val, index) {
                                        /// category
                                      },
                                      onTapClearButtonInChipView: () {
                                        /// clear
                                      },
                                      onTapViewTypeMenu: () =>
                                          _showModalBottomSheet(
                                              context,
                                              "   View as",
                                              "List",
                                              "Large grid",
                                              "Small grid",
                                              bloc),
                                      onTapSortByMenu: () =>
                                          _showModalBottomSheet(
                                              context,
                                              "   Sort by",
                                              "Recent",
                                              "Title",
                                              "Author",
                                              bloc),
                                      onTapAddToShelfInMenu: (index) =>
                                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => AddToShelfPage(
                                            selectedBook: savedBookList![index],
                                          ),
                                        ),
                                      ),
                                      onTapAddToShelfInBookListView: (index) =>
                                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => AddToShelfPage(
                                            selectedBook: savedBookList![index],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Selector<YourBooksBloc, List<ShelfVO>?>(
                  shouldRebuild: (previous, next) => previous != next,
                  selector: (BuildContext context, bloc) => bloc.shelfList,
                  builder: (context, shelfList, Widget? child) {
                    return YourShelvesView(
                      shelfList: shelfList,
                      onTapCreateNewShelf: () =>
                          _navigateToCreateNewShelf(context),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToCreateNewShelf(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateShelfPage(),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context, String title,
      String radioOne, String radioTwo, String radioThree, YourBooksBloc bloc) {
    return showModalBottomSheet(
      context: (context),
      builder: (context) => ChangeNotifierProvider(
        create: (context) => YourBooksBloc(),
        child: Selector<YourBooksBloc, int>(
            shouldRebuild: (previous, next) => previous != next,
            selector: (BuildContext context, bloc) => bloc.viewTypeValue,
            builder: (context, viewTypeValue, Widget? child) {
              return Container(
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
                              activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                              value: 2,
                              groupValue: viewTypeValue,
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
                              activeColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                              value: 3,
                              groupValue: viewTypeValue,
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
              );
            }),
      ),
    );
  }
}











