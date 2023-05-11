import 'package:flutter/material.dart';
import '../data/data_vos/books_vo.dart';
import '../pages/library_page.dart';

class YourBooksView extends StatelessWidget {
  const YourBooksView(
      {Key? key,
        required this.categoryChipLabels,
        required this.isShowClearButton,
        required this.chipIsSelected,
        required this.viewTypeValue,
        required this.savedBookList,
        required this.onTapCategoryChip,
        required this.onTapSortByMenu,
        required this.onTapViewTypeMenu,
        required this.onTapClearButtonInChipView,
        required this.onTapAddToShelfInMenu,
        required this.onTapAddToShelfInBookListView})
      : super(key: key);

  final List<String> categoryChipLabels;
  final bool isShowClearButton;
  final List<bool> chipIsSelected;
  final int viewTypeValue;
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
            chipIsSelected: chipIsSelected,
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
            onTapSortByMenu: () => onTapSortByMenu(),
            onTapViewTypeMenu: () => onTapViewTypeMenu(),
          ),
          const SizedBox(
            height: 15,
          ),
          (viewTypeValue == 1)
              ? BooksListView(
            savedBookList: savedBookList,
            onTapAddToShelfInBookListView: (index) => onTapAddToShelfInBookListView(index),
          )
              : (viewTypeValue == 2)
              ? LargeGridView(savedBookList: savedBookList)
              : SmallGridView(
            savedBookList: savedBookList,
            onTapAddToShelfInMenu: (index) =>
                onTapAddToShelfInMenu(index),
          ),
        ],
      ),
    );
  }
}