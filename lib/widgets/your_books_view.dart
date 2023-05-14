import 'package:flutter/material.dart';
import 'package:google_play_book/widgets/small_grid_view.dart';
import 'package:google_play_book/widgets/sorting_views.dart';
import '../data/data_vos/books_vo.dart';
import 'books_list_view.dart';
import 'category_chip_view.dart';
import 'large_grid_view.dart';

class YourBooksView extends StatelessWidget {
  const YourBooksView(
      {Key? key,
      required this.categoryChipLabels,
      required this.isShowClearButton,
      required this.chipSelectedList,
      required this.viewTypeValue,
      required this.savedBookList,
      required this.onTapCategoryChip,
      required this.onTapSortByMenu,
      required this.onTapViewTypeMenu,
        required this.sortByValue,
      required this.onTapClearButtonInChipView,
      required this.onTapAddToShelfInMenu,
      required this.onTapAddToShelfInBookListView})
      : super(key: key);

  final List<String> categoryChipLabels;
  final bool isShowClearButton;
  final List<bool> chipSelectedList;
  final int viewTypeValue;
  final int sortByValue;
  final List<BooksVO>? savedBookList;
  final Function onTapClearButtonInChipView;
  final Function(bool, int) onTapCategoryChip;
  final Function onTapSortByMenu;
  final Function onTapViewTypeMenu;
  final Function(int) onTapAddToShelfInMenu;
  final Function(int) onTapAddToShelfInBookListView;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CategoryChipView(
            categoryChipLabels: categoryChipLabels,
            isShowClearButton: isShowClearButton,
            chipIsSelected: chipSelectedList,
            onTapClearButtonInChipView: () => onTapClearButtonInChipView(),
            onTapCategoryChip: (val, index) {
              onTapCategoryChip(val, index);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SortingViews(
            viewTypeValue: viewTypeValue,
            sortByValue: sortByValue,
            onTapSortByMenu: () => onTapSortByMenu(),
            onTapViewTypeMenu: () => onTapViewTypeMenu(),
          ),
          const SizedBox(
            height: 15,
          ),
          (viewTypeValue == 1)
              ? BooksListView(
                  savedBookList: savedBookList,
                  onTapAddToShelfInBookListView: (index) {
                    Navigator.of(context).pop();
                    onTapAddToShelfInBookListView(index);
                  },
                )
              : (viewTypeValue == 2)
                  ? LargeGridView(savedBookList: savedBookList)
                  : SmallGridView(
                      savedBookList: savedBookList,
                      onTapAddToShelfInMenu: (index) {
                        Navigator.of(context).pop();
                        onTapAddToShelfInMenu(index);
                      }),
        ],
      ),
    );
  }
}
