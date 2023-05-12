import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/blocs/your_books_bloc.dart';
import 'package:google_play_book/pages/add_to_shelf_page.dart';
import 'package:google_play_book/pages/search_page.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/default_app_bar_view.dart';
import 'package:provider/provider.dart';

import '../data/data_vos/shelf_vo.dart';
import '../widgets/tabview_and_divider_view.dart';
import '../widgets/your_books_view.dart';
import '../widgets/your_shelves_vew.dart';
import 'create_shelf_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  YourBooksBloc bloc = YourBooksBloc();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    bloc.clearDisposeNotify();
    super.dispose();
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
                Consumer<YourBooksBloc>(
                  builder: (context, bloc, Widget? child) {
                    return YourBooksView(
                      savedBookList: bloc.savedBookList,
                      categoryChipLabels: bloc.categoryChipLabels,
                      isShowClearButton: bloc.isShowClearButton,
                      chipIsSelected: bloc.chipIsSelected,
                      viewTypeValue: bloc.viewTypeValue,
                      onTapCategoryChip: (val, index) {
                        bloc.setSelectedChipIndex(
                            index: index, isSelected: true);
                        bloc.showClearBtn(value: true);
                      },
                      onTapClearButtonInChipView: () {
                        bloc.setToDefault();
                      },
                      onTapViewTypeMenu: () => _showModalBottomSheetLayoutView(
                        context,
                        "   View as",
                        "List",
                        "Large grid",
                        "Small grid",
                        bloc.viewTypeValue,
                        bloc,
                      ),
                      onTapSortByMenu: () => _showModalBottomSheetSortByView(
                        context,
                        "   Sort by",
                        "Recent",
                        "Title",
                        "Author",
                        bloc,
                        bloc.viewTypeValue,
                      ),
                      onTapAddToShelfInMenu: (index) =>
                          Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddToShelfPage(
                            selectedBook: bloc.savedBookList![index],
                          ),
                        ),
                      ),
                      onTapAddToShelfInBookListView: (index) =>
                          Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddToShelfPage(
                            selectedBook: bloc.savedBookList![index],
                          ),
                        ),
                      ),
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

  Future<dynamic> _showModalBottomSheetLayoutView(
      BuildContext context,
      String title,
      String radioOne,
      String radioTwo,
      String radioThree,
      int value,
      YourBooksBloc bloc) {
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

  Future<dynamic> _showModalBottomSheetSortByView(
      BuildContext context,
      String title,
      String radioOne,
      String radioTwo,
      String radioThree,
      YourBooksBloc bloc,
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
}
